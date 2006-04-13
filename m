From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: RE: Failed resuming IDE from S3 on Abit NF7 (nForce2)
Date: Thu, 13 Apr 2006 21:37:38 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206BE@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35390 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964928AbWDMNh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Apr 2006 09:37:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Saur <saur@acmelabs.de>, linux-acpi@vger.kernel.org

>the bug you are refering to, seems pretty much the same bug like I do 
>have here. But I've got two questions. Could you please help me? And I 
>do asume, that this patch isn't in the resent kernel yet, isn't it?

I didn't check it, Probably Not.

>
>1) If I want to adopt your patch, I should use the values from my 
>acpidump, but I can't find anything reasonable. What should my values 
>look like? (see here: 
>http://bugzilla.kernel.org/attachment.cgi?id=7762&action=view )
>
\\_SB.PCI0.IDE0.PRI0  (It's zero)
\\_SB.PCI0.IDE0.SEC0 (It's zero)


>2) How do I ensure, that this native IDE driver is really used? Do I 
>have to uncheck all non-native IDE drivers in the kernel 
>config? (In my 
>case it's the amd71xx, I guess)
>

You can try only CONFIG_IDE_GENERIC.


>Please excuse the silly questions, but I am pretty new to game 
>of kernel 
>configuration and compilation, but steady learning :-)

happy hacking. :-)

--Luming
