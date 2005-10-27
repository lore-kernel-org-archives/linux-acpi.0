From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Date: Thu, 27 Oct 2005 12:30:05 -0700
Message-ID: <1130441405.5996.23.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751565AbVJ0Tan@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Store the value of PCI_INTERRUPT_PIN in the pci_dev structure for use
later.  This is useful for pci hotplug.  When a device is "surprise"
removed, the pci config space is no longer available.  However,
the pin value is needed to correctly disable the irq for the device.

--
