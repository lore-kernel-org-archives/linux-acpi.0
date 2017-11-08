From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 0/2] Restructure and fix GHES PCIe AER handling
Date: Wed,  8 Nov 2017 12:13:10 -0700
Message-ID: <1510168392-30114-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdKHTNR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Nov 2017 14:13:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, tony.luck@intel.com, bp@alien8.de, bp@suse.de, will.deacon@arm.com, james.morse@arm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>

First, break the PCIe AER handling out into its own function to separate
it from the standard GHES processing

Then fix the AER handling to process all errors in the AER driver rather
than only handling recoverable errors.

Tyler Baicar (2):
  acpi: apei: handle PCIe AER errors in separate function
  acpi: apei: call into AER handling regardless of severity

 drivers/acpi/apei/ghes.c | 62 +++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

