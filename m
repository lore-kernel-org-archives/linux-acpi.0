From: Len Brown <lenb@kernel.org>
Subject: RE: [Devel] [patch] prevent possible NULL dereference. (fwd)
Date: Wed, 09 Dec 2009 15:36:28 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912091536000.24891@localhost.localdomain>
References: <alpine.LFD.2.00.0912091433040.24891@localhost.localdomain>
 <4911F71203A09E4D9981D27F9D83085840DA9C4E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:62905 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbZLIUgX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2009 15:36:23 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUE00IX6JWTAKED@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Dec 2009 14:36:30 -0600 (CST)
In-reply-to: <4911F71203A09E4D9981D27F9D83085840DA9C4E@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Dan Carpenter <error27@gmail.com>

> Was this in response to a specific problem seen in the field?

I don't think so, the submitter refers to a static code checker --
simply identifying a use before test.

-Len

> 
> >-----Original Message-----
> >From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
> >Of Len Brown
> >Sent: Wednesday, December 09, 2009 11:35 AM
> >To: devel@acpica.org
> >Cc: linux-acpi@vger.kernel.org; Dan Carpenter
> >Subject: [Devel] [patch] prevent possible NULL dereference. (fwd)
> >
> >forwarded to devel@acpica.org
> >
> >thanks,
> >Len Brown, Intel Open Source Technology Center
> >
> >---------- Forwarded message ----------
> >Date: Tue, 10 Nov 2009 11:02:49 +0200 (SAST)
> >From: Dan Carpenter <error27@gmail.com>
> >To: linux-acpi@vger.kernel.org
> >Cc: lenb@kernel.org
> >Subject: [patch] prevent possible NULL dereference.
> >
> >Move the check for walk_state->thread before the dereference.
> >
> >Found by smatch static checker.  Compile tested.
> >
> >regards,
> >dan carpenter
> >
> >Signed-off-by: Dan Carpenter <error27@gmail.com>
> >
> >--- orig/drivers/acpi/acpica/exmutex.c	2009-11-07 09:46:53.000000000
> >+0200
> >+++ devel/drivers/acpi/acpica/exmutex.c	2009-11-07 09:48:16.000000000
> >+0200
> >@@ -375,6 +375,15 @@
> > 		return_ACPI_STATUS(AE_AML_MUTEX_NOT_ACQUIRED);
> > 	}
> >
> >+	/* Must have a valid thread ID */
> >+
> >+	if (!walk_state->thread) {
> >+		ACPI_ERROR((AE_INFO,
> >+			    "Cannot release Mutex [%4.4s], null thread info",
> >+			    acpi_ut_get_node_name(obj_desc->mutex.node)));
> >+		return_ACPI_STATUS(AE_AML_INTERNAL);
> >+	}
> >+
> > 	/*
> > 	 * The Mutex is owned, but this thread must be the owner.
> > 	 * Special case for Global Lock, any thread can release
> >@@ -392,15 +401,6 @@
> > 		return_ACPI_STATUS(AE_AML_NOT_OWNER);
> > 	}
> >
> >-	/* Must have a valid thread ID */
> >-
> >-	if (!walk_state->thread) {
> >-		ACPI_ERROR((AE_INFO,
> >-			    "Cannot release Mutex [%4.4s], null thread info",
> >-			    acpi_ut_get_node_name(obj_desc->mutex.node)));
> >-		return_ACPI_STATUS(AE_AML_INTERNAL);
> >-	}
> >-
> > 	/*
> > 	 * The sync level of the mutex must be equal to the current sync
> >level. In
> > 	 * other words, the current level means that at least one mutex at
> >that
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >_______________________________________________
> >Devel mailing list
> >Devel@acpica.org
> >http://lists.acpica.org/listinfo/devel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
