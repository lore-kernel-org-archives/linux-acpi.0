From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 00/23] various dynamic_debug patches
Date: Tue,  9 Oct 2018 13:19:50 +0200
Message-ID: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

v2: Added various acks/reviews. I'll follow up with rewriting the x86
part as asm macros once that work is in mainline.

Patches 15, 16 are in next-20181009; in hindsight I should probably
have asked Rafael not to pick those. Patch 17 textually depend on
those, and patch 19 removes the .flags field, so depends on 15 so that
there are no references to that field. I'm included all patches here
hoping that the merge conflicts are trivial, given that it's just same
patches present in multiple branches.

Andrew, can you pick up these to give them some time in -next?

v1 cover letter:

This started as an experiment to see how hard it would be to change
the four pointers in struct _ddebug into relative offsets, a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
pr_debug site (and thus exactly making up for the extra space used by
the introduction of jump labels in 9049fc74). I stumbled on a few
things that are probably worth fixing regardless of whether the latter
half of this series is deemed worthwhile.

Patch relationships: 1-2, 3-4, 5-6 and 15-16 can be applied
individually, though 2, 4 and 6 probably makes most sense in the
context of the final goal of the series.

7-12 I believe make sense on their own. Patch 13 again only makes
sense if we go all the way, and 14 and 17 depend on 13.

18-21 are more preparatory patches, and finally 22 switch over x86-64
to use CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS. I've tested that the
end result boots under virtme and that the dynamic_debug control file
has the expected contents.

Rasmus Villemoes (23):
  linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
  linux/device.h: use unique identifier for each struct _ddebug
  linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
  linux/net.h: use unique identifier for each struct _ddebug
  linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
  linux/printk.h: use unique identifier for each struct _ddebug
  dynamic_debug: consolidate DEFINE_DYNAMIC_DEBUG_METADATA definitions
  dynamic_debug: don't duplicate modname in ddebug_add_module
  dynamic_debug: use pointer comparison in ddebug_remove_module
  dynamic_debug: remove unused EXPORT_SYMBOLs
  dynamic_debug: move pr_err from module.c to ddebug_add_module
  dynamic_debug: add static inline stub for ddebug_add_module
  dynamic_debug: refactor dynamic_pr_debug and friends
  btrfs: implement btrfs_debug* in terms of helper macro
  ACPI: use proper DYNAMIC_DEBUG_BRANCH macro
  ACPI: remove unused __acpi_handle_debug macro
  ACPI: implement acpi_handle_debug in terms of _dynamic_func_call
  dynamic_debug: introduce accessors for string members of struct
    _ddebug
  dynamic_debug: drop use of bitfields in struct _ddebug
  dynamic_debug: introduce CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS
  x86: jump_label: introduce ASM_STATIC_KEY_INIT_{TRUE,FALSE}
  x86_64: use relative pointers with dynamic debug
  x86: dynamic_debug: protect against dynamic debug identifier reuse

 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/dynamic_debug.h |  40 ++++++++
 arch/x86/include/asm/jump_label.h    |  18 ++++
 fs/btrfs/ctree.h                     |  34 ++-----
 include/linux/acpi.h                 |  11 +--
 include/linux/device.h               |   6 +-
 include/linux/dynamic_debug.h        | 126 +++++++++++++++----------
 include/linux/jump_label.h           |   2 +
 include/linux/net.h                  |   6 +-
 include/linux/printk.h               |   6 +-
 kernel/module.c                      |   6 +-
 lib/Kconfig.debug                    |   3 +
 lib/dynamic_debug.c                  | 133 ++++++++++++++++++---------
 13 files changed, 256 insertions(+), 136 deletions(-)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h

-- 
2.19.1.3.g1d92a00e68
