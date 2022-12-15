using MyJuliaPackage
using Documenter


DocMeta.setdocmeta!(MyJuliaPackage, :DocTestSetup, :(using MyJuliaPackage); recursive=true)

makedocs(;
    modules=[MyJuliaPackage],
    authors="Shawn Monel <smonel@mit.edu> and contributors",
    repo="https://github.com/smonel/Julia-Project.jl/blob/{commit}{path}#{line}",
    sitename="MyJuliaPackage.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://smonel.github.io/MyJuliaPackage.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=["Home" => "index.md", "API reference" => "api.md"],
)

deploydocs(repo="github.com/smonel/Julia-Project.jl", devbranch="main")
