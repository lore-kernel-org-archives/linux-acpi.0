From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54 (version 3)
Date: Wed, 15 Sep 2004 10:37:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040915083734.GA17317@hell.org.pl>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it> <20040914222905.GA17380@elf.ucw.cz> <4147870C.9090003@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4147870C.9090003-wlebWZzHoyE@public.gmane.org>
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
> >> BTW is 'echo 4 > /proc/acpi/sleep' = 'echo disk > /sys/power/state'?
> > Yes, it should be equivalent.
> the same I supposed. But in this case, there's an error somewhere: I can
> never resume properly if I use 'echo disk > /sys/power/state' and I get
> a kernel panic with these words:
> 
> Resuming from /dev/hda7
> Resuming from unknown-block(3,7)
> Kernel panic - not syncing: Resume Machine: Unable to find
> suspending-data signature (pmdisk-swa - mispelled?

Append noresume. swsusp1 kicks in earlier than pmdisk.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
