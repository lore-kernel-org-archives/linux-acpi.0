From: "Defiant" <mail-4AGA6j5e2AhmdDG0eupGX0B+6BGkLq7r@public.gmane.org>
Subject: RE: can't switch CPU frequency while running on batterypower
Date: Thu, 8 Jan 2004 07:15:21 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <32779.192.168.36.2.1073542521.squirrel@defiant.homedns.org>
References: <571ACEFD467F7749BC50E0A98C17CDD8E84E7A@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <571ACEFD467F7749BC50E0A98C17CDD8E84E7A-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
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


> When switching between AC and battery, _PPC method may return a different
> P-state limit. Please verify if 'cat /proc/acpi/processor/CPU0/limit' is
> different under the two situations.
>
> Thanks,
> Shaohua

No, it is not different.
I get both times

active limit:            P0:T0
platform limit:          P0:T0
user limit:              P0:T0
thermal limit:           P0:T0

I guess, this is not good?

Erik Andresen


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
