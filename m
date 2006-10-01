From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] - Altix: Add initial ACPI IO support
Date: Sun, 1 Oct 2006 00:15:11 -0700
Message-ID: <20061001001511.ae77d6b1.akpm@osdl.org>
References: <20060922145123.12414.81897.sendpatchset@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20060922145123.12414.81897.sendpatchset@attica.americas.sgi.com>
Sender: linux-ia64-owner@vger.kernel.org
To: John Keller <jpk@sgi.com>
Cc: linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ayoung@sgi.com
List-Id: linux-acpi@vger.kernel.org

On Fri, 22 Sep 2006 09:51:23 -0500
John Keller <jpk@sgi.com> wrote:

> First phase in introducing ACPI support to SN.

This:

--- gregkh-2.6.orig/include/linux/pci.h
+++ gregkh-2.6/include/linux/pci.h
@@ -405,6 +405,7 @@ extern struct bus_type pci_bus_type;
 extern struct list_head pci_root_buses;        /* list of all known PCI buses */
 extern struct list_head pci_devices;   /* list of all devices */
 
+void pcibios_fixup_device_resources(struct pci_dev *);
 void pcibios_fixup_bus(struct pci_bus *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);

breaks a bunch of architectures.

For example alpha has

void __init
pcibios_fixup_device_resources(struct pci_dev *dev, struct pci_bus *bus)

box:/usr/src/linux-2.6.18> grep -rl pcibios_fixup_device_resources .
./arch/alpha/kernel/pci.c
./arch/ia64/pci/pci.c
./arch/mips/pci/pci.c
./arch/powerpc/kernel/pci_64.c
./arch/powerpc/platforms/pseries/pci_dlpar.c
./include/asm-powerpc/pci.h

It needs work...
