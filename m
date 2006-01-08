From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Sun, 8 Jan 2006 13:47:44 +0000
Message-ID: <20060108134744.GA21538@srcf.ucam.org>
References: <20060107172446.GA3092@srcf.ucam.org> <1136725124.2444.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1136725124.2444.26.camel@localhost>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 08, 2006 at 12:58:44PM +0000, Richard Hughes wrote:

> Can we not go further and define Dock/UnDock,
> BrightnessUp/BrightnessDown, Hibernate, etc?

BrightnessUp/BrightnessDown have keycodes defined in 
/usr/src/linux/input.h, so that shouldn't be a problem. I suggested a 
keycode for hibernate (KEY_SUSPEND, with suspend to RAM on KEY_SLEEP). 
I'm less convinced about Dock/Undock - that's a problem that's so far 
from being solved I've no idea what sort of things userspace wants to 
know :)

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
