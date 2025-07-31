import './card.css';
//import testImage from '../img/planta.png';


export function Carta() {
  return (
    <div className="absolute inset-0 z-20 flex items-center justify-center px-6 text-center">
      <div className="bg-gray-900/20 backdrop-blur-sm p-8 rounded-2xl shadow-2xl max-w-4xl">
        <h1 className="text-white text-4xl md:text-5xm font-extrabold leading-tight mb-6 drop-shadow-xl transition duration-300">
          Ahorra hasta un <span className="text-teal-300">80%</span> del desperdicio de alimentos comestibles
        </h1>
        <p className="text-gray-100 text-lg md:text-xl font-medium leading-relaxed transition duration-300">
          Rastrea, analiza y reduce automáticamente tus residuos <br/> con la  solución inteligente de <strong className="text-white font-semibold">Effinity</strong>.
        </p>
      </div>
    </div>
  );
}