From: Fred Labrosse <fred@labrosses.plus.com>
Subject: acpi_apic_instance=2
Date: Fri, 8 May 2009 19:11:58 +0100
Message-ID: <200905081911.58294.fred@labrosses.plus.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:26448 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751994AbZEHSV6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 14:21:58 -0400
Received: from [87.115.171.100] (helo=[192.168.1.101])
	 by pih-relay05.plus.net with esmtp (Exim) id 1M2UYA-00086d-UN
	for linux-acpi@vger.kernel.org; Fri, 08 May 2009 19:11:59 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

The kernel not detecting my dual core pentium when ACPI was enabled, I looked 
at dmesg and saw:

ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify 
linux-acpi@vger.kernel.org

I therefore tried that and my two cores are now detected properly.  So I'm 
notifying you.

Hope this helps.  Please tell me if you need more info.

Fred
