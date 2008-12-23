From: "Gunnar R. Bartels" <grb@eddh.de>
Subject: DELL Precision M2400
Date: Tue, 23 Dec 2008 10:22:02 +0100
Message-ID: <200812231022.02520.grb@eddh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cwebert1.c.dnsbox.de ([81.3.62.130]:2799 "EHLO
	cwebert1.c.dnsbox.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYLWJhs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Dec 2008 04:37:48 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, Everybody,

to be honest - I don't know at all, what this is about. But with my new DELL, 
I found the following lines in boot.log:


<5>ACPI: DMI System Vendor: Dell Inc.
<5>ACPI: DMI Product Name: Precision M2400                 
<5>ACPI: DMI Product Version: 
<5>ACPI: DMI Board Name: 0HT029
<5>ACPI: DMI BIOS Vendor: Dell Inc.
<5>ACPI: DMI BIOS Date: 09/01/2008
<5>ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
<5>ACPI: If "acpi_osi=Linux" works better, please notify linux-
acpi@vger.kernel.org


... and being a good guy, I do as is advised... :=))

The "acpi_osi=Linux" setting works better, as it makes the following error 
disappear: 

<4>mtrr: your CPUs had inconsistent fixed MTRR settings
<6>mtrr: probably your BIOS does not setup all CPUs.
<6>mtrr: corrected configuration.

Nevertheless, the machine has (obviously) been properly working without the 
Parameter.

My Linux is a SuSE 11.1 with vanilla Kernel 2.6.27.7-9-default.

Have a merry christmas and a happy new year!!

Greetings from beautiful Austria

Gunnar R. Bartels






