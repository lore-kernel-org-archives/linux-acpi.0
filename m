From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54 (version 3)
Date: Wed, 15 Sep 2004 13:30:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040915113038.GB17317@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it> <20040914222905.GA17380@elf.ucw.cz> <4147870C.9090003@pca.it> <20040915083734.GA17317@hell.org.pl> <41481805.8020106@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41481805.8020106-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thus wrote Luca Capello:
> I can *successfully* suspend/resume with the 2 calls (/proc or /sys),
> directly from XFree86 and with all the modules loaded. As already
> reported, the only difference is that with the /sys call, in suspending
> I've always the machine which powers off, while with the /proc call I
> should power off the machine by pressing 4-sec the power button.
> 
> Simple question: which should be the best method to use? /sys or /proc?

Use /sys if it works. OTOH, /proc is more tested and actively maintained.
ACPI S4 triggered by /sys is slightly better in handling wake-up events
(think Wake On LAN, RTC) and other things like, say AC status updates.

> Another thing: why for the /sys call I should use 'append=noresume',
> while I want to *resume*? I mean, it's not so clear...

Because /sys is the pmdisk code, /proc is swsusp1 code (at least until the
merge in -mm kernels goes into mainline). swsusp1 uses resume and noresume,
pmdisk uses pmdisk (=/dev/hdXY) and, well... AFAIR pmdisk (="").
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
