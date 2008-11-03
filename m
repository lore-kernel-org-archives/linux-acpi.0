From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: EC: clean up tmp variable before reuse
Date: Mon, 03 Nov 2008 16:02:52 +0800
Message-ID: <1225699372.26020.37.camel@yakui_zhao.sh.intel.com>
References: <20081031184233.8588.42241.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63895 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbYKCH4A (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 3 Nov 2008 02:56:00 -0500
In-Reply-To: <20081031184233.8588.42241.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

On Sat, 2008-11-01 at 02:42 +0800, Alexey Starikovskiy wrote:
> Fix breakage introduced by following patch
> 27663c5855b10af9ec67bc7dfba001426ba21222 is first bad commit
> commit 27663c5855b10af9ec67bc7dfba001426ba21222
> Author: Matthew Wilcox <willy@linux.intel.com>
> Date:   Fri Oct 10 02:22:59 2008 -0400
> 
> acpi_evaluate_integer() does not clear passed variable if
> there is an error at evaluation.
> So if we ignore error, we must supply initialized variable.
> 
> References: http://bugzilla.kernel.org/show_bug.cgi?id=11917
> 	    http://bugzilla.kernel.org/show_bug.cgi?id=11896
The patch from Alexey can fix the problem in bug 11917. 
But the better solution is that the EC global lock should be initialized
based on the return value of _GLK.
    If AE_OK is returned by the acpi_evaluate_integer, the EC global
lock will be assigned based on the return value of _GLK object. If it is
not zero, it indicates that global lock will be used when EC is
accessed. Otherwise it means that global lock won't be used when EC is
accessed.

How about the following patch?

Subject: ACPI: Initialize EC global lock based on the return value of
_GLK
From: Zhao Yakui <yakui.zhao@intel.com>

Initialize the EC global lock based on the return value of _GLK object.
Only when AE_OK is returned by the acpi_evaluate_integer, the EC global
lock will be assigned based on the return value of _GLK object.
If the return value is not zero, it means that GLobal lock will be used
when EC is accessed.Otherwise it means that global lock won't be used
when EC is accessed.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ec.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -751,8 +751,19 @@ ec_parse_device(acpi_handle handle, u32 
 		return status;
 	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
-	ec->global_lock = tmp;
+	status = acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
+	/*
+	 * Only when AE_OK is returned by acpi_evaluate_interger,
+	 * the ec->global_lock will be assigned based on the returned
+	 * value by _GLK.
+	 * If the return value is not zero, it means that Global lock will be
+	 * used when EC is accessed.
+	 * Otherwise the global lock won't be used when EC is accessed.
+	 */
+	if (ACPI_SUCCESS(status))
+		ec->global_lock = !!tmp;
+	 else
+		ec->global_lock = FALSE;
 	ec->handle = handle;
 	return AE_CTRL_TERMINATE;
 }




