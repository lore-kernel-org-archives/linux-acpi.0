From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [GIT PULL/PATCH] gts and bfs fixes (v5).
Date: Sun, 22 Apr 2012 23:03:16 -0400
Message-ID: <1335150198-21899-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, hpa@zytor.com, x86@kernel.org, rjw@sisk.pl
List-Id: linux-acpi@vger.kernel.org

Please git pull (or use the patches that follow this email) the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/xen.git stable/for-x86-for-3.4

Changes since v4 [https://lkml.org/lkml/2012/4/18/396]
 - Added Acked and Reviewed-by
v2 [https://lkml.org/lkml/2012/4/9/474]
 - ditched the assembler version and used a C wrapper

With git commit a2ef5c4fd44ce3922435139393b89f2cce47f576
"ACPI: Move module parameter gts and bfs to sleep.c" the
sampling of gts/bfs module parameters flag by acpi_enter_sleep_state
has been moved. It has been moved out of the inner ACPI code and
out in the more x86 specific. This means that any caller of
the exported acpi_enter_sleep_state function needs to provide
two parameters now: sleep state and the bit flag whether to us _GTS|_BFS.

All of the callers of acpi_enter_sleep_state did that, with
the exception of the assembler version and as well any
third-party callers of acpi_enter_sleep_state.

These two patches expose 'wake_sleep_flags' as the product
of the gts/bfs module parameter invocation. And also use said
flag in the assembler 'do_suspend_lowlevel()' function.

Konrad Rzeszutek Wilk (2):
      ACPI: Convert wake_sleep_flags to a value instead of function (v5)
      x86/acpi: Call acpi_enter_sleep_state via an asmlinkage C function from assembler (v2).

 arch/x86/kernel/acpi/sleep.c     |    4 +++
 arch/x86/kernel/acpi/sleep.h     |    4 +++
 arch/x86/kernel/acpi/wakeup_32.S |    4 +--
 arch/x86/kernel/acpi/wakeup_64.S |    4 +--
 drivers/acpi/sleep.c             |   52 ++++++++++++++++++++-----------------
 5 files changed, 38 insertions(+), 30 deletions(-)
