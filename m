From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 09 Jan 2006 09:43:28 +0000
Message-ID: <1136799809.19776.11.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
	 <1136729632.2444.36.camel@localhost> <1136769294.3059.12.camel@localhost>
	 <200601090007.43578.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200601090007.43578.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2006-01-09 at 00:07 -0500, Dmitry Torokhov wrote: 
> On Sunday 08 January 2006 20:14, Richard Hughes wrote:
> > On Sun, 2006-01-08 at 14:13 +0000, Richard Hughes wrote:
> > > On Sun, 2006-01-08 at 13:47 +0000, Matthew Garrett wrote:
> > > > On Sun, Jan 08, 2006 at 12:58:44PM +0000, Richard Hughes wrote:
> > > > 
> > > > > Can we not go further and define Dock/UnDock,
> > > > > BrightnessUp/BrightnessDown, Hibernate, etc?
> > > > 
> > > > BrightnessUp/BrightnessDown have keycodes defined in 
> > > > /usr/src/linux/input.h, so that shouldn't be a problem. I suggested a 
> > > > keycode for hibernate (KEY_SUSPEND, with suspend to RAM on KEY_SLEEP). 
> > > 
> > > Okay, that's good for me.
> > > 
> > > > I'm less convinced about Dock/Undock - that's a problem that's so far 
> > > > from being solved I've no idea what sort of things userspace wants to 
> > > > know :)
> > > 
> > > Sure, just an example of "other stuff". Lock is maybe a better example
> > > as gnome-screensaver (or equiv) can respond to this.
> > > 
> > > The main problem now is implementation.
> > 
> > Further to the conversation on IRC, I've attached two ACPI patches to
> > provoke discussion.
> > 
> > The first creates the /org/freedesktop/Hal/devices/acpi_uinput like I
> > did for the toshiba specific HAL addon.
> > The second uses the acpi events for creating uinput events that can be
> > captured using gnome-keybindings, and also creates HAL ButtonPressed
> > events so that DBUS aware applications (like g-v-m and g-p-m) can
> > monitor the events.
> >
> 
> I am sorry, but the scheme
> 
> 	acpi->acpid->hal?->uinput->input_core->keyboard->...>userspace
> 

HAL does not require acpid to be running as it can listen to the socket
directly. Using HAL allows us to emit a ButtonPressed DBUS event for
session/system applications to listen for (like gnome-volume-manager and
gnome-power-manager) and also could use uinput so that stuff like the
"mute" hotkey can be caught by gnome-keybinding-properties so that the
session action could be taken.

So the call chain would look like this:

acpi->hal->gnome-volume-manager                (ButtonPressed)
acpi->hal->uinput->input_core->keyboard->g-k-p (uinput)

Plus, doing all the processing user-side, we can put the policy in HAL
(saying that hkey 0x140 is KEY_BRIGHTNESSDOWN), meaning we don't have to
update the kernel for every new laptop hotkey layout change.

> Why don't we create an input handler that would feed certain events
> from input layer to acpid via bus_acpi_generate_event(). This will
> allow grateful migration of acpi buttons and other stuff to use
> input layer:
> 
> 	acpi->input_core->[new handler]->acpid

What if the application wants a DBUS event rather than listening on /dev/input/X?

> In the mean time hal can start using /dev/input/eventX to get those
> events.

So in the kernel you want to put all the policy so that if
laptopmodel=foo and bios=bar and key=0x140 then output
KEY_BRIGHTNESSDOWN?

I've no problem using any input interface with HAL, as long as it's
unified between all the different acpi modules.

Even in the acpi kernel bits, there appears to be about half a dozen
different ways that buttons *could* get to userspace, without any
cooperation from the desktop guys and the kernel guys to an optimal
solution.

Sorry if this sounds a bit like a rant.

Richard.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
