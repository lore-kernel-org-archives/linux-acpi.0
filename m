From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: S1 on toshiba S3000-X11
Date: Thu, 10 Oct 2002 12:17:30 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021010101730.GE18311@poup.poupinou.org>
References: <20021010095302.GC22813@lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wchHw8dVAp53YPj8"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021010095302.GC22813-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?=C9ric?= Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 10, 2002 at 11:53:02AM +0200, Éric Brunet wrote:
> Hi,
> 
> I just wanted to say that the acpi patch 20021002 seems to work fine on
> my laptop (toshiba S3000-X11) with a 2.4.20-pre10 kernel, except that I
> need to apply the following patch (originally by Bruno Ducrot) to have S1
> working:
> 
> ==================================================================================================
> --- linux-2.4.20-pre10-acpi1002/drivers/acpi/hardware/hwsleep.c.orig	Tue Oct  8 18:29:35 2002
> +++ linux-2.4.20-pre10-acpi1002/drivers/acpi/hardware/hwsleep.c	Tue Oct  8 22:48:49 2002
> @@ -309,6 +309,9 @@
> 
>         } while (!in_value);
> 
> +       /* Restore BM arbitration */
> +       acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
> +
>         return_ACPI_STATUS (AE_OK);
>  }
> 
> ===================================================================================================

I already submmited the attached patch.

Wait and see..

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--wchHw8dVAp53YPj8
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

--wchHw8dVAp53YPj8--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
