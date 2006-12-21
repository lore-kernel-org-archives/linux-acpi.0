From: Doug Chapman <doug.chapman@hp.com>
Subject: [PATCH] increase ACPI_MAX_REFERENCE_COUNT for larger systems
Date: Thu, 21 Dec 2006 12:11:43 -0500
Message-ID: <1166721103.13323.12.camel@dchapman.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:38674 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422992AbWLURlo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 12:41:44 -0500
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by atlrel7.hp.com (Postfix) with ESMTP id 866BC37471
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 12:11:48 -0500 (EST)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 581621292FD
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 17:11:48 +0000 (UTC)
Received: from localhost (ldl.lart [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 34BF513415B
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 10:11:48 -0700 (MST)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08445-09 for <linux-acpi@vger.kernel.org>;
	Thu, 21 Dec 2006 10:11:44 -0700 (MST)
Received: from localhost.localdomain (hplu.fc.hp.com [15.11.146.86])
	by ldl.fc.hp.com (Postfix) with ESMTP id C0BC7134143
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 10:11:43 -0700 (MST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

We have some new larger ia64 systems in HP that trip over the
ACPI_MAX_REFERENCE_COUNT limit which triggers a large number of these
debug messages:

ACPI Warning (utdelete-0397): Large Reference Count (XXX) in object e0000a0ff6797ab0  [20060707]

This was increased once in the past as described in this very brief thread:

http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg00890.html


signed-off-by: Doug Chapman <doug.chapman@hp.com>

--- linux-2.6.20-rc1/include/acpi/acconfig.h.prev	2006-12-21 12:06:56.000000000 -0500
+++ linux-2.6.20-rc1/include/acpi/acconfig.h	2006-12-21 12:07:49.000000000 -0500
@@ -105,7 +105,7 @@
 
 /* Maximum object reference count (detects object deletion issues) */
 
-#define ACPI_MAX_REFERENCE_COUNT        0x800
+#define ACPI_MAX_REFERENCE_COUNT        0x1000
 
 /* Size of cached memory mapping for system memory operation region */
 


