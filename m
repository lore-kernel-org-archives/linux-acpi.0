From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ARB_DIS
Date: Tue, 29 Apr 2003 19:57:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030429175730.GC2954@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A847E96DBF@orsmsx401.jf.intel.com> <20030408112629.GU10287@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030408112629.GU10287-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 08, 2003 at 01:26:29PM +0200, Ducrot Bruno wrote:
> Hi, Andy.
> 
> On Mon, Apr 07, 2003 at 11:40:00AM -0700, Grover, Andrew wrote:
> > Hi Eric,
> > 
> > So in a patch applied 6 months ago, you added code to restore the
> > ARB_DIS bit on resume from S1. In looking more closely, it appears that
> > this is a duplicate of code already in acpi_leave_sleep_state. Given
> > that the OS should be calling that function after resuming S1, I am
> > considering removing that line from acpi_enter_sleep_state, but wanted
> > to check with you before I did. Any reason why I should stay?
> > 
> 
> Really, you should track more closely authors of patches...
> 
> Anyway, since you have applied ARB_DIS before calling AML methods
> in acpi_leave_sleep_state(), this is OK for me.

Actually, I supposed you applied this one.  Please apply.


--- linux-2.5.68/drivers/acpi/hardware/hwsleep.c	2003/04/29 17:53:16	1.1
+++ linux-2.5.68/drivers/acpi/hardware/hwsleep.c	2003/04/29 17:53:45
@@ -401,6 +401,10 @@
 
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
+	/* Disable BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
+
+
 	acpi_gbl_sleep_type_a = ACPI_SLEEP_TYPE_INVALID;
 
 	/* Setup parameter object */
@@ -429,9 +433,6 @@
 	if (ACPI_FAILURE (status)) {
 		return_ACPI_STATUS (status);
 	}
-
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	return_ACPI_STATUS (status);
 }



Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
