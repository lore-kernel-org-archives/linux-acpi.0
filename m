From: Jochen Streicher <bumkunjo-Mmb7MZpHnFY@public.gmane.org>
Subject: Battery state once only per battery w. acpi-20020918?
Date: Thu, 28 Nov 2002 22:50:46 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211282250.47854.bumkunjo@gmx.de>
Reply-To: bumkunjo-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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

When I read out battery state the first time after bootup with
'cat  /proc/acpi/battery/BAT0/state'
I get the full information:

"present:			yes
 capacity state:		ok
 charging state:		unknown
 present rate:		0mW
 remaining capacity:	38600mWh
 present voltage:	12413mV"

If i try to read out again, it fails:

"ACPI-1155 ***ERROR: Method execution failed, AE_AML_INTERNAL
 present:                 yes
 ERROR: Unable to read battery status
 ACPI-1155 ***ERROR: Method execution failed, AE_AML_INTERNAL

Seems to me that method is able to read out my battery state, but could not be 
repeated.

Unfortunately I can't try out latest acpi-versions with my IBM, the newly 
introduced ECDT-readout does not work.

Is there a workaround for 20020918 for reading the battery state more than 
once?











-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
