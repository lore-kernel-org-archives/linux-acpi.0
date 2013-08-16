From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 0/6] acpi: Fix and cleanup in acpi.
Date: Fri, 16 Aug 2013 15:06:43 +0800
Message-ID: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch-set fix the following problems:

1. Kill useless function save_add_info() which will block us from using
   numa when MEMORY_HOTPLUG is not configured.
2. acpi_table_parse() didn't check if @id is NULL.
3. Fix incorrect comment in acpi_table_parse(), and return -ENOENT if a
   table is not found.

And also did some cleanup.

Tang Chen (6):
  acpi, numa, mem_hotplug: Kill save_add_info().
  acpi, numa, mem_hotplug: Print Hot-Pluggable Field in SRAT.
  acpi cleanup: Use pr_info() instead of printk() in arch/x86/mm/srat.c
  acpi cleanup: Use pr_err() instead of printk() in arch/x86/mm/srat.c
  acpi: Check if @id is NULL in acpi_table_parse()
  acpi: Return -ENOENT in acpi_table_parse() and fix wrong comment.

 arch/x86/mm/srat.c    |   38 +++++++++++++++++---------------------
 drivers/acpi/tables.c |    9 +++++----
 2 files changed, 22 insertions(+), 25 deletions(-)
