From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Mon, 9 Jan 2006 00:07:43 -0500
Message-ID: <200601090007.43578.dtor_core@ameritech.net>
References: <20060107172446.GA3092@srcf.ucam.org> <1136729632.2444.36.camel@localhost> <1136769294.3059.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1136769294.3059.12.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 08 January 2006 20:14, Richard Hughes wrote:
> On Sun, 2006-01-08 at 14:13 +0000, Richard Hughes wrote:
> > On Sun, 2006-01-08 at 13:47 +0000, Matthew Garrett wrote:
> > > On Sun, Jan 08, 2006 at 12:58:44PM +0000, Richard Hughes wrote:
> > > 
> > > > Can we not go further and define Dock/UnDock,
> > > > BrightnessUp/BrightnessDown, Hibernate, etc?
> > > 
> > > BrightnessUp/BrightnessDown have keycodes defined in 
> > > /usr/src/linux/input.h, so that shouldn't be a problem. I suggested a 
> > > keycode for hibernate (KEY_SUSPEND, with suspend to RAM on KEY_SLEEP). 
> > 
> > Okay, that's good for me.
> > 
> > > I'm less convinced about Dock/Undock - that's a problem that's so far 
> > > from being solved I've no idea what sort of things userspace wants to 
> > > know :)
> > 
> > Sure, just an example of "other stuff". Lock is maybe a better example
> > as gnome-screensaver (or equiv) can respond to this.
> > 
> > The main problem now is implementation.
> 
> Further to the conversation on IRC, I've attached two ACPI patches to
> provoke discussion.
> 
> The first creates the /org/freedesktop/Hal/devices/acpi_uinput like I
> did for the toshiba specific HAL addon.
> The second uses the acpi events for creating uinput events that can be
> captured using gnome-keybindings, and also creates HAL ButtonPressed
> events so that DBUS aware applications (like g-v-m and g-p-m) can
> monitor the events.
>

I am sorry, but the scheme

	acpi->acpid->hal?->uinput->input_core->keyboard->...>userspace

is way too crazy.

Why don't we create an input handler that would feed certain events
from input layer to acpid via bus_acpi_generate_event(). This will
allow grateful migration of acpi buttons and other stuff to use
input layer:

	acpi->input_core->[new handler]->acpid


In the mean time hal can start using /dev/input/eventX to get those
events.

-- 
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
