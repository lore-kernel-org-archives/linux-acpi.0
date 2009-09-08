From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5 update] PCI / ACPI PM: Propagate wake-up enable upstream
Date: Tue, 8 Sep 2009 23:11:48 +0200
Message-ID: <200909082311.48366.rjw@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909020041.57754.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <200909040002.02562.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ykzhao <yakui.zhao@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

The patchset has been confirmed to fix the issue it was designed for (ie.
it allows an add-on PCI card to wake-up the system from S3 by enabling the
GPE of the bridge upstream to wake up), so I'd like to get it in as soon as
reasonably possible.

Please review.

Thanks,
Rafael
