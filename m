From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] x86/PCI: pci=use_crs regression fix
Date: Tue, 16 Mar 2010 14:11:29 -0600
Message-ID: <20100316201046.24527.79634.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch fixes some PCI host bridge _CRS parsing problems and may fix
Pete Zaitcev's http://bugzilla.kernel.org/show_bug.cgi?id=15533 regression,
but I haven't seen any testing results yet.

I'm pretty confident this will fix pci=use_crs on *some* machines even if
Pete's problem turns out to be something else, so I think we should just
put it in.

---

Bjorn Helgaas (1):
      x86/PCI: ignore Consumer/Producer bit and parse additional _CRS resources


 arch/x86/pci/acpi.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 71 insertions(+), 6 deletions(-)
