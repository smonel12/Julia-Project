using Aqua
using Documenter
using MyJuliaPackage
using JuliaFormatter
using Test

DocMeta.setdocmeta!(MyJuliaPackage, :DocTestSetup, :(using MyJuliaPackage); recursive=true)

@testset verbose = true "MyJuliaPackage.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(MyJuliaPackage; ambiguities=false)
    end

    @testset verbose = true "Code formatting (JuliaFormatter.jl)" begin
        @test format(MyJuliaPackage)
    end

    @testset verbose = true "Doctests (Documenter.jl)" begin
        doctest(MyJuliaPackage)
    end

    @testset verbose = true "Get upper bound" begin
        total = find_upper_bound()
    end

    @testset verbose = true "Small instance" begin
        input_path = joinpath(@__DIR__, "data", "example_input.txt")
        output_path = joinpath(@__DIR__, "data", "example_output.txt")
        city = read_problem(input_path)
        solution = read_solutions(city, output_path)
        open(output_path, "r") do file
            @test string(solution) == read(file, String)
        end
        @test solution.feasible
        @test solution.total == 450
    end

    @testset verbose = true "Get Best Path" begin
        input_path = joinpath(@__DIR__, "data", "example_input.txt")
        output_path = joinpath(@__DIR__, "data", "example_output.txt")
        city = read_problem(input_path)
        path, duration = find_best_path(
            2,
            2,
            0,
            city.total_duration,
            city.streets,
            city.visited,
            city.neighboring_streets,
            city.start_point,
        )
        @test path == [1, 2, 3]
    end

    @testset verbose = true "Large instance" begin
        city = read_problem()
        solution = greedy_algo(city)
        @test city.total_duration == 54000
        @test solution.feasible
    end
end
