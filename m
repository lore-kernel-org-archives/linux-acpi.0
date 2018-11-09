From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 00/23] various dynamic_debug patches
Date: Sat, 10 Nov 2018 00:09:58 +0100
Message-ID: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
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

v2: Added various acks/reviews.

v3: Rebased on top of v4.20-rc1, and (consequently) reimplemented the
x86 part using Nadav's asm macro infrastructure. I've taken the
liberty of preserving acks/reviews for the first 20, since the rebase
was completely clean. OTOH, I've removed any acks/reviews from the
last three patches, since they are essentially completely new in this
version.

Since there are some interdependencies, it's simplest if these go
through the same tree. Andrew, can I get you to pick up patches 1
through 17? They should be ready for some time in -next. If and when
the last three (new) patches get ack'ed, I'll ask you to pick up the
last 6 (Jason has ack'ed 18-20, but they don't make much sense without
at least one arch opting in to use DYNAMIC_DEBUG_RELATIVE_POINTERS).

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
  jump_label: move JUMP_TYPE_* constants to new asm-generic file
  x86: jump_label: introduce asm macros STATIC_KEY_INIT{,_TRUE,_FALSE}
  x86_64: use relative pointers with dynamic debug

 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/dynamic_debug.h |  58 ++++++++++++
 arch/x86/include/asm/jump_label.h    |  17 ++++
 arch/x86/kernel/macros.S             |   1 +
 fs/btrfs/ctree.h                     |  34 ++-----
 include/asm-generic/jump_label.h     |  11 +++
 include/linux/acpi.h                 |  11 +--
 include/linux/device.h               |   6 +-
 include/linux/dynamic_debug.h        | 126 +++++++++++++++----------
 include/linux/jump_label.h           |   6 +-
 include/linux/net.h                  |   6 +-
 include/linux/printk.h               |   6 +-
 kernel/module.c                      |   6 +-
 lib/Kconfig.debug                    |   3 +
 lib/dynamic_debug.c                  | 133 ++++++++++++++++++---------
 15 files changed, 284 insertions(+), 141 deletions(-)
 create mode 100644 arch/x86/include/asm/dynamic_debug.h
 create mode 100644 include/asm-generic/jump_label.h

-- 
2.19.1.6.gbde171bbf5
