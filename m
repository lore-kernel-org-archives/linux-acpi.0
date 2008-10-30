From: Andrew Patterson <andrew.patterson@hp.com>
Subject: [PATCH 1/6] PCI, ACPI: include missing acpi.h file in pci-acpi.h.
Date: Wed, 29 Oct 2008 23:27:52 -0600
Message-ID: <20081030052752.10259.29135.stgit@bob.kio>
References: <20081030052746.10259.22045.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081030052746.10259.22045.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: andrew.patterson@hp.com, matthew@wil.cx, kaneshige.kenji@jp.fujitsu.com, bjorn.helgaas@hp.com
List-Id: linux-acpi@vger.kernel.org

PCI, ACPI: include missing acpi.h file in pci-acpi.h.

The pci-acpi.h file will not compile without including linux/acpi.h.
---

 include/linux/pci-acpi.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


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
