From: Jean Sacren <sakiwit@gmail.com>
Subject: [PATCH 0/1] acpi: Fix warning: 'num_cpus' may be used
 uninitialized in this function
Date: Sat, 11 Sep 2010 00:22:54 -0600
Message-ID: <20100911062254.GA18705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53301 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0IKGWz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Sep 2010 02:22:55 -0400
Received: by pwi3 with SMTP id 3so1315714pwi.19
        for <linux-acpi@vger.kernel.org>; Fri, 10 Sep 2010 23:22:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

Hi,

Self-explanatory warning message.

Jean Sacren (1):
  acpi: Fix warning: 'num_cpus' may be used uninitialized in this
    function

 drivers/acpi/acpi_pad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
Jean Sacren
Bring LAMP To People
