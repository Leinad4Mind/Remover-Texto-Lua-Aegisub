--[[
 Copyright (c) 2012, Leinad4Mind
 All rights reserved®.
 
 Baseado em diversos scripts
 
 Um grande agradecimento a todos os meus amigos
 que sempre me apoiaram, e a toda a comunidade
 de anime portuguesa.
--]]

--Descrição da Macro
   script_name = "Remover Texto"
   script_description = "Remove o texto das linhas por estilo ou personagem"
   script_author = "Leinad4Mind"
   script_version = "3.0"

--GUI
	local conf_t = {
	[0] = { class = "label"; x = 0; y = 0; height = 1; width = 4; label = " ...| Desenvolvido por Leinad4Mind |... " }
	,
	[1] = { class = "label"; x = 0; y = 1; height = 1; width = 4; label = " ~ Remover texto por estilo ou personagem ~ " }
	,
	[2] = { name = "escolha"; class = "dropdown"; x = 1; y = 2; height = 1; width = 3; items = {}; value = ""}
	,
	[3] = { class = "label"; x = 0; y = 2; height = 1; width = 1; label = " Seleccionar Estilo: " }
	,
	[4] = { name = "escolh"; class = "dropdown"; x = 1; y = 3; height = 1; width = 3; items = {}; value = ""}
	,
	[5] = { class = "label"; x = 0; y = 3; height = 1; width = 1; label = " Seleccionar Personagem: " }
	}

-- Funções
	function remx_tag(subtitles,config)
		for i = 1, #subtitles do
			local l =subtitles[i]
			if l.style ~= "" then
				if l.style == config.escolha then
					l.text = string.format("")
				end
			end
			if l.actor ~= "" then
				if l.actor  == config.escolh then
					l.text = string.format("")
				end
			end
                subtitles[i] = l
		end
	end

   function add_tags(styles, subtitles)
        --# Estilo
         conf_t[2].items = {}
         local estilo = {}
         for i = 1, #subtitles do
         linha = subtitles[i]
	if  linha.class == "dialogue" and not  linha.comment then
	           if  linha.style ~= "" and not estilo[linha.style] then estilo[linha.style] = true
	           table.insert(conf_t[2].items,linha.style )	
	          end
	end
         end
         --# Personagem
         conf_t[4].items = {}
         local estilo = {}
         for i = 1, #subtitles do
         linha = subtitles[i]
	if  linha.class == "dialogue" and not  linha.comment then
			if  linha.actor ~= "" and not estilo[linha.actor] then estilo[linha.actor] = true
	           table.insert(conf_t[4].items,linha.actor)
			end
	end 
         end
   end

   function Remover_Txt(subtitles, config)
        local subs = {}
             --# Estilo
             for i = 1, #subtitles do
                       linha = subtitles[i]
	     if linha.class == "dialogue" and not linha.comment  and  linha.style == config.escolha  then
			if linha.style ~= "" then
	                 table.insert(subs, i, config)
			end
	    end	  

	     if linha.class == "dialogue" and not linha.comment  and  linha.actor == config.escolh  then
			if linha.actor ~= "" then
	                 table.insert(subs, i, config)
			end
					
	    end	  
             end
       remx_tag(subtitles,config,subs )	
 end

   function load_macro_add(subtitles)                   
	add_tags(styles, subtitles)
	remx, config = aegisub.dialog.display(conf_t,{"Remover","Cancelar"})	
	if remx == "Remover" then
		Remover_Txt(subtitles, config)
		aegisub.set_undo_point(script_name)
	end
   end

aegisub.register_macro(script_name,script_description,load_macro_add)