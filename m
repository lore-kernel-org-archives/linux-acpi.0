From: Julian Wollrath <julian.wollrath@stud.uni-goettingen.de>
Subject: New ACPI warnings with v3.16.0-rc1
Date: Wed, 18 Jun 2014 23:50:04 +0200
Message-ID: <20140618235004.25295650@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xmailer.gwdg.de ([134.76.10.29]:56970 "EHLO xmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbaFRWXI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jun 2014 18:23:08 -0400
Received: from [134.76.11.225] (helo=email.stud.uni-goettingen.de)
	by mailer.gwdg.de with esmtp (Exim 4.80)
	(envelope-from <julian.wollrath@stud.uni-goettingen.de>)
	id 1WxNk6-0007MF-A4
	for linux-acpi@vger.kernel.org; Wed, 18 Jun 2014 23:50:06 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

with v3.16.0-rc1 I get the following warnings, which I did not occur
with v3.15.1:
[   14.558365] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000000047f (\_SB_.PCI0.LPC_.PMIO) (20140424/utaddress-258)
[   14.558377] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558386] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558392] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558395] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558401] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
[   14.558403] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
[   14.558409] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver

How can one find out, what the native driver is, and if there is an
ACPI driver?


Thank you for your time, with best regards,
Julian Wollrath
