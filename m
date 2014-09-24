From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [resend PATCH 0/3] usb: dwc3: ACPI support
Date: Wed, 24 Sep 2014 11:00:36 +0300
Message-ID: <1411545639-18741-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

The original series included patch that adds Braswell PCI ID, but I
send it separately.

The DMA mask caused a problem as our acpi platform code does not
provide anything for us. Instead of trying to fix it in dwc3 I
decided to suggest the first patch in this series where I provide
default DMA mask for all the ACPI platform devices.


Heikki Krogerus (3):
  ACPI / platform: provide default DMA mask
  usb: dwc3: core: only setting the dma_mask when needed
  usb: dwc3: add ACPI support

 drivers/acpi/acpi_platform.c |  2 ++
 drivers/usb/dwc3/core.c      | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.1.0
