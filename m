From: Sebastien B <sebastien.bourdeauducq-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: Gericom Hummer 2430 problems
Date: Mon, 12 Jan 2004 18:52:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040112175242.GA667@portable>
References: <3ACA40606221794F80A5670F0AF15F8401720CB3@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720CB3-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>; from luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Mon, Jan 12, 2004 at 07:57:49 +0100
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 2004.01.12 07:57, "Yu, Luming" wrote:
> > - Sometimes my machine locks up for less than a second and
> > when this happens I
> > have the following message in the dmesg output :
> > atkbd.c: Unknown key pressed (translated set 2, code 0x0,
> > data 0x0, on
> > isa0060/serio0).
> > I'm unsure this problem is ACPI related, but it often happens
> > when the fan
> > starts up.
> 
> Maybe this is ec event handling relative bug.  Please file it
> on bugzilla.

I've recently noticed that this bug only happens while KDE is running. 
It's quite weird... and it is not only because of KDE : it locks up the 
whole system ; if I'm listening to music when the bug happens, there 
are interrupts in the song... I had the same problem with Linux 2.4.23 
but without any message in the dmesg output.

> > - The S-states just don't work. Trying to enter one either
> > does nothing or
> > crashes the computer. The computer shutdowns properly, though.
> > I'm using Linux 2.6.0 with the ACPI patch 20031203.
> > You can find useful information about my laptop (contents of
> > the DSDT, full
> > output of dmesg and so on) at http://irchat.free.fr/acpi/.
> > Thank you,
> > Seb
> >
> 
> What kind of crash? Maybe this could the most easy one. :)
> 

S1 is not recognized (as written in the dmesg), and when entering S3 
the screen is turned off, and the machine is not responsive anymore to 
anything (even to the power button or to the LAN). I haven't tested S4 
and S5.

I have another problem : the contents of the /proc/acpi/ac_adapter/AC0/
state are not updated when I plug or unplug the AC adapter. The 
contents of this file are set correctly at boot time, and then there 
isn't any change until I reboot.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
