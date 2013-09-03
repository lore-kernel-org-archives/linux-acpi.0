From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH v2 0/4] acpi: Fix and cleanup in acpi.
Date: Tue, 3 Sep 2013 16:45:37 +0800
Message-ID: <1378197941-26479-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, joe@perches.com, toshi.kani@hp.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch-set fix the following problems:

1. Kill useless function save_add_info() which will block us from using
   numa when MEMORY_HOTPLUG is not configured.
2. acpi_table_parse() didn't check if @id is NULL.
3. Fix incorrect comment in acpi_table_parse(), and return -ENOENT if a
   table is not found.

And also did some cleanup.

change log v1 -> v2:
1. Use pr_fmt() to simply the SRAT message.
   Suggested by Joe Perches <joe@perches.com>
2. Improve the log in patch 4, and change the return value of the stub of 
   acpi_table_parse() in linux/acpi.h
   Suggested by Toshi Kani <toshi.kani@hp.com>
3. Merge the two pr_{info|err} patches into one.
4. Remove on of the patch that has been merged by Rafael.

Tang Chen (4):
  acpi, numa, mem_hotplug: Kill save_add_info().
  acpi cleanup: Use pr_{info|err}() instead of printk() in
    arch/x86/mm/srat.c
  acpi: Check if @id is NULL in acpi_table_parse()
  acpi: Return -ENOENT in acpi_table_parse() and fix wrong comment.

 arch/x86/mm/srat.c    |   40 +++++++++++++++++-----------------------
 drivers/acpi/tables.c |    9 +++++----
 include/linux/acpi.h  |    2 +-
 3 files changed, 23 insertions(+), 28 deletions(-)
