From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Revert "Implement pcibios_alloc_irq() and
 pcibios_free_irq()"
Date: Tue, 09 Feb 2016 11:58:00 -0600
Message-ID: <20160209175155.23549.35323.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: =?utf-8?b?0J7Qu9C10LM=?= =?utf-8?b?0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

We have two reports of drivers broken in v4.3 by Jiang's change,
991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()").

It would be best to fix the problem instead of reverting 991de2e59090, =
but
I don't have time to do that myself, and we haven't heard from Jiang, s=
o
the only choice I have is to revert the commit.

Note that reverting will likely break IOAPIC hotplug.

I haven't put my signed-off on it yet because it didn't revert cleanly,=
 and
I'm not sure that I did it correctly.

=D0=9E=D0=BB=D0=B5=D0=B3 and Sunjin, can you please test this and see w=
hether it fixes your
drivers?  This patch is based on v4.5-rc1.

---

Bjorn Helgaas (1):
      Revert 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and=
 pcibios_free_irq()")


 arch/x86/include/asm/pci_x86.h |    2 ++
 arch/x86/pci/common.c          |   27 +++++++++++----------------
 arch/x86/pci/intel_mid_pci.c   |    7 ++-----
 arch/x86/pci/irq.c             |   15 ++++++++++++++-
 drivers/acpi/pci_irq.c         |    8 ++++++++
 5 files changed, 37 insertions(+), 22 deletions(-)
