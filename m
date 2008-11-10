From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 1/7] PCI, ACPI: include missing acpi.h file in pci-acpi.h.
Date: Mon, 10 Nov 2008 15:30:40 -0700
Message-ID: <20081110223040.30539.93209.stgit@bob.kio>
References: <20081110223035.30539.88942.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081110223035.30539.88942.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

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
