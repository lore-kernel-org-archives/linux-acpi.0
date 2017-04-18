From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/6] ACPI: Fine-tuning for some function implementations
Date: Tue, 18 Apr 2017 18:48:10 +0200
Message-ID: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:51697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdDRQsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 12:48:36 -0400
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@suse.de>, Chun-Yi Lee <joeyli.kernel@gmail.com>, Colin Ian King <colin.king@canonical.com>, Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 18:28:18 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (6):
  fan: Use devm_kcalloc() in acpi_fan_get_fps()
  fan: Delete error messages for a failed memory allocation in two functions
  nfit: Use devm_kcalloc() in nfit_mem_dcr_init()
  einj: Replace 12 seq_printf() calls by seq_puts() in available_error_type_show()
  battery: Replace 16 seq_printf() calls by seq_puts()
  proc: Replace two seq_printf() calls by seq_puts() in acpi_system_wakeup_device_seq_show()

 drivers/acpi/apei/einj.c | 25 +++++++++++++------------
 drivers/acpi/battery.c   | 34 +++++++++++++++++-----------------
 drivers/acpi/fan.c       |  9 +++------
 drivers/acpi/nfit/core.c |  8 +++++---
 drivers/acpi/proc.c      |  4 ++--
 5 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.12.2

