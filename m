From: Andreas Saur <saur@acmelabs.de>
Subject: RE: 2.6.17-rc4-mm3 - kernel panic
Date: Thu, 25 May 2006 22:33:45 +0000
Message-ID: <447630C9.9020204@acmelabs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from natlemon.rzone.de ([81.169.145.170]:2549 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1030488AbWEYWdZ
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 18:33:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, kristen.c.accardi@intel.com

Hello Kristen,

I've applied your little patch on kernel 2.6.17-rc4-mm3. Booted without 
panic!!
I've also turned on the kernel debug logging, since you not mentioned 
any additional options to turn on, I've left the default settings.
Here is the dmesg: (Your debug output was triggered!)
--> http://as68.homeip.net/2.6.17-rc4-mm3/kristen-dmesg.out

In order to be able to test S3 I need the NVIDIA-driver to be installed. 
For unknown reasons I cannot install it anymore.
--> http://as68.homeip.net/2.6.17-rc4-mm3/nvidia-installer.log

I've done that thousand times. Can't imagine I'm doing something wrong. 
Any ideas?

Regards,

Andreas
