From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/2] PNPACPI, x86/PCI: handle _CRS windows like Windows does
Date: Tue, 27 Apr 2010 14:45:33 -0600
Message-ID: <20100427202122.23753.63421.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

These patches simplify the way we handle Address Space descriptors and make
Linux do it more like Windows does.

The PNPACPI change is definitely .35 material, since I don't think anybody
uses this information via PNP yet.

My first thought was that the x86/PCI change is for .35, too, but it does
make a difference in some cases, so maybe it should go in .34.

Here's an example where it matters.  ACPI _CRS could have an MMIO Address Space
descriptor like this:

  _MIN 0xE0000000
  _MAX 0xFEBFFFFF
  _LEN 0x10000000,

which doesn't satisfy the spec requirement that:

  _MAX == _MIN + _LEN - 1,

but obviously we can't rely on spec compliance.  These are the ways we could
interpret it:

  [mem 0xe0000000-0xefffffff] current Linux way (end is _MIN + _LEN - 1)
  [mem 0xe0000000-0xfebfffff] new Linux way (end is _MAX)
  [mem 0xe0000000-0xfebfffff] Windows way (end is _MAX)

The risk is that BIOS might have placed a PCI device in the area that we used
to think was illegal, i.e., anywhere in [mem 0xf0000000-0xfebfffff], and Linux
will try to move the device unnecessarily, and that move might fail.

---

Bjorn Helgaas (2):
      PNPACPI: compute Address Space length rather than using _LEN
      x86/PCI: compute Address Space length rather than using _LEN

 arch/x86/pci/acpi.c            |   40 ++--------------------------------------
 drivers/pnp/pnpacpi/rsparser.c |   26 ++++----------------------
 2 files changed, 6 insertions(+), 60 deletions(-)
