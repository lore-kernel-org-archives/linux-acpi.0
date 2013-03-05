From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 0/6] Fix some coding style and comment problems.
Date: Tue, 5 Mar 2013 16:23:22 +0800
Message-ID: <1362471808-9437-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl, robert.moore@intel.com, lv.zheng@intel.com, ming.m.lin@intel.com, mpm@selenic.com, herbert@gondor.apana.org.au, rob@landley.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, trival@kernel.org
List-Id: linux-acpi@vger.kernel.org

Fix some coding style and comment problems I saw when I was reading the code.

Tang Chen (6):
  In acpi_memory_device_notify()
  In acpi_get_table_with_size()
  In acpi_tb_table_override()
  In acpi_tb_install_table()
  In acpi_initialize_tables()
  In Documentation/hw_random.txt

 Documentation/hw_random.txt    |    2 +-
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/acpi/acpica/tbinstal.c |    2 +-
 drivers/acpi/acpica/tbutils.c  |    2 +-
 drivers/acpi/acpica/tbxface.c  |    6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

