From: Tony Glader <Tony.Glader-cP9NhJtB8odr1ooMESYBxBZCeNDtXRbv@public.gmane.org>
Subject: No events when pressing power button
Date: Fri, 2 Aug 2002 00:11:29 +0300 (EEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208020007200.7699-100000@blueberrysolutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi!

I patched my kernel (2.4.18) today with latest version of acpi-patch 
(acpi-20020726-2.4.18.diff). My power button gets detected but I dont get 
any events from it. I have a ABit BP6 with dual celeron processors.

Acpi reports at boot:

ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (46 C)

What could be wrong? I tried latest acpid rpm and 'cat /proc/acpi/event' 
without results. Acpid doesn't write nothing to /var/log/acpid when I 
press power button. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
