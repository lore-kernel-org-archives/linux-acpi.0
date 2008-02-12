From: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 21:32:48 +0100
Message-ID: <200802122132.48419.dl9pf@gmx.de>
References: <200710122357.46851.dl9pf@gmx.de> <200802121157.33691.dl9pf@gmx.de> <200802121500.25986.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752114AbYBLUcy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Feb 2008 15:32:54 -0500
In-Reply-To: <200802121500.25986.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Am Dienstag 12 Februar 2008 21:00:25 schrieb Len Brown:
[...]
>
> thanks for the acpidump in http://bugzilla.kernel.org/show_bug.cgi?id=9939
>
> This BIOS makes heavy use of TRAP's into SMM, Windows version-specific
> hooks, and WMI -- all bad news for Linux.
Its a Phoenix BIOS btw. 

For the WMI: Could acer_wmi be extended for this as Alex suggested ?
Another FSC model is listed in their hw-db.

Atm this is fine for me - being able to adjust the brightness in "some" way.
But this is not good for user/newbie xyz. How should he know the 
kernel-cmdline.


Sidenote:
I don't like this BIOS - there are just no features in it. I'm also struggling 
with vmx being disabled by the bios - and no menu to enable it.

> But OSI(Linux) itself is a NOP on this box, since LINX is set and never
> referenced, per below.
>
> -Len
>
>        Method (_INI, 0, NotSerialized)
>         {
>             If (DTSE)
>             {
>                 TRAP (0x47)
>             }
>
>             Store (0x07D0, OSYS)
>             If (CondRefOf (_OSI, Local0))
>             {
>                 If (_OSI ("Linux"))
>                 {
>                     Store (0x01, LINX)
>                 }
>
>                 If (_OSI ("Windows 2001"))
>                 {
>                     Store (0x07D1, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2001 SP1"))
>                 {
>                     Store (0x07D1, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2001 SP2"))
>                 {
>                     Store (0x07D2, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2006"))
>                 {
>                     Store (0x07D6, OSYS)
>                 }
>             }
>
>             If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
>             {
>                 TRAP (0x3D)
>             }
TRAP 0x3D is the Windows WMI code then ?
>
>             TRAP (0x2B)
>             TRAP (0x32)
I wonder what these two are ;)


best regards
Jan-Simon
