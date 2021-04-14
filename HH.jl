using Plots,DifferentialEquations,LaTeXStrings

##
V(x,y) = (1/2)*(x^2 + y^2 + 2*x^2*y - (2/3)*y^3)
x1 = y1 = range(-1,stop = 1, length = 1000)

##
V(x,y) = (1/2)*(x^2 + y^2 + 2*x^2*y - (2/3)*y^3)
x = y = range(-1,stop = 1, length = 1000)
contourf(x,y,V)
contour!(x,y,V,levels=0:1/6:1,title = "Henon-Heiles potential: Intensity map",linecolor = :white)
# savefig("potential_together.png")


##
function Hénon_Heiles(du,u,p,t)
    x  = u[1]
    y  = u[2]
    dx = u[3]
    dy = u[4]
    du[1] = dx
    du[2] = dy
    du[3] = -x - 2x*y
    du[4] = y^2 - y -x^2
end

plot()
e = 0.0833
for y in -0.2:0.1:0.4
    for ydot in -0.1:0.1:0.2
        # y = 0.02
        # ydot = -0.08
        xdot = sqrt(2*e - ydot^2 - y^2 + (2//3)*y^3)
        initial = [0.0,y,xdot,ydot]
        tspan = (0,500.)
        prob = ODEProblem(Hénon_Heiles, initial, tspan)
        sol = solve(prob, saveat = 0.001,Rodas5());
        Y = [i[2] for i in sol.u if (abs(i[1]) < 9.e-4)];
        Ydot = [i[4] for i in sol.u if (abs(i[1]) < 9.e-4)];
        scatter!(Y,Ydot,xlabel = "y",ylabel = "ẏ",label = false,title = "Poincare section: E = $(e)", titlefont=10,markersize = 2,markercolor = :black)
    end
end
plot!()
##
function Hénon_Heiles(du,u,p,t)
    x  = u[1]
    y  = u[2]
    dx = u[3]
    dy = u[4]
    du[1] = dx
    du[2] = dy
    du[3] = -x - 2x*y
    du[4] = y^2 - y -x^2
end
e = 0.125
y = 0.02
ydot = -0.08
xdot = sqrt(2*e - ydot^2 - y^2 + (2//3)*y^3)
initial = [0.0,y,xdot,ydot]
tspan = (0,500.)
prob = ODEProblem(Hénon_Heiles, initial, tspan)
sol = solve(prob, saveat = 0.001);
plot(sol,vars = (1,2,4))

##