From: "Defiant" <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Subject: RE: can't switch CPU frequency while running on batterypower
Date: Tue, 6 Jan 2004 19:07:36 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32908.192.168.36.2.1073412456.squirrel@defiant.homedns.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C76@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C76-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org
     >
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

>> CONFIG_X86_ACPI_CPUFREQ=y
>> CONFIG_X86_ACPI_CPUFREQ_PROC_INTF=y
>
> Please try patch filed at
> http://bugzilla.kernel.org/show_bug.cgi?id=1489

Tried the patch, but it didn't solved the Problem.

Well at least I found out some more Info about.
My full speed is 1600, low speed is 1200Mhz:

When running on AC Adapter, I can switch the speed as often as I want.
So If I set it to 1200 and then disconnect the AC, I can also switch
between both speeds under battery power. Now If it is 1200 and I connect
the AC I can not set it back to 1600.
Well like I said in my preceding post it is the same: Running with AC,
speed set to 1600, disconnecting the AC, I can not set the speed down to
1200.

Hope that this wasn't that complicated (in my bad English),
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
