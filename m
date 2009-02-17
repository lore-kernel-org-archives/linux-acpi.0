From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: [2.6.29-rc5 ACPI] truncated dsobject list...
Date: Tue, 17 Feb 2009 16:31:38 +0000
Message-ID: <6278d2220902170831n3801a935x578b5dff64d00c62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:40133 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZBQQbk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Feb 2009 11:31:40 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

With 2.6.29-rc5 on an Intel S5000PAL server (BIOS
S5000.86B.10.60.0091.100920081631), we see ACPI object list truncation
[1]. Does it make sense to increase the default element allocation?

Many thanks,
  Daniel

--- [1]

ACPI: EC: Look up EC in DSDT
ACPI Warning (dsobject-0502): Package List length (6) larger than
NumElements count (4), truncated
[20081204]
-- 
Daniel J Blueman
