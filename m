From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Re: S4bios on Sony Vaio FX601
Date: Thu, 16 Jan 2003 18:50:42 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.50.0301161847310.8805-100000@flyby>
References: <Pine.LNX.4.50.0301130925480.3926-100000@flyby>
 <20030113101531.GF12516@poup.poupinou.org> <20030113114850.1b1adc03.nils@kernelconcepts.de>
 <20030113120204.GA13358@marcogigante.it> <20030113135418.GI12516@poup.poupinou.org>
 <Pine.LNX.4.50.0301152010340.924-100000@flyby> <20030116151714.GT12516@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030116151714.GT12516-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Jan 2003, Ducrot Bruno wrote:

> > While using linux 2.4.20 + acpi-20021205 and 2 patches posted to this
> > ML some time ago (s4bios-2.4.20-acpi-20021205 and
> > 00_system_fix_s4bios-2.4.20-acpi-20021205) suspend doesn't works.
> > echo -n 4b >/proc/acpi/sleep make bios to start hibernation process, but
> > on resuming system hangs after datas from suspend partition are loaded.
> > The bios resume screen remains on the screen and I must power cycle the
> > notebook.
>
> Did you use framebuffer console?  If yes, try without it.  Try also on
> console.

I'm using console. I did not compile framebuffer into my kernel.
How can I produce info for debug?

--
Regards,  Marco Gigante


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
