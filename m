From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3] Intel MCH BIOS workaround
Date: Wed, 23 Apr 2014 10:20:57 -0600
Message-ID: <20140423161901.16088.46695.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, linux-acpi@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Zheng Z Yan <zheng.z.yan@intel.com>, Dave Jones <davej@redhat.com>, Rui Zhang <rui.zhang@intel.com>, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

Relative to v2, this adds "#ifdef CONFIG_X86" around the quirk and adds
Stephane's ack.  Either v2 or v3 is fine with me; whatever seems best to
you.

---

Bjorn Helgaas (1):
      PNP: Work around BIOS defects in Intel MCH area reporting


 drivers/pnp/quirks.c |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
