From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Advice on result of using acpi_osi=Linux
Date: Wed, 23 Apr 2008 14:42:57 +1000
Message-ID: <480EBE51.1000408@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nschwmtas05p.mx.bigpond.com ([61.9.189.149]:21479 "EHLO
	nschwmtas05p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059AbYDWEnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Apr 2008 00:43:11 -0400
Received: from nschwotgx01p.mx.bigpond.com ([58.170.62.70])
          by nschwmtas05p.mx.bigpond.com with ESMTP
          id <20080423044308.ZSUE15832.nschwmtas05p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>
          for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 04:43:08 +0000
Received: from mudlark.pw.nest ([58.170.62.70])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20080423044308.GILE1861.nschwotgx01p.mx.bigpond.com@mudlark.pw.nest>
          for <linux-acpi@vger.kernel.org>; Wed, 23 Apr 2008 04:43:08 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

As requested via syslog message, I'm reporting the results I obtained 
using acpi_osi=Linux on the boot command line:

Without this addition to command line, I get:

Apr 23 14:04:38 mudlark kernel: ACPI: BIOS _OSI(Linux) query ignored
Apr 23 14:04:38 mudlark kernel: ACPI: DMI System Vendor: 

Apr 23 14:04:38 mudlark kernel: ACPI: DMI Product Name: 

Apr 23 14:04:38 mudlark kernel: ACPI: DMI Product Version: 

Apr 23 14:04:38 mudlark kernel: ACPI: DMI Board Name: DG31PR
Apr 23 14:04:38 mudlark kernel: ACPI: DMI BIOS Vendor: Intel Corp.
Apr 23 14:04:38 mudlark kernel: ACPI: DMI BIOS Date: 09/28/2007
Apr 23 14:04:38 mudlark kernel: ACPI: Please send DMI info above to 
linux-acpi@vger.kernel.org
Apr 23 14:04:38 mudlark kernel: ACPI: If "acpi_osi=Linux" works better, 
please notify linux-acpi@vger.kernel.org

With this addition, I get:

Apr 23 14:13:57 mudlark kernel: ACPI: BIOS _OSI(Linux) query honored via 
cmdline
Apr 23 14:13:57 mudlark kernel: ACPI: DMI System Vendor: 

Apr 23 14:13:57 mudlark kernel: ACPI: DMI Product Name: 

Apr 23 14:13:57 mudlark kernel: ACPI: DMI Product Version: 

Apr 23 14:13:57 mudlark kernel: ACPI: DMI Board Name: DG31PR
Apr 23 14:13:57 mudlark kernel: ACPI: DMI BIOS Vendor: Intel Corp.
Apr 23 14:13:57 mudlark kernel: ACPI: DMI BIOS Date: 09/28/2007
Apr 23 14:13:57 mudlark kernel: ACPI: Please send DMI info above to 
linux-acpi@vger.kernel.org

I'm not sure if this constitutes better but I thought I'd report it anyway.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
