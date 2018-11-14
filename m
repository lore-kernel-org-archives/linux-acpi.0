From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [GIT PULL] PCI fixes for v4.20
Date: Wed, 14 Nov 2018 00:20:10 -0600
Message-ID: <20181114062010.GA189193@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

PCI fixes:

  - Revert a _PXM change that causes silent early boot failure on some AMD
    ThreadRipper systems (Bjorn Helgaas)


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

for you to fetch changes up to 0d76bcc960e6057750fcf556b65da13f8bbdfd2b:

  Revert "ACPI/PCI: Pay attention to device-specific _PXM node values" (2018-11-13 08:38:17 -0600)

----------------------------------------------------------------
pci-v4.20-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "ACPI/PCI: Pay attention to device-specific _PXM node values"

 drivers/pci/pci-acpi.c | 5 -----
 1 file changed, 5 deletions(-)
