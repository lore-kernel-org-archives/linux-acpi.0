From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 00/14] various dynamic_debug patches
Date: Tue, 12 Feb 2019 22:41:36 +0100
Message-ID: <20190212214150.4807-1-linux@rasmusvillemoes.dk>
References: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, David Sterba <dsterba@suse.com>, Petr Mladek <pmladek@suse.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-btrfs@vger.kernel.org, netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-acpi@vger.kernel.org

This started as an experiment to see how hard it would be to change
the four pointers in struct _ddebug into relative offsets, a la
CONFIG_GENERIC_BUG_RELATIVE_POINTERS, thus saving 16 bytes per
pr_debug site (and thus exactly making up for the extra space used by
the introduction of jump labels in 9049fc74). I stumbled on a few
things that are probably worth fixing regardless of whether that goal
is deemed worthwhile.

Back at v3 (in November), I redid the implementation on top of the
fancy new asm-macros stuff. Luckily enough, v3 didn't get picked up,
since the asm-macros were backed out again. I still want to do the
relative-pointers thing eventually, but we're close to the merge
window opening, so here's just most of the "incidental" patches, some
of which also serve as preparation for the relative pointers.

I'm not sure how long an Ack/Reviewed-by is good for, but OTOH it also
feels rude to just drop them on the floor. I've kept those tags since
the rebasing to current master went completely smooth.

Andrew, please pick these up for soaking in -next.

v3 series: lkml.kernel.org/r/20181109231021.11658-1-linux@rasmusvillemoes.dk
v2 series: lkml.kernel.org/r/20181009112013.14238-1-linux@rasmusvillemoes.dk

Rasmus Villemoes (14):
  linux/device.h: use DYNAMIC_DEBUG_BRANCH in dev_dbg_ratelimited
  linux/net.h: use DYNAMIC_DEBUG_BRANCH in net_dbg_ratelimited
  linux/printk.h: use DYNAMIC_DEBUG_BRANCH in pr_debug_ratelimited
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

 fs/btrfs/ctree.h              |  34 ++++--------
 include/linux/acpi.h          |  11 +---
 include/linux/device.h        |   2 +-
 include/linux/dynamic_debug.h | 102 +++++++++++++++++++---------------
 include/linux/net.h           |   2 +-
 include/linux/printk.h        |   2 +-
 kernel/module.c               |   6 +-
 lib/dynamic_debug.c           |  22 ++++----
 8 files changed, 84 insertions(+), 97 deletions(-)

-- 
2.20.1
