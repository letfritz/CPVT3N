# CPVT3N – Modeling in the photovoltaic/thermal concentrator considering a stratified reservoir in 3 levels <img src="https://skillicons.dev/icons?i=matlab" />
<div align="center"><br/>
  <div style="display: inline-block;">
    <img align="center" alt="stars" src="https://img.shields.io/github/stars/letfritz/CPVT3N.svg">
    <img align="center" alt="watchers" src="https://img.shields.io/github/watchers/letfritz/CPVT3N.svg">
    <img align="center" alt="forks" src="https://img.shields.io/github/forks/letfritz/CPVT3N.svg">
  </div>
  <div style="display: inline-block;">
    <img align="center" alt="downloads" src="https://img.shields.io/github/downloads/letfritz/CPVT3N/total.svg">
    <img align="center" alt="issues" src="https://img.shields.io/github/issues/letfritz/CPVT3N/total.svg">
    <img align="center" alt="issues-closed" src="https://img.shields.io/github/issues-closed/letfritz/CPVT3N/total.svg">
    <img align="center" alt="issues-pr" src="https://img.shields.io/github/issues-pr/letfritz/CPVT3N/total.svg">
    <img align="center" alt="issues-pr-closed" src="https://img.shields.io/github/issues-pr-closed/letfritz/CPVT3N/total.svg">
  </div>
</div><br/>

A MATLAB tool to model the operation of a concentrated photovoltaic/thermal (CPV/T) module alongside a stratified reservoir with 3 levels.

## 📷 Screenshot

<img width="916" alt="main" src="https://github.com/letfritz/CPVT3N/assets/161434060/9fc6a469-693a-4d86-b21d-58bdce0c008e">
<img width="914" alt="main2" src="https://github.com/letfritz/CPVT3N/assets/161434060/e6979111-8d71-4bd4-ae38-665edc582743">
<img width="913" alt="information" src="https://github.com/letfritz/CPVT3N/assets/161434060/f62a43ad-bfe8-470c-a582-a35374d2b11a">

## Installation
1. Download the package to a local folder (e.g. ~/CPVT3N/) by running:
   ```
   git clone https://github.com/letfritz/CPVT3N.git
   ```
2. Run Matlab and navigate to the folder (~/CPVT3N/), then run the interface.m script.

## Usage
- Open the file "interface.m" and click "Run" to compile the main interface of the code.
- After user adjustments, simply press the "Iniciar" button to begin the simulation.
- Upon completion, the results will be exported to the "Resultado" folder.

## Tips to Begin
https://github.com/letfritz/CPVT3N/assets/161434060/bd7c398c-839e-4f42-940c-6b7bc21c49f4

## License
Released under MIT license.

## CPVT3N Folder Contents
1. Folders
    - Curve - Folder containing necessary curves for running the program. The files must have the same size and time interval between the data, which should be in minute intervals.
    - Result - Folder with the results generated in the simulation. It contains an Excel file and a workspace with the variables from the last simulation.
2. Files
    - CPVT.m - Iterative code with CPVT simulation.
    - cpvt3n.gif - Program logo image.
    - cpvtinfo.fig - Interface with CPVT and stratified reservoir model.
    - cpvtinfo.m - Interface code with CPVT and stratified reservoir model.
    - errorCurve.fig - Error interface between curve file dimensions.
    - errorCurve.m - Error interface code between curve file dimensions.
    - errorQtdmodulos.fig - Non-integer module quantity error interface.
    - errorQtdmodulos.m - Non-integer module quantity error interface code.
    - getConfigOutput.m - Result matrix creation code.
    - getConsumoAgua.m - Code to identify water demand from each level.
    - getCurva.m - Code that loads input curves into the program.
    - getDifusividade.m - Thermal diffusivity calculation code.
    - getEnergiaEletrica.m - Single CPVT module electrical energy code.
    - getEqAgua.m - Code for water properties calculation at 2 bar.
    - getEstratificacao.m - Reservoir stratification code.
    - getInput.m - Input data loaded with interface information.
    - getOutput.m - Code to export output result matrix.
    - getPrandtl.m - Prandtl number calculation code.
    - getQtdModulos.m - Quantity of modules that fit in a reservoir code.
    - getReservatorio.m - Reservoir variable iterative code.
    - getViscosidade.m - Kinematic viscosity calculation code.
    - info.fig - Interface with general program information.
    - info.m - General program information interface code.
    - interface.fig - Main interface with input data for the program.
    - interface.m - Main interface code with input data for the program.
    - main.m - Main MATLAB code.
    - modeloCPVT.gif - CPVT model image used in the simulation.
    - modeloRes.gif - Image of the 3-level stratified reservoir model used in the simulation.
    - morecpvt.fig - Interface with information about CPV/T input data.
    - morecpvt.m - CPV/T input data information interface code.
    - moreRes.fig - Interface with information about Reservoir and Curve input data.
    - moreRes.m - Reservoir and Curve input data information interface code.

