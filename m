From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Fri, 20 Sep 2002 12:06:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209201206.17683.jbr.1@gmx.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE93@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE93-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'P. Christeas'" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Grover, Andrew wrote:
> > From: P. Christeas [mailto:p_christ-U04EIuiosng@public.gmane.org]
> >
> > > With ACPI enabled X gets slow. I mean REALLY SLOW! It needs up to 20
> > > seconds to start and then consumes as much CPU time as
> >
> > possible. It's an
> >
> > > adventure to try to hit something with the mouse pointer.
> > > Everything is funktioning perfectly without ACPI.
> > > Perhaps an interrupt problem. ACPI shares an interrupt with
> >
> > a bttv card.
> >
> > > The GeForce has it's own interrupt.
> >
> > Huh! You just mentioned a magic word: bttv. I do have a bt878
> > card, I have to
> > look if that is the problem after all.
> >
> > To A. Grover: if the trouble lies in the bttv driver, the
> > kernel will be
> > considered broken until both drivers co-exist..
>
> When you cat /proc/interrupts, is there a huge and ever-increasing number
> of interrupts listed for the shared irq?

No, everything seems to be ok there with my system. For a long time the value 
for interrupt 9 (shared between acpi, usb, bttv) did not even increase.

To test it I removed the bttv card and disabled usb as far as possible (there 
are two controllers, only one could be disabled. But there are no devices 
connected to usb at all.)
Still the same problem: X gets very slow. Looks like it's making a pause every 
few seconds. Working remote via ssh on the system is possible without any 
problems.

> (Wait, I thought video devices weren't interrupt driven? Or is that only
> video out, not video-in, like bt878?)

Strange. Someone told me, that they use interrupts to talk to the graphics 
card. I didn't really believe that...
Now I tried: I just watched a little bit with the bttv and there was NO 
interrupt activity at all!

I found a note on the German Asus web site, that tv cards should have there 
own interrupt. Doesn't seem to be very important. Windows and Linux seem to 
have no problem with it.

Conclusion: The bttv driver is not responsible for the problem! The NVidia 
driver or acpi is the problem. Should someone inform NVidia about the 
problem?

Jochen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
