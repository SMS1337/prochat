--this is a module

local ClassGetter = {} --Psuedo OOP written by YAYZMAN23

ClassGetter["NumberOfClasses"] = 0

function getclasses(ctable)
	for i=1, #ctable do
		if ctable[i]:IsA("ModuleScript") then
			if ctable[i].Name ~= "NumberOfClasses" then
				ClassGetter[ctable[i].Name] = require(ctable[i])
				ClassGetter["NumberOfClasses"] = ClassGetter["NumberOfClasses"]+1
			else
				local testservice = game:GetService("TestService")
				testservice:Error("Welp, you did it. You managed to try to load an object with the ONE name that would break the ClassGetter script.")
				testservice:Error("Congratulations, have a pretty pink pony.")
				testservice:Fail([[Error in ClassGetter
                                .--.._ 
              _...__         ./'      '\. 
         .-'''      ''-._.._.|           \ 
        /               /\   V            | 
       |               |  )               /.-'''-. 
       |       ..-----. \/               ''       \ 
        \    /       . ''\                         \ 
         \   |      \_\_| \   .----..       ..-\    | 
      |\.. \  \     /'_|  /'''       ''\ /''    |   | 
       \       \  / /'/                 '     / |   | 
        '''---'' / /\/                       / /    / 
                | \./     .-'''''-.__.      ' /    /  
            /''---'     /'.''   /''\__.      /   .''.. 
           |  .'      / /      |   |__..---/..        \            __ 
            \.._./|  | |     '  ''' /                 |     .-'''''  ''''-. 
                 /    \ \    __./  /                  / ..-'               '. 
                '.      ''''| \ \ |                  / /   .---''''''--.     \ 
                  '-..__       /''|'-.    .______.-''/   .'              \    | 
                        ''/'  |    \__\    '.       /  /                  |   |.-''''-. 
                         /    _\.            \.__  / /     .-''           |  /'        \ 
                        /  .''               /   \/ /  .-'' /            /              \ 
                       /   |    .__      _..'( )    \/'    |            /.-----.         | 
                      |     \    \.''''''    '^'     |      |                    \       | 
                      |      ''-.___.>    ( )   (  ) |      \                     |     / 
                 ..--''\                .  '^'  '^'  |       \     .-'''''-.      |    / 
     _...---'''''       '.  .            \          /         '-.<'.      ./     /    / 
 \'''                   .-'/     /      _..\       /.'.         /   ''''''      / .-'' 
  \                _.-''  /     /'----'' \   \    '    \       /            .-'      '\ 
   \           .-''     /       /          \   '\       \     |        .--''           | 
    '\.   _.-''        /       /             \   \        \   |         \     ..       | 
       '''           /        /                \  \        \   \         |  |'  '\    / 
                   /         /                  \  \        \   \        |   ''---.\-' 
                  /          /                   |  |        |    '-..__/   ..      |  . 
                /           /                    |  |        |          '''/     .-'  /| 
               /           /                    /   |         |            |    ''''''/ 
             /_         _./                    /___/          |             '-.____.-' 
               '''''''''                          /.._______..| ]])
				PinkieKnowsHowToParty("Really Hard") --a comical way to haul execution
			end
		end
		getclasses(ctable[i]:GetChildren())
	end
end

children = script:GetChildren()
getclasses(children)

return ClassGetter
