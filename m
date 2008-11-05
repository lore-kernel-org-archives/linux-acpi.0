From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 1/7] PCI, ACPI: include missing acpi.h file in pci-acpi.h.
Date: Tue, 04 Nov 2008 22:29:40 -0700
Message-ID: <20081105052939.15722.82305.stgit@bob.kio>
References: <20081105052934.15722.98580.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:34700 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYKEF3k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 00:29:40 -0500
In-Reply-To: <20081105052934.15722.98580.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com

PCI, ACPI: include missing acpi.h file in pci-acpi.h.

The pci-acpi.h file will not compile without including linux/acpi.h.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
---

diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8837928..a9e4c34 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -8,6 +8,8 @@
 #ifndef _PCI_ACPI_H_
 #define _PCI_ACPI_H_
 
+#include <linux/acpi.h>
+
 #define OSC_QUERY_TYPE			0
 #define OSC_SUPPORT_TYPE 		1
 #define OSC_CONTROL_TYPE		2

