From: Don <harterc1@comcast.net>
Subject: acpi dump per request
Date: Fri, 05 Sep 2008 01:37:43 -0500
Message-ID: <48C0D3B7.2010405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:54861 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752208AbYIELnT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 07:43:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Just installed a new motherboard.  It is a Asus M2N-SLI.   I saw the 
following in the log.

hdc: UDMA/66 mode selected
hdc: UDMA/33 mode selected
hdc: CHECK for good STATUS
powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core Processor 5000+ 
processors (2 cpu cores) (version 2.20.00)
powernow-k8: ACPI Processor support is required for SMP systems but is 
absent. Please load the ACPI Processor module before starting this driver.
powernow-k8: ACPI Processor support is required for SMP systems but is 
absent. Please load the ACPI Processor module before starting this driver.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ip6_tables: (C) 2000-2006 Netfilter Core Team
NET: Registered protocol family 17
ACPI Exception (thermal-0469): AE_ERROR, ACPI thermal trip point state 
changed
Please send acpidump to linux-acpi@vger.kernel.org

I tried to send this to the mailing list but the majordomo keeps 
rejecting it.
So here is a url to where it is stored..
http://home.comcast.net/~harterc1/acpidump.txt

