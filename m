From: Corey Minyard <minyard@acm.org>
Subject: Extra ACPI objects from an acpi PNP device?
Date: Wed, 10 May 2006 14:14:40 -0500
Message-ID: <44623BA0.9030107@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:8320 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750746AbWEJTOl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 May 2006 15:14:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, ambx1@neo.rr.com
Cc: Matt Domsch <Matt_Domsch@dell.com>

I have a situation where I need to get an ACPI device.  The PNP system
seems like the way to go for this, but I need some extra objects from
the ACPI namespace for this device (_IFT and _SRV to be specific,
supposidly added in ACPI 3.0).  There doesn't seem to be a clean way to
do this right now.  What would be the best way to get these?

Thanks,

-Corey
