From: Philip Balister <balister-PjAqaU27lzQ@public.gmane.org>
Subject: Re: Re: S4 reboots on resume
Date: Thu, 15 Jan 2004 09:36:27 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040115143627.GF25164@nemesis.maddog.net>
References: <1073935225.2106.15.camel@localhost> <20040115122142.GC12963@elf.ucw.cz> <20040115130810.GA9348@message-id.gmane0305.slipkontur.de> <4006A217.5040801@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4006A217.5040801-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bas Mevissen <ml-Y9IUUvl1dgU0Iwp8Nzs06g@public.gmane.org>
Cc: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I tried S4 on my Dell 600m. It seemed to suspend ok, and when I pressed the
power button, the power light came on, but not much else. Looking at this
table it suggests a kernel parameter resume=/dev/hdaX.

What should I use for X?

Philip

On Thu, Jan 15, 2004 at 03:22:15PM +0100, Bas Mevissen wrote:
> Stefan Seyfried wrote:
> 
> 
> >for the beginners in here: which one is swsusp, which one is pmdisk?
> >I'm using a suse 2.6 kernel.
> >echo 4 > /proc/acpi/sleep works for me.
> >
> 
> See <http://swsusp.sourceforge.net/features.html>
> 
> Bas.
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Perforce Software.
> Perforce is the Fast Software Configuration Management System offering
> advanced branching capabilities and atomic changes on 50+ platforms.
> Free Eval! http://www.perforce.com/perforce/loadprog.html
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
