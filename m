From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 0/3] ACPI: Support for platform initiated graceful shutdown
Date: Wed, 16 Mar 2016 13:36:59 -0600
Message-ID: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60401 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934750AbcCPThP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 15:37:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net, Prashanth Prakash <pprakash@codeaurora.org>

This patch-set adds support for platform initited graceful shutdown as
described in the sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec

Jonathan (Zhixiong) Zhang (1):
  ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h

Prashanth Prakash (2):
  ACPI / sybus: add a driver for LNXSYBUS device
  ACPI: update the definition of common notification values

 drivers/acpi/Kconfig        |   6 +++
 drivers/acpi/Makefile       |   1 +
 drivers/acpi/scan.c         |   3 +-
 drivers/acpi/sybus.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |   1 +
 include/acpi/actypes.h      |   2 +-
 6 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/sybus.c

-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

