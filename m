From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] [TRIVIAL] leave_sleep fix. (was ACPI source release updated (20021002))
Date: Thu, 3 Oct 2002 16:14:17 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021003141417.GC27014@poup.poupinou.org>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEF9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEF9-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

On Wed, Oct 02, 2002 at 02:01:38PM -0700, Grover, Andrew wrote:
> Hi all,
> 
> There is a new release available at http://sf.net/projects/acpi . It
> incorporates many fixes from people on this list (thanks to everyone) as
> well as some interpreter enhancements. Non-Linux source releases and iasl
> binaries will be available at
> http://developer.intel.com/technology/iapc/acpi/downloads.htm by tomorrow
> evening at the latest.
> 
> Regards -- Andy
> 

By the way, could you apply trivial attached patch.  If we call
a _WAK Method with bus mastering disabled, the _WAK can potentially
access to system IO, wich can have undefined beaviour
on certain chipsets.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bm-fix.diff"

diff -ur linux-2.4.20-pre8.orig/drivers/acpi/hardware/hwsleep.c linux-2.4.20-pre8/drivers/acpi/hardware/hwsleep.c
--- linux-2.4.20-pre8.orig/drivers/acpi/hardware/hwsleep.c	Thu Oct  3 15:41:47 2002
+++ linux-2.4.20-pre8/drivers/acpi/hardware/hwsleep.c	Thu Oct  3 14:29:56 2002
@@ -335,6 +335,8 @@
 
 	ACPI_FUNCTION_TRACE ("Acpi_leave_sleep_state");
 
+	/* Enable BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure Enter_sleep_state_prep -> Enter_sleep_state ordering */
 
@@ -366,9 +368,6 @@
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
-
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	return_ACPI_STATUS (status);
 }

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
