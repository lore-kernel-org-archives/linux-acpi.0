From: Pingfan Liu <kernelfans@gmail.com>
Subject: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by pushing forward the parsing of mem hotplug info
Date: Mon,  7 Jan 2019 16:24:41 +0800
Message-ID: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Background about the defect of the current bottom-up allocation style, take
the following scenario:
  |  unmovable node |     movable node                           |
     | kaslr-kernel |subtree of pgtable for phy<->virt |

Although kaslr-kernel can avoid to stain the movable node. But the
pgtable can still stain the movable node. That is a probability problem,
with low probability, but still exist. This patch tries to eliminate the
probability. With the previous patch, at the point of init_mem_mapping(),
memblock allocator can work with the knowledge of acpi memory hotmovable
info, and avoid to stain the movable node. As a result,
memory_map_bottom_up() is not needed any more.


Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (4):
  acpi: change the topo of acpi_table_upgrade()
  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
  x86/mm: set allowed range for memblock allocator
  x86/mm: remove bottom-up allocation style for x86_64

 arch/arm64/kernel/setup.c |   2 +-
 arch/x86/kernel/setup.c   |  17 ++++-
 arch/x86/mm/init.c        | 154 +++++++---------------------------------------
 arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mm_internal.h |   7 +++
 drivers/acpi/tables.c     |   4 +-
 include/linux/acpi.h      |   5 +-
 7 files changed, 172 insertions(+), 140 deletions(-)

-- 
2.7.4
