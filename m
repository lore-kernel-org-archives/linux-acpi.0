From: Viswesh S <viswesh_vichu@yahoo.com>
Subject: Device detection in ACPI
Date: Mon, 22 Sep 2008 07:57:45 -0700 (PDT)
Message-ID: <603133.88716.qm@web31606.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web31606.mail.mud.yahoo.com ([68.142.198.152]:38154 "HELO
	web31606.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751034AbYIVPEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Sep 2008 11:04:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

We have a PnP device,with pci bus number 4, device and ftn number to be zeroes.After the kernel has come up, we can see the device in lspci.

But when we disassemble the DSDT, I am not able to find the device info ( The _ADR doesnt match the required number).I have decoded ( actually gone through the entire DSDT file) but still couldnt find a reference to our device in it.

Is it always required that, all the device configuration, detection, should be present in DSDT file.Our device needs PCI routing also, so hopefully there should be an entry in any of the _PRT.

But I couldnt find any.

Could anyone let me know the normal procedure to decode a DSDT file.

Thanks,

Viswesh


      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
