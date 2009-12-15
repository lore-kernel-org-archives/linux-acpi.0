From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20091214 linuxized patch
Date: Tue, 15 Dec 2009 13:12:25 +0800
Message-ID: <1260853945.3834.48.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50565 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbZLOF2K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 00:28:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Hi, Len

ACPICA release 20091214 linuxized patch attached.
Applied cleanly on top of Linus' tree.
Build and test on 32&64 bit machines.

[PATCH 01/16] ACPICA: Fix possible memory leak for module-level code execution
[PATCH 02/16] ACPICA: Fix two Scope type error messages
[PATCH 03/16] ACPICA: Fix two additional Scope override error messages
[PATCH 04/16] ACPICA: Add repair for bad _FDE/_GTM buffers
[PATCH 05/16] ACPICA: Update internal namespace node/handle interfaces
[PATCH 06/16] ACPICA: Add more conversions to predefined name repair module
[PATCH 07/16] ACPICA: Update function headers, no functional change
[PATCH 08/16] ACPICA: Fix mutex errors when running _REG methods
[PATCH 09/16] ACPICA: Move Package-to-Buffer repair code into common ToBuffer function
[PATCH 10/16] ACPICA: Remove messages if predefined repair(s) are successful
[PATCH 11/16] ACPICA: Update function headers and comments, no functional change
[PATCH 12/16] ACPICA: Conditionally perform complex per-predefined-name repairs
[PATCH 13/16] ACPICA: Module-level code: enable _REG execution in same scope
[PATCH 14/16] ACPICA: Predefined name repair: automatically remove null package elements
[PATCH 15/16] ACPICA: Move check for valid Thread ID structure
[PATCH 16/16] ACPICA: Update version to 20091214

Lin Ming


