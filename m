From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI patches updated (20021111)
Date: Wed, 13 Nov 2002 13:42:21 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A504@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Stephen Hemminger' <shemminger-3NddpPZAyC0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Stephen Hemminger [mailto:shemminger-3NddpPZAyC0@public.gmane.org] 
> Will this fix problems with IRQ routing.
> On our SMP test machines, ACPI has to be disabled otherwise the SCSI
> disk controllers don't work.
> 
> This is a major pain, and ACPI should be default off until it gets
> fixed.

ACPI has not yet been adequately tested on machines with multiple IO-APICs.
More assistance in this area would be gratefully accepted. In the meantime,
"acpi=off" works pretty well to disable ACPI-related configuration problems.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
