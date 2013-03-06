From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [RESEND PATCH 0/6] Fix some coding style and comment problems.
Date: Wed, 6 Mar 2013 16:30:05 +0800
Message-ID: <1362558611-32255-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Fix some coding style and comment problems I saw when I was reading the code.

Tang Chen (6):
  acpi: Remove the leading space of "unlock" label in
    acpi_memory_device_notify().
  acpi: Add missing parameter comment for acpi_get_table_with_size().
  acpi: Remove the leading spaces of "finish_override" label in
    acpi_tb_table_override().
  acpi: Remove the leading spaces of "unmap_and_exit" label in
    acpi_tb_install_table().
  acpi: Add the missing parameter comment for acpi_initialize_tables().
  doc: Fix a wrong comment in Documentation/hw_random.txt

 Documentation/hw_random.txt    |    2 +-
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/acpi/acpica/tbinstal.c |    2 +-
 drivers/acpi/acpica/tbutils.c  |    2 +-
 drivers/acpi/acpica/tbxface.c  |    6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

