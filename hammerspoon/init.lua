function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end

function topFocus(app)
	-- get screen where you are with your mouse
	local screen = hs.mouse.getCurrentScreen()
	-- get main window
	local app_window = app:mainWindow()
	-- move app to current screen
	app_window:moveToScreen(screen)
	-- get max coordinates
	local max = screen:fullFrame()
	-- get main window frame
	local f = app_window:frame()
	-- set dimension of frame
	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h * 0.55 -- 55% of max height
	-- set new frame dimension after a little delay
	hs.timer.doAfter(0.2, function()
		app_window:setFrame(f)
	end)
	-- focus to app
	app_window:focus()
end

function bindHotkey(appName, key)
  -- bind to CTRL + key
	hs.hotkey.bind({ "alt" }, key, function()
		-- find app
		local app = hs.application.find(appName)
		-- if app is running
		if app then
			-- if app is on front
			if app:isFrontmost() then
				-- hide app
				app:hide()
			else
				-- launch function to resize window and focus
				topFocus(app)
			end
		else
			-- launch app
			app = hs.application.open(appName, 2, true)
			-- launch function to resize window and focus
			topFocus(app)
		end
	end)
end

-- Configuration reloading
hs.pathwatcher.new(os.getenv("HOME") .. "/.dotfiles/hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

-- Open terminal
bindHotkey("com.github.wez.wezterm", "`")
