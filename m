From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/6] Minimize ACPICA/linux GPE code divergence
Date: Mon, 06 Dec 2010 23:58:15 +0800
Message-ID: <1291651095.2197.78.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45797 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0LFP5w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Dec 2010 10:57:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi, Rafael

We have ported below of your GPE patches into ACPICA code base.

0001-ACPI-ACPICA-Do-not-execute-_PRW-methods-during-initi.patch
0002-ACPI-ACPICA-Fail-acpi_gpe_wakeup-if-ACPI_GPE_CAN_WAK.patch
0003-ACPI-ACPICA-Simplify-acpi_ev_initialize_gpe_block.patch
0004-ACPI-ACPICA-Fix-reference-counting-problems-with-GPE.patch
0005-ACPI-ACPICA-Defer-enabling-of-runtime-GPEs-v3.patch

You can find the ACPICA port at,
http://git.moblin.org/cgit.cgi/acpica/commit/?id=3bc77e86ae03b3ceb7241f224053e399fb3f56b2

As the port, some changes were made, function and variable renamed, etc,
and new features were added, implicit notify, global event handler, etc.

These changes and new features introduce a lot of ACPICA/linux GPE code
divergence. So this series of patches is to minimize this type of
divergence.

[PATCH 1/6] ACPICA: Move GPE functions to new file evxfgpe.c
[PATCH 2/6] ACPICA: Rename some function and variable names
[PATCH 3/6] ACPICA: Remove unused function declarations
[PATCH 4/6] ACPICA: Implicit notify support
[PATCH 5/6] ACPICA: Global event handler
[PATCH 6/6] ACPICA: Misc comments to minimize code divergence

Thanks for any comments.

Lin Ming




