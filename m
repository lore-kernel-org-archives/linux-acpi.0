From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Fri, 14 Mar 2008 08:05:28 +0100
Message-ID: <20080314070528.GE17940@kernel.dk>
References: <20080225230035.GA14503@khazad-dum.debian.net> <20080312133529.GB21290@khazad-dum.debian.net> <20080312135521.GE8141@ics.muni.cz> <200803121952.42666.arekm@maven.pl> <20080313231738.GH30864@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:7496 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719AbYCNHFa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 03:05:30 -0400
Content-Disposition: inline
In-Reply-To: <20080313231738.GH30864@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, Lukas Hejtmanek <xhejtman@ics.muni.cz>, Alexey Starikovskiy <aystarik@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 13 2008, Henrique de Moraes Holschuh wrote:
> On Wed, 12 Mar 2008, Arkadiusz Miskiewicz wrote:
> > > On Wed, Mar 12, 2008 at 10:35:29AM -0300, Henrique de Moraes Holschuh wrote:
> > > > You shouldn't need to do anything other than teach userspace to respond
> > > > to them, as they generate the proper KEY_* events.  If you are giving the
> > > > AML _OSI(Linux), at least...
> > 
> > I'm also seeing regression on my thinkpad z60m where with git tree (tested 
> > again with 2 days old git) "thinkvantage" button stopped working (pressing it 
> > was previously seen by some userspace kde which run konsole).
> > 
> > On 2.6.24 presses are seen.
> 
> There were no changes to thinkpad-acpi that should have caused this.  So I
> need more data to find out what is happening.  Might be a problem elsewhere
> in ACPI, or some bug in thinkpad-acpi.
> 
> You DO have /proc/acpi/event, correct?  Please send me the debug output of
> thinkpad-acpi when it is loaded with "debug=0xffff" as a parameter (and for
> extra bonus, please compile it with the verbose debug Kconfig option).

Yep, I do have /proc/acpi event. I'll build thinkpad-acpi modular and
set the extra debug option.

> Also, send me the output of 
> "grep . /sys/bus/platform/devices/thinkpad_acpi/*"

/sys/bus/platform/devices/thinkpad_acpi/bluetooth_enable:0
grep: /sys/bus/platform/devices/thinkpad_acpi/cmos_command: Permission denied
/sys/bus/platform/devices/thinkpad_acpi/hotkey_all_mask:0x00ffffff
/sys/bus/platform/devices/thinkpad_acpi/hotkey_bios_enabled:0
/sys/bus/platform/devices/thinkpad_acpi/hotkey_bios_mask:0x0000080c
/sys/bus/platform/devices/thinkpad_acpi/hotkey_enable:1
/sys/bus/platform/devices/thinkpad_acpi/hotkey_mask:0x008c7fff
/sys/bus/platform/devices/thinkpad_acpi/hotkey_radio_sw:1
/sys/bus/platform/devices/thinkpad_acpi/hotkey_recommended_mask:0x008c7fff
/sys/bus/platform/devices/thinkpad_acpi/hotkey_report_mode:1
/sys/bus/platform/devices/thinkpad_acpi/modalias:platform:thinkpad_acpi
/sys/bus/platform/devices/thinkpad_acpi/uevent:DRIVER=thinkpad_acpi
/sys/bus/platform/devices/thinkpad_acpi/uevent:PHYSDEVBUS=platform
/sys/bus/platform/devices/thinkpad_acpi/uevent:PHYSDEVDRIVER=thinkpad_acpi
/sys/bus/platform/devices/thinkpad_acpi/uevent:MODALIAS=platform:thinkpad_acpi
/sys/bus/platform/devices/thinkpad_acpi/wakeup_hotunplug_complete:0
/sys/bus/platform/devices/thinkpad_acpi/wakeup_reason:0

-- 
Jens Axboe

