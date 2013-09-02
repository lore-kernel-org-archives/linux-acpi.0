From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH RESEND 0/3] x86, ACPI, mm: Cleanup for {max|low|max_low}_pfn_mapped.
Date: Mon, 2 Sep 2013 18:30:26 +0800
Message-ID: <1378117829-9095-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, hpa@zytor.com, yinghai@kernel.org, penberg@kernel.org, jacob.shin@amd.com, tglx@linutronix.de, lenb@kernel.org, rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch-set does the following:
1. Kill max_low_pfn_mapped as it is useless.
   This patch is from Yinghai.
2. Update min_pfn_mapped and max_pfn_mapped together in add_pfn_range_mapped().
3. Move definition of max_pfn_mapped tp init.c together with min_pfn_mapped.


Tang Chen (2):
  x86, mm: Update min_pfn_mapped in add_pfn_range_mapped().
  x86, mm: Move max_pfn_mapped definition to init.c.

Yinghai Lu (1):
  x86, ACPI, mm: Kill max_low_pfn_mapped.

 arch/x86/include/asm/page_types.h |    1 -
 arch/x86/kernel/setup.c           |   10 ----------
 arch/x86/mm/init.c                |   15 ++++++++++-----
 drivers/acpi/osl.c                |    6 +++---
 4 files changed, 13 insertions(+), 19 deletions(-)
