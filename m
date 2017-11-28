From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V4 0/2] Restructure and fix GHES PCIe AER handling
Date: Tue, 28 Nov 2017 16:48:07 -0500
Message-ID: <1511905689-11522-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdK1VsV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Nov 2017 16:48:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, tony.luck@intel.com, will.deacon@arm.com, james.morse@arm.com
Cc: bp@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Tyler Baicar <tbaicar@codeaurora.org>

First, break the PCIe AER handling out into its own function to separate
it from the standard GHES processing

Then fix the AER handling to process all errors in the AER driver rather
than only handling recoverable errors.

V4: Rebase to 4.15-rc1 and add reviewed-by

Tyler Baicar (2):
  acpi: apei: handle PCIe AER errors in separate function
  acpi: apei: call into AER handling regardless of severity

 drivers/acpi/apei/ghes.c | 76 +++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

