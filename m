From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [Ipw2100-devel] [susp-resume] ipw2100 suspend patch for 0.54 (version 3)
Date: Wed, 15 Sep 2004 00:29:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040914222905.GA17380@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8403BD570F@pdsmsx403> <413EE1EA.2070307@pca.it> <413F02E7.3060005@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <413F02E7.3060005-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Cc: ML ipw2100-devel <ipw2100-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Herman Sheremetyev <mlists-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > it works perfectly on my ASUS M6N, 2.6.8.1 with no patch and S4: I can
> > suspend/resume directly from X (Debian XFree86-4.3.0.dfsg.1-7 & GNOME
> > 2.7.92). All is working correctly, not only the ipw2100 driver but all
> > the other drivers, too. I mean, actually I loaded a lot of different
> > modules (see below), I just did 'echo 4 > /proc/acpi/sleep' different
> > times (this is the 3rd in sequence).
> <cut>
> > There's only one minor problem: sometimes during the suspend process the
> > laptop doesn't shut down, the screen remains black and I have to
> > manually press 4-sec the power button. Then resuming is always ok. But
> > this is a minor issue ;-)
> <cut>
> > S3 doesn't work neither without the ipw2100: I get a resume suddenly
> > after the suspend process is finished and without errors.
> same /symptoms/ on 2.6.9-rc1 + ACPI 20040816: same success for
> suspend/resume directly from XFree86 (with the included radeon driver)
> and with the radeonfb loaded, same little problem with the black screen
> in suspending and same problem for S3.
> 
> BTW is 'echo 4 > /proc/acpi/sleep' = 'echo disk > /sys/power/state'?

Yes, it should be equivalent.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
