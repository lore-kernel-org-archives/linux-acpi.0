From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: constant processor 0x80 events
Date: Thu, 2 Jan 2003 13:59:37 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030102135937.GA9257@clara.net>
References: <20030101164052.GA31172@clara.net> <000001c2b1bf$5782b950$1a2202d3@sayonara> <20030101192644.GA31476@clara.net> <20030102101513.GA947@clara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030102101513.GA947-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Adachi, Kenichi" <aileenja-dTzOdQ2U+/YAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Faye Pearson [faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org] wrote:
> I've used THRT as the one shot flag in the meantime and I'll see how it
> goes.

> > eg. in _L00
> > 
> > If (LNot(THRT)) {
> >   Store (One, THRT)
> >   Notify (\_PR.CPU0, 0x80)
> > }
> > 
> > and in _PPC
> > 
> > If (THRT) {
> >   Store (Zero, THRT)
> >   Return (One)
> > }

This has (almost) the desired (or at least helpful) effect.

Used in combination with the autospeedstep daemon, once this threshold
has been met:

root@marmite faye # cat /proc/acpi/processor/CPU0/performance
state count:             2
active state:            P1
states:
    P0:                  1200 MHz, 20000 mW, 250 uS
   *P1:                  800 MHz, 10000 mW, 250 uS
 
The processor is switched to low power mode and autospeedstep didn't do
it:

root@marmite faye # tail /var/log/speedstep
Thu Jan  2 13:23:44 2003: max. speed mode
Thu Jan  2 13:24:01 2003: power save mode
Thu Jan  2 13:24:12 2003: max. speed mode
Thu Jan  2 13:31:19 2003: power save mode
Thu Jan  2 13:37:03 2003: max. speed mode

It still thinks it's in max. speed mode.

root@marmite faye # cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             51 C

The processor is now relatively chilled, it would be nice if it would
try to trip up again, but that's for me to change in autospeedstep.

> This is what I'm currently running with.  The thing is I'm not sure
> whether that will cause any other side effects - any ideas?

Still not sure about the side effects.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

I am the mother of all things, and all things should wear a sweater.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
