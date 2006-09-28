From: "Brown, Len" <len.brown@intel.com>
Subject: fadt.boot_flags.MSI_not_supported
Date: Wed, 27 Sep 2006 20:14:58 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16783 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S964941AbWI1API convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Sep 2006 20:15:08 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

sifting through ACPI 3.0a I just noticed a bit (3)
in the FADT boot_flag to indicate the platform
does not support MSI.

Has anybody noticed fadt.boot_flags bit 3 set on their box?

thanks,
-Len
