From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Processor states and USB
Date: Tue, 26 Nov 2002 14:59:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021126135934.GC1268@zaurus>
References: <m2el9eqb51.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2el9eqb51.fsf-dTJq59+VGzkkCw8IV3R6h0EOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> My CPU has the following states:
> 
>     C1:                  promotion[C2] demotion[--] latency[000] usage[00100920]
>     C2:                  promotion[C3] demotion[C1] latency[001] usage[06199483]
>    *C3:                  promotion[--] demotion[C2] latency[100] usage[12803374]
> 
> Now, whenever the usb-uhci module is loaded, C3 never gets
> used. C2 is the only state that my CPU is in. If I unload usb-uhci, the
> machine starts using C3.
> 
> Somebody explained to me that this is because the usb-uhci driver uses
> DMA transfers to talk to the hardware and poll it for new devices. Is
> there a patch available that changes this behavior? Anybody found any
> solutions to this?

UHCI is crap,  and this will be hard to solve.
You should have seen what it does with
system performance in FSBR mode....

usb-devel is better place for this discussion...

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
