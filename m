From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACPI Thermal Shutdown on Boot
Date: Fri, 13 Feb 2004 20:06:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040213190646.GH6804@openzaurus.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6A6@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6A6-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > If I understand you correctly, 30 seconds is certainly 
> > enough time to burn
> > > a CPU when the fan has failed, isn't it?
> > 
> > Our old default poll interval was 30 seconds so this doesn't change
> > anything.  I know DeadRat takes more than 30 seconds from "shutdown -h
> > now" to power off.  All modern CPUs have a thermal shutdown builtin.
> > Think of _CRT as more of "system temp too high, shut down as 
> > soon as you
> > can."
> 
>   If I didn't miss something,  Chris Jensen was unable to adjust
> critical trip point due
> to current policy. Anyway, 57C isn't a real critical temperature. It
> doesn't make sense to
> enter emergent shutdown/power.So we need sane checking here.( A sane
> _CRT ?)
>   If FAN is broken, at least we can use throttling to guarantee it will
> not be over heated.
> So, throttling should be included into policy about handling critical
> trip point.

At critical trip point, we have to shut down, according
to specs. No choice here.

If their ACPI BIOS is b0rken, blacklist them.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
