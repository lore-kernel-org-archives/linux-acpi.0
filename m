From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] [TRIVIAL] Re: [PATCH] ACPI update (20030122)
Date: Fri, 24 Jan 2003 16:51:01 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030124155101.GZ18109@poup.poupinou.org>
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com> <20030124032222.A9061@piffio.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030124032222.A9061-mRUH1VNo/yu/RHH9vPZxQGD2FQJk+8+b@public.gmane.org>
To: Sergio Visinoni <piffio-9zdaV+82baBg9hUCZPvPmw@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 24, 2003 at 03:22:22AM +0100, Sergio Visinoni wrote:
> * Grover, Andrew (andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) wrote:
> > (2.4) S4BIOS support (Ducrot Bruno)
> 
> Attached is the missing s4bios portion (the
> acpi_enter_sleep_state_s4bios function ) + fixes to make it
> build correctly on a 2.4.20 tree.
> 
> It should apply correctly on 2.4.21-pre3 as well (not tested).
> 

It should be OK (I think..)

Appart the following chunk:

--- linux-2.4.20/drivers/acpi/hardware/hwsleep.c.s4bios~	2003-01-24 02:35:41.000000000 +0100
+++ linux-2.4.20/drivers/acpi/hardware/hwsleep.c	2003-01-24 02:35:53.000000000 +0100
@@ -339,6 +387,8 @@
 
 	ACPI_FUNCTION_TRACE ("acpi_leave_sleep_state");
 
+	/* Be sure to have BM arbitration */
+	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
 
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
@@ -371,8 +421,5 @@
 		return_ACPI_STATUS (status);
 	}
 
-	/* Disable BM arbitration */
-	status = acpi_set_register (ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
-
 	return_ACPI_STATUS (status);
 }


which is a bug fix for a different purpose.

We can not trust the bios when we have to enter the _WAK method.
Those we re-enable the BM arbitration before (the comment Disable
is actually a mistake).

Cheers,


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
