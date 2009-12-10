From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] [patch] prevent possible NULL dereference. (fwd)
Date: Thu, 10 Dec 2009 14:50:41 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085840F38876@orsmsx503.amr.corp.intel.com>
References: <alpine.LFD.2.00.0912091433040.24891@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19023 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932914AbZLJWug convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2009 17:50:36 -0500
In-Reply-To: <alpine.LFD.2.00.0912091433040.24891@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Dan Carpenter <error27@gmail.com>

Added to ACPICA base code for the next release (mid-December).

Thanks,
Bob


>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Len Brown
>Sent: Wednesday, December 09, 2009 11:35 AM
>To: devel@acpica.org
>Cc: linux-acpi@vger.kernel.org; Dan Carpenter
>Subject: [Devel] [patch] prevent possible NULL dereference. (fwd)
>
>forwarded to devel@acpica.org
>
>thanks,
>Len Brown, Intel Open Source Technology Center
>
>---------- Forwarded message ----------
>Date: Tue, 10 Nov 2009 11:02:49 +0200 (SAST)
>From: Dan Carpenter <error27@gmail.com>
>To: linux-acpi@vger.kernel.org
>Cc: lenb@kernel.org
>Subject: [patch] prevent possible NULL dereference.
>
>Move the check for walk_state->thread before the dereference.
>
>Found by smatch static checker.  Compile tested.
>
>regards,
>dan carpenter
>
>Signed-off-by: Dan Carpenter <error27@gmail.com>
>
>--- orig/drivers/acpi/acpica/exmutex.c	2009-11-07 09:46:53.000000000
>+0200
>+++ devel/drivers/acpi/acpica/exmutex.c	2009-11-07 09:48:16.000000000
>+0200
>@@ -375,6 +375,15 @@
> 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
> 	}
>
>+	/* Must have a valid thread ID */
>+
>+	if (!walk_state->thread) {
>+		ACPI_ERROR((AE_INFO,
>+			    "Cannot release Mutex [%4.4s], null thread info",
>+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
>+		return_ACPI_STATUS(AE_AML_INTERNAL);
>+	}
>+
> 	/*
> 	 * The Mutex is owned, but this thread must be the owner.
> 	 * Special case for Global Lock, any thread can release
>@@ -392,15 +401,6 @@
> 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
> 	}
>
>-	/* Must have a valid thread ID */
>-
>-	if (!walk_state->thread) {
>-		ACPI_ERROR((AE_INFO,
>-			    "Cannot release Mutex [%4.4s], null thread info",
>-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
>-		return_ACPI_STATUS(AE_AML_INTERNAL);
>-	}
>-
> 	/*
> 	 * The sync level of the mutex must be equal to the current sync
>level. In
> 	 * other words, the current level means that at least one mutex at
>that
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
