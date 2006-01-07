From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Untangling the sleep hotkey mess
Date: Sat, 7 Jan 2006 17:24:46 +0000
Message-ID: <20060107172446.GA3092@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Currently, there are three ways that a sleep hotkey may generate an 
event:

1) Exposed in DSDT as an ACPI object, generates an ACPI notification 
event (the "normal" way)

2) Uses hardware-specific ACPI driver, generates an ACPI notification 
event. Not exposed in the DSDT in any standard way (ibm-acpi, 
toshiba-acpi, panasonic-acpi)

3) Generates a scancode, which is picked up by the kernel and turned 
into a keycode (HP laptops work like this)

This is all quite horribly confusing, and makes life miserable for 
userspace. I would like to suggest the following standardisation:

a) Hal should assume that all hardware has a sleep key, since there's no 
way to actually tell.

b) Events generated in cases (1) and (2) should, for now, be caught by 
acpid (or something similar) and then fed back into the input layer via 
uinput. This should be scancode 142, which will end up as X keycode 223.

c) Most keyboards in case (3) will already send scancode 142. For 
laptops, those that shouldn't should be remapped at boot time by 
checking the system DMI information and consulting a lookup table.

Rationale:

Having one type of event rather than three makes it easier for userspace 
coders. Choosing to do it through the input layer lets people take 
advantage of pre-existing code for binding userspace events to keyboard 
events, and is significantly easier to do than getting keyboard events 
back to the ACPI layer. Keycode 142 is chosen because it's what 
Microsoft uses, and so most manufacturers who have taken this approach 
have copied them.

Future:

1) OSDL have just set up a mailing list 
(desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org) for discussion of userspace and 
laptop interaction. Can I encourage people who are interested in 
hammering out cross-distribution solutions to problems like this to 
subscribe?

2) /usr/include/linux/input.h defines two keycodes for suspend-type 
behaviour: KEY_SLEEP (scancode 142) and KEY_SUSPEND (scancode 205). I'd 
like to propose using the second of these for keys that trigger suspend 
to disk. There's much less standardisation here, though, so I'd be 
interested in hearing what other people think.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
