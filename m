From: "Defiant" <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Subject: RE: can't switch CPU frequency while running on batterypower
Date: Tue, 6 Jan 2004 21:29:57 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32785.192.168.36.2.1073420997.squirrel@defiant.homedns.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C76@PDSMSX403.ccr.corp.intel.com><32908.192.168.36.2.1073412456.squirrel@defiant.homedns.org>
    <20040106103944.Q26693@root.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040106103944.Q26693-Y6VGUYTwhu0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> This is most likely a problem with re-evaluation of _PSS after it has been
> changed.  I don't remember if Linux uses the notify on the processor
> object to re-evaluate _PSS.  If Linux does this correctly, it may be that
> the underlying firmware has a bug and you should use a more specific
> cpufreq driver (i.e. SpeedStep or whatever).  Some systems have a problem
> where they don't properly export firmware information to the ACPI
> performance states interface.
>
> -Nate
>

uhm, I don't know why, but it is working now, using
CONFIG_X86_P4_CLOCKMOD instead of CONFIG_X86_SPEEDSTEP_ICH, even it is a
Pentium 4m, not Pentium 4.

I hope that someone with the same Problem will read this.

thanks for your help,

Erik Andresen

--

All I ask is a tall ship, and a star to steer her by
> defiant.homedns.org <
 -cause Experience is Knowledge



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