## 📝 About this Project
The CPVT3N is an open-source software, where the main functionality is to model the operation of a concentrated photovoltaic/thermal (CPV/T) module alongside a stratified reservoir with 3 levels. The model utilizes concepts of heat transfer and fluid mechanics for the cooling of the photovoltaic cell, allowing to increase the energy efficiency of the system. The tool operates the system according to input data provided by the user, such as temperature curve, water consumption, and direct normal radiation. Thus, the model allows easy adaptation to various refrigerant fluids, other CPV/T module topologies, and studies in different simulation horizons. The results generated by the software are exported in xlsx format, containing powers generated by the CPV/T module and temperatures of the collector outlet, photovoltaic cell, plate, and the three stratified levels of the reservoir.

See more in [![Blog](https://img.shields.io/website?label=myCPVTpaper.com&url=https://www.sciencedirect.com/science/article/abs/pii/S0196890420309201?via%3Dihub)](https://www.sciencedirect.com/science/article/abs/pii/S0196890420309201?via%3Dihub)

## 💡 Tool Innovation
Currently, concentrated photovoltaic/thermal (CPV/T) technology has been gaining visibility in literature and in prototype validation operational environment applications. However, the sizing of this equipment, which is recently entering the market, requires an iterative model that takes into account fluid mechanics and heat transfer, as it is sensitive to weather conditions. Therefore, CPVT3N aims to facilitate the analysis of CPV/T technology alongside a stratified reservoir as interactions between the system and the environment are considered over time. In this sense, this program presents as its main innovations the fact that it is a free, open-source model, programmed in MATLAB, with a user-friendly interface and systematically commented code, allowing users with intermediate knowledge of the model to apply improvements and add new functionalities to the system. Furthermore, due to its user-friendly interface and responsiveness to input data, users interested solely in analyzing the operation of CPV/T technology can perform various simulations under different environmental conditions and usage of the stratified reservoir. Additionally, the tool includes technical data on heat losses from the constructive aspects of the reservoir and properties of the refrigerant fluid of the CPV/T collector, which vary with temperature. These data reflect in a precise model of reservoir stratification, which is performed in 3 levels of equal volume. Thus, we understand CPVT3N as a useful tool both to facilitate the development of new CPV/T technologies in the industry and for academic studies that consider precise and environmentally sensitive models of operation, covering an existing gap in tooling with data richness.

## ⚙️ Advantages and Solutions Provided by the Tool
Free and open-source tool, targeting technical and academic audiences, which can serve, for instance, as a solution to enable undergraduate and graduate students to develop an analysis of the concentrated photovoltaic/thermal system responsive to climatic data and reservoir utilization associated with this technology. Furthermore, the simulated results from this program can serve as a basis for constructing prototypes that operate in real environments and even facilitate the entry of concentrated photovoltaic/thermal technology into the market. Among its main advantages is the fact that the tool is developed in MATLAB, a computational environment widely used in academia, allowing advanced users to refine the model and incorporate future functionalities.

## 🧭 Present and Future use of the Invention
The combined heat and power tool through the CPV/T collector presented here aims to provide studies estimating the operation of a system composed of a CPV/T module and a reservoir sensitive to the operational conditions of the environment in which the system is deployed. Therefore, cogeneration operation studies with CPV/T and reservoir utilize the iterative model of this tool to depict the production of electrical and thermal energy and the use of the reservoir for providing heated water through reservoir stratification. The findings serve as inputs for CPV/T technology projects, prototype development, and economic feasibility studies. We see this as a promising model with significant future applications, as it allows for a variety of input data and can represent operational conditions of a new technology in the market. The current version already enables users to input data for direct normal radiation, reservoir water consumption, ambient temperature, and suitable water usage temperature over different time horizons.

  
