From: Len Brown <len.brown@intel.com>
Subject: [GIT PATCH] fix ACPI interrupt regression in 2.6.19
Date: Sat, 2 Dec 2006 02:56:04 -0500
Message-ID: <200612020256.05317.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:18591 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1162817AbWLBHxE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Dec 2006 02:53:04 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus, Greg/Chris,

please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This is a single revert on top of 2.6.19.
If  fixes a regression which was introduced after 2.6.18 and before 2.6.19.

thanks!
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.19/acpi-release-20060707-2.6.19.diff.gz

 arch/i386/kernel/acpi/boot.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

through these commits:

Len Brown (1):
      Revert "ACPI: SCI interrupt source override"

with this log:

commit 7bdd21cef9e5dbc3d3a718c55bb3d0da024644da
Author: Len Brown <len.brown@intel.com>
Date:   Sat Dec 2 02:27:46 2006 -0500

    Revert "ACPI: SCI interrupt source override"

    This reverts commit 281ea49b0c294649a6de47a6f8fbe5611137726b,
    which broke ACPI Interrupt source overrides that move
    the SCI from one IRQ in PIC mode to another in IOAPIC mode.

    If the SCI shared an interrupt line with another device,
    this would result in a "irq 18: nobody cared" type failure.

    http://bugzilla.kernel.org/show_bug.cgi?id=7601

    Signed-off-by: Len Brown <len.brown@intel.com>

