From: Lukas Schrangl <schrangl-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: Bad: scheduling while atomic!
Date: Fri, 2 Apr 2004 11:49:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404021149.29165.schrangl@gmx.net>
References: <200403311054.55536.schrangl@gmx.net> <200404010846.02216.schrangl@gmx.net> <20040401150739.GC8091@message-id.gmane0305.slipkontur.de>
Reply-To: schrangl-hi6Y0CQ0nG0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040401150739.GC8091-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
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

Am Donnerstag, 1. April 2004 17:07 schrieb Stefan Seyfried:
> On Thu, Apr 01, 2004 at 08:46:01AM +0200, Lukas Schrangl wrote:
> > Am Mittwoch, 31. M=E4rz 2004 15:59 schrieb Tomasz Ciolek:
> > >  I get the same error with suspend to disk on a Fujitsu P2120. Ali 15=
35
> > >  chipset is the common bit...
> > >
> > >  Whats the network card you use?
> >
> > Broadcom BCM 4401
>
> i need to unload bcm4400 before suspend (swsusp, ACPI S4) and reinsert
> after resume, otherwise resume fails. Maybe the same is true for S3.

The problem was enabling both preemptible kernel and MCE. Using only one of=
=20
them everything works, even if b44 is inserted and Local APIC enabled.
Only usb makes problems:
On wakeup I get something like
"Badness in usb/hcd/....c"
and a call trace. Will try to resolve that problem (maybe unloading usbmodu=
les=20
works, haven't had time to try yet).
After resume, I am not able to use usb anymore (even unloading/realoading=20
doesn't work).
And ACPI- poweroff does not work anymore. When shutting down I can read:
"The system will be haltet immediately.
acpi_power_off called"
or something the like, but no nothing happens; i poweroff manually. On=20
"normal" shutdowns (when not having resumed from S4) I don't get the msg=20
"acpi_power_off called" and it powers off.
Should I write a bug report because of the preempt/MCE problem and/or the A=
PIC=20
error which seems not to have any influence?

Lukas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
