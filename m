From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] gts and bfs fixes (v2).
Date: Mon,  9 Apr 2012 22:34:04 -0400
Message-ID: <1334025246-8811-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:28787 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab2DJCi7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Apr 2012 22:38:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ming.m.lin@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, konrad.r.wilk@gmail.com

Please consider these the two fixes to how gts and bfs parameters
are handled in 3.4-rc2:

I had sent an earlier version of 
 [PATCH 1/2] ACPI: Convert wake_sleep_flags to a value instead of

to Lin and he had reviewed it, but I redid it a bit so a second
look will be required.

The:
 [PATCH 2/2] ACPI: Pass u8 flag to acpi_enter_sleep_state from

is a regression fix - as the wakeup flag was not passed from the
assembler code to the acpi_enter_sleep_ function.

 arch/x86/kernel/acpi/sleep.h     |    2 +
 arch/x86/kernel/acpi/wakeup_32.S |    5 +++-
 arch/x86/kernel/acpi/wakeup_64.S |    3 ++
 drivers/acpi/sleep.c             |   52 ++++++++++++++++++++-----------------
 4 files changed, 37 insertions(+), 25 deletions(-)

Konrad Rzeszutek Wilk (2):
      ACPI: Convert wake_sleep_flags to a value instead of function (v2)
      ACPI: Pass u8 flag to acpi_enter_sleep_state from lowlevel assembler.


