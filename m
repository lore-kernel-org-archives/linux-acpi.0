From: "Eric Northup" <digitale-eFwX6J65rk/J8bqQQ1YlwQ@public.gmane.org>
Subject: Resolved (was Re: Shuttle SB61G2 fan speed)
Date: Thu, 09 Oct 2003 16:37:08 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <E1A7hX2-0007Ht-Cq@cell01.cell01.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hello,
> 
> I have a SB51G, which should be very similar to your shuttle.
> 
> In my case, ACPI module does not change the fan speed, but loading the
> lm_sensors kernel module (i2c) does. The reason is that the modules
> writers, as they don't have all the specs they need, find it safer to
> reinitialize the whole sensors.
> 
> Do you have the sensors loaded or compiled in ? If this is actually the
> cause of the problem, and if you really want sensors in your kernel,
> removing the reinitialization is really a one-liner.

Thank you!  It was indeed the sensors which was running the fan at high
speed.  Sorry to blame ACPI, I just thought it was the only thing that
could control fan speed.

--Eric


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
