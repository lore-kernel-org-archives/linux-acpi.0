From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 0/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Date: Thu, 27 Oct 2005 21:38:17 +0200
Message-ID: <1130441897.3027.18.camel@laptopd505.fenrus.org>
References: <1130441405.5996.23.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751570AbVJ0Tih@vger.kernel.org>
In-Reply-To: <1130441405.5996.23.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-10-27 at 12:30 -0700, Kristen Accardi wrote:
> Store the value of PCI_INTERRUPT_PIN in the pci_dev structure for use
> later.  This is useful for pci hotplug.  When a device is "surprise"
> removed, the pci config space is no longer available.  However,
> the pin value is needed to correctly disable the irq for the device.

Hmmm maybe it's just me..... but... isn't that both advisory and
entirely unrelated to any kind of real interrupt thing? Eg dev->irq is
there already and works even in the sight of IO-APICs etc etc...
