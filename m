From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Re: Unable to turn cooling device on - Asus M3N - test9bk4
Date: Sun, 2 Nov 2003 07:41:17 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031102064117.GC16225@casa.fluido.as>
References: <20031101201812.GA19277@austinchronicle.com> <20031101203319.GA19334@austinchronicle.com> <20031101215223.GB20858@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031101215223.GB20858-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org, Lindsey Simon <lsimon-kAMMLXQ8Af9Wk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

	Subject: Re: [ACPI] Unable to turn cooling device on - Asus M3N - test9bk4
	Date: sab, nov 01, 2003 at 10:52:23 +0100

Quoting Karol Kozimor (sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org):

> You have, however, a more serious problem if the fan is not really spinning
> at all. You'd need to verify that using a wide range of temperatures,
> though.

My personal experience: on my m3700n I used 2.6.0test6, needed a
patched DSDT, and my fan was always, strongly on. Yesterday evening I
did the upgrade to vanilla 2.6.0test9. I can happily announce that
internal temperature is successfully maintained around the trip point
(55 degrees). This also means that the temperature read from the
/proc/acpi/thermal_zone/THRM/temperature file is now meaningful. 

What I wanted to add is that the result is obtained by running the fan
at an apparently much lower speed, so that it is scarcely felt that it
runs at all.

So, Lindsey, are you sure that your fan does not run? In my case, I
had not loaded the fan and thermal modules at the beginning (they were
useless with the older version, and had caused problems...) and after
a few minutes' running time the upper, left part of the PC became so
hot that it hurt my fingers. After loading the two modules, in a
very short time the PC was again comfortable on my laptop. 

PS I can also announce that commuting from LCD to external monitor now
works! ;-) Only, it works using the function key, not by writing
numbers into /proc/acpi/asus/disp. The value read on the proc file
changes though: LCD on shows 1, external CRT on shows 2048.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
