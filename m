From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] acpi: Better describe ACPI_DEBUGGER
Date: Mon, 30 Nov 2015 22:32:15 +0100
Message-ID: <20151130213215.GC3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34105 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbbK3VcU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2015 16:32:20 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, acpi@linux.intel.com

Hi,

For a brief moment I was tricked into thinking that:

  In-kernel debugger (EXPERIMENTAL) (ACPI_DEBUGGER) [N/y/?] (NEW)

might be something useful. Better describe the feature to reduce
such confusion.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 25dbb76c02cc..5eef4cb4f70e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -58,10 +58,10 @@ config ACPI_CCA_REQUIRED
 	bool
 
 config ACPI_DEBUGGER
-	bool "In-kernel debugger (EXPERIMENTAL)"
+	bool "AML debugger interface (EXPERIMENTAL)"
 	select ACPI_DEBUG
 	help
-	  Enable in-kernel debugging facilities: statistics, internal
+	  Enable in-kernel debugging of AML facilities: statistics, internal
 	  object dump, single step control method execution.
 	  This is still under development, currently enabling this only
 	  results in the compilation of the ACPICA debugger files.
