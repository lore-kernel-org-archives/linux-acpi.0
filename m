From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: Re: [Fwd: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook (contains agp, lapic, swsusp)]
Date: Tue, 10 Feb 2004 21:22:24 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040210211914.FCD9.COUNT0@localnet.com>
References: <1076374686.3429.1.camel@darkstar> <m3oes76x8l.fsf@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3oes76x8l.fsf-eMhNhoSsuh6q92djB/mqZw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Near identical symptoms with SiS 648FX / 963 chipsets, and desktop P4.
I doubt this is 855 specific. More like any recent ACPI BIOS + AGP 3
specific. -Huw

>  >> If your laptop is one APIC victim, I think until this problem
>  >> isn't resolved, suspend/resume also doesn't work, is my guess.
> 
> My laptop definitely experiences the ACPI+APIC troubles, but I'm not
> sure whether that is what you refer to as "victim." :)
> 
> However: suspend/resume _almost_ work under 2.6.x -- the problem is
> the AGP code, it seems. 
> 
> If I disable AGP, DRM/DRI and the intel framebuffer (which depends on
> intel AGP! vesa fb is activated and works, though), compile at least
> yenta_socket as a module, I can do suspend to disk (swsusp2) on kernel
> 2.6.2 and resume even while X11 is running.
> 
> The moment I enable AGP (no DRM/DRI, no intel fb), things break.
> 
> As for S1/S3, it seems that S1 is almost/more or less working, but I
> can only wake up the machine with the power button and that creates an
> event to shut down the machine. :-/ Oh yeah: and the keyboard is
> broken after resume from S1.
> 
> On S3, the machine comes back up -- apparently with working keyboard,
> although I can't be 100% sure -- and the screen is dead. After typing
> "ifup eth0" on the console I can log into it over the network,
> though. :)
> 
> On the swsusp2 list, someone made a survey and found out that noone
> has AGP working on 2.6.x for their Centrino notebooks. So the problem
> really seems to be with the graphics/AGP/ACPI support of the Intel
> 855GM/PM chipsets.
> 
> Is there any way people can help to make sure someone finds the time
> to look into this?

-- 
Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
