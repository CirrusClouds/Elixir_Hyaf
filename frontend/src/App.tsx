import React from 'react';
import {
  BrowserRouter,
  Routes,
  Route
} from 'react-router-dom';
import './App.css';
import Homepage from './homepage';
import WorldMap from './map';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Homepage />} />
        <Route path="/map" element={<WorldMap />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
