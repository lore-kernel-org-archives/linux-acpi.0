From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [mjg@redhat.com: [PATCH] From: Rezwanul Kabir <Rezwanul_Kabir@dell.com>]
Date: Mon, 2 Nov 2009 20:05:25 -0800
Message-ID: <20091103040525.GY25713@hexapodia.org>
References: <20091102174748.GA21342@srcf.ucam.org> <20091103034212.GF31712@vmware.com> <20091102174748.GA21342@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from straum.hexapodia.org ([64.81.70.185]:7950 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757883AbZKCEFV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2009 23:05:21 -0500
Content-Disposition: inline
In-Reply-To: <1257181242-4952-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

> > dell-wmi: Add support for new Dell systems
> > 
> > Newer Dell systems support HotKey features differently from legacy
> > systems.  A new vendor specifc HotKey SMBIOS table (Type 0xB2) is

[snip]

I get improved, but still not flawless, behavior with this patch,
testing on my Dell E4300 with bios A05 (tested on top of approximately
Ubuntu's 2.6.31-14.47 which is more or less 2.6.31.4).

[    7.068589] input: Dell WMI hotkeys as /devices/virtual/input/input8
[  621.845305] dell-wmi: Received unknown WMI event 0x11
[ 1580.825651] dell-wmi: Received unknown WMI event 0x11
[ 1585.239914] dell-wmi: Received unknown WMI event 0x11
[ 1586.675563] dell-wmi: Received unknown WMI event 0x11
[ 1587.442542] dell-wmi: Received unknown WMI event 0x11
[ 1623.471288] keyboard.c: can't emulate rawmode for keycode 241
[ 1623.471301] keyboard.c: can't emulate rawmode for keycode 241
[ 1626.035593] keyboard.c: can't emulate rawmode for keycode 241
[ 1626.035605] keyboard.c: can't emulate rawmode for keycode 241

The keyboard.c complaints are from when I hit Fn-F8 (display switch).  I
can trigger the same complaint with Fn-Left (display brightness auto),
with code 240.

I don't see keyboard.c complaints from Fn-Right, which toggles the
keyboard illumination and reports code 228.

I don't know what event causes the "event 0x11" complaint.  It seems to
be purely cosmetic and not directly tied to user interaction?

Fn-F8, Display Toggle, gives code 241 on the WMI event8 *and* code 227
on /dev/input/event4 "Video Bus".  That seems ... wrong.

There is an interesting behavior with Fn-Up and Fn-Down -- normally they
do not trigger events on /dev/input/event8 although I can see ACPI
interrupt count increasing in /proc/interrupts.  However there is some
state that I can toggle after about 5 minutes of futzing -- I still
haven't figured out what the toggle is -- that causes event8 to show
Brightness key events:

Event: time 1257214081.248619, type 1 (Key), code 236 (?), value 0
Event: time 1257214081.248621, -------------- Report Sync ------------
Event: time 1257214087.837272, type 1 (Key), code 240 (Unknown), value 1
Event: time 1257214087.837278, -------------- Report Sync ------------
Event: time 1257214087.837282, type 1 (Key), code 240 (Unknown), value 0
Event: time 1257214087.837284, -------------- Report Sync ------------
Event: time 1257214089.908451, type 1 (Key), code 225 (Brightness up), value 1
Event: time 1257214089.908457, -------------- Report Sync ------------
Event: time 1257214089.908460, type 1 (Key), code 225 (Brightness up), value 0
Event: time 1257214089.908462, -------------- Report Sync ------------
Event: time 1257214095.235095, type 1 (Key), code 240 (Unknown), value 1
Event: time 1257214095.235102, -------------- Report Sync ------------
Event: time 1257214095.235106, type 1 (Key), code 240 (Unknown), value 0
Event: time 1257214095.235108, -------------- Report Sync ------------
^C


Other keys of interest:

Fn-F3, a Battery glyph, gives keycode 236
Fn-F2, Battery with lighting bolt, gives no WMI key event but does
increase /proc/interrupts' ACPI entry
Fn-F7, "DCP", gives code 148 (Prog1)

Volume keys and mute don't show WMI events (they work fine through the
8042 keyboard channel), but /dev/input/event8 does have event codes for
them.

-andy
