From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Kernel 2.4.23 passive cooling
Date: Tue, 2 Dec 2003 13:26:45 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031202122644.GA6024@hell.org.pl>
References: <1070301739.1353.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1070301739.1353.6.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nils Faerber:
> Hi!
> Passive cooling still seems a little strange, at least to me on my Asus
> L3800C notebook.
[...]
>  - passive cooling works until it reaches the first hot state. After
> that the fan(s) power up for a very short time and the CPU performance
> is set to maximum (!) again. The performance setting can afterwards not
> be reset to low performance anymore; it will be reset to high
> automatically!

Use the limit interface instead of directly manipulating the
CPU0/performance -- this *may* help.

> Is there any chance that this will be fixed?
> Or is this a BIOS bug?

I'm not sure, but I haven't really had enough time to trace the appropriate 
AML codepath -- I can obviously also experience the problem. Oddly enough,
the first time I booted ACPI 20031002 (just in order to see if improved
index field access will fix the passive cooling problem), the processor
went up to about 83 C without the fan kicking in (I can't remember if
throttling was on at that time, but I guess it should have been). I then
switched to active (the fans started spinning like mad), and back to
passive, which apparently didn't stop the fans.

What I suspect is that there are some semi-obscure things going on in the
AML and it would take me at least two or three cups of coffee to trace it.
I'll see what I can do.

Note: most of the thermal management is done by the AML and not by the OS,
as th OS doesn't know about most tresholds.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
