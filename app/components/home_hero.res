@react.component
let make = () => {
  <header style={{textAlign: "center"}}>
    <h1> {"The Josh Derocher"->React.string} </h1>
    <h2> {"Web developer. ReScript. Really Hoopy Frood."->React.string} </h2>
    <nav>
      <ul
        style={{
          display: "flex",
          textAlign: "center",
          width: "100%",
          alignItems: "center",
          justifyContent: "center",
        }}>
        <li>
          <a href="https://github.com/jderochervlk"> {"GitHub"->React.string} </a>
        </li>
        <li>
          <a href="mailto:josh@vlk.mozmail.com"> {"Email"->React.string} </a>
        </li>
        <li>
          <a href="https://docs.google.com/document/d/1LVCLUVwIL3EqdUB1avNArEQQtyFP6ffLAU1v7fK_MZw">
            {"Resume"->React.string}
          </a>
        </li>

        //
      </ul>
    </nav>
  </header>
}
