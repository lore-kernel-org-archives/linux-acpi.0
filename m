From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Nforce2 crashes
Date: Fri, 17 Oct 2003 13:23:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031017112313.GC7738@elf.ucw.cz>
References: <200310170722.AAA71496@smtp08.phx.gblx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200310170722.AAA71496-cEaiEdr7iMHEOYAad6Za0NHuzzzSOjJt@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mark and Loretta Goldberg <goldber-sy4M0opG+ma2PmBBfd0Sh6xOck334EZe@public.gmane.org>
Cc: "acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've got a FIC AU13, Athlon 2500+, 1 GB Dual Channel PC3200 DDR, 2.4.22 kernel.
> 
> If APIC support is compiled in, the machine crashes once or twice per day, solid lockup, hard reboot needed.
> If APIC support is not compiled in, it has been fine for weeks.

> If anyone is interested,  what can I send to troubleshoot the
> problem?

Well, patch to dmi_detect nforce2 and panic machine at boot if APIC is
enabled would be welcome. See arch/i386/kernel/dmi_scan.c.

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
