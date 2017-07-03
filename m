From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 0/2] ACPI: SPCR: Use access width to determine mmio usage
Date: Mon,  3 Jul 2017 14:33:07 -0700
Message-ID: <1499117589-4829-1-git-send-email-lho@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org, jon.mason@broadcom.com
Cc: jcm@redhat.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, bcm-kernel-feedback-list@broadcom.com, aleksey.makarov@linaro.org, gregkh@linuxfoundation.org, patches@apm.com, Loc Ho <lho@apm.com>
List-Id: linux-acpi@vger.kernel.org

v2:
* Merged Jon Mason patch with APM X-Gene patch

Loc Ho (2):
  ACPI: SPCR: Use access width to determine mmio usage
  ACPI: SPCR: Workaround for APM X-Gene 8250 UART 32-alignment errata

 drivers/acpi/spcr.c     | 40 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/acrestyp.h |  7 +++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

-- 
1.8.3.1
