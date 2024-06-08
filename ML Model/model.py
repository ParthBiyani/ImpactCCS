import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error
from keras.models import Sequential
from keras.layers import Dense, LSTM, Bidirectional, Dropout
from keras.callbacks import EarlyStopping

data = pd.read_csv("/content/salesdaily.csv")

data['datum'] = pd.to_datetime(data['datum'], infer_datetime_format=True)

data.set_index('datum', inplace=True)

data = pd.get_dummies(data, columns=['Weekday Name'])

target_column = 'M01AB'
feature_columns = ['M01AE', 'N02BA', 'N02BE', 'N05B', 'N05C', 'R03', 'R06', 'Year', 'Month', 'Hour'] + [col for col in data.columns if 'Weekday Name_' in col]

features = data[feature_columns].values.astype('float32')
target = data[target_column].values.astype('float32').reshape(-1, 1)

scaler_features = MinMaxScaler(feature_range=(0, 1))
scaler_target = MinMaxScaler(feature_range=(0, 1))
scaled_features = scaler_features.fit_transform(features)
scaled_target = scaler_target.fit_transform(target)

def create_dataset(features, target, look_back=1):
    dataX, dataY = [], []
    for i in range(len(target) - look_back):
        dataX.append(features[i:(i + look_back)])
        dataY.append(target[i + look_back])
    return np.array(dataX), np.array(dataY)

look_back = 3
X, y = create_dataset(scaled_features, scaled_target, look_back)

X = np.reshape(X, (X.shape[0], look_back, X.shape[2]))

train_size = int(len(X) * 0.8)
X_train, X_test = X[:train_size], X[train_size:]
y_train, y_test = y[:train_size], y[train_size:]

model = Sequential()
model.add(Bidirectional(LSTM(50, activation='relu', return_sequences=True), input_shape=(look_back, X.shape[2])))
model.add(Dropout(0.2))
model.add(Bidirectional(LSTM(50, activation='relu')))
model.add(Dropout(0.2))
model.add(Dense(1))
model.compile(optimizer='adam', loss='mse')


early_stopping = EarlyStopping(monitor='val_loss', patience=10, restore_best_weights=True)

history = model.fit(X_train, y_train, epochs=300, batch_size=64, verbose=2, validation_data=(X_test, y_test), callbacks=[early_stopping])

train_predict = model.predict(X_train)
test_predict = model.predict(X_test)

train_predict = scaler_target.inverse_transform(train_predict)
y_train = scaler_target.inverse_transform(y_train)
test_predict = scaler_target.inverse_transform(test_predict)
y_test = scaler_target.inverse_transform(y_test)

train_rmse = np.sqrt(mean_squared_error(y_train, train_predict))
test_rmse = np.sqrt(mean_squared_error(y_test, test_predict))
print("Train RMSE:", train_rmse)
print("Test RMSE:", test_rmse)


train_accuracy = 1 - (train_rmse / np.mean(y_train))
test_accuracy = 1 - (test_rmse / np.mean(y_test))
print("Train Accuracy:", train_accuracy)
print("Test Accuracy:", test_accuracy)