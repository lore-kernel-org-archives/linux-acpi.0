From: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Sun, 08 Jan 2006 14:13:52 +0000
Message-ID: <1136729632.2444.36.camel@localhost>
References: <20060107172446.GA3092@srcf.ucam.org>
	 <1136725124.2444.26.camel@localhost> <20060108134744.GA21538@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060108134744.GA21538-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, 2006-01-08 at 13:47 +0000, Matthew Garrett wrote:
> On Sun, Jan 08, 2006 at 12:58:44PM +0000, Richard Hughes wrote:
> 
> > Can we not go further and define Dock/UnDock,
> > BrightnessUp/BrightnessDown, Hibernate, etc?
> 
> BrightnessUp/BrightnessDown have keycodes defined in 
> /usr/src/linux/input.h, so that shouldn't be a problem. I suggested a 
> keycode for hibernate (KEY_SUSPEND, with suspend to RAM on KEY_SLEEP). 

Okay, that's good for me.

> I'm less convinced about Dock/Undock - that's a problem that's so far 
> from being solved I've no idea what sort of things userspace wants to 
> know :)

Sure, just an example of "other stuff". Lock is maybe a better example
as gnome-screensaver (or equiv) can respond to this.

The main problem now is implementation.

1. We use the current hodge-podge of methods now (like sony-pi, toshiba,
asus, raw etc) and define backends for all these modules.

2. We use the raw acpi device like Ubuntu do (exposes /dev/acpi) -- Is
this a long term solution? And this requires a kernel patch that I think
the linux-acpi people are unhappy with, and distros such as Fedora
wouldn't like (due to not being in vanilla kernel).

3. Use the new acpi kernel hotkeys stuff -- not that I really understand
the interface, nor how to use it correctly. Plus I'm not sure how much
of the vendor kernel modules can use this new interface, or if it's
suitable. It all seemed a bit fragile last time I looked.

Richard.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
