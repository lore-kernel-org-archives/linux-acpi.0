From: Berthold Cogel <cogel@rrz.uni-koeln.de>
Subject: ACPI: SBS in linux-2.6.18-rc1 - Works for me!
Date: Thu, 13 Jul 2006 09:57:32 +0200
Message-ID: <44B5FCEC.8040903@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:64469 "EHLO
	smtp-out.rrz.uni-koeln.de") by vger.kernel.org with ESMTP
	id S964848AbWGMH6C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jul 2006 03:58:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

I've tested linux-2.6.18-rc1 with Smart Battery System enabled. It works 
for my Acer Extensa 3002 WLMi. No compile errors or bugs at first sight.

Perhaps there should be some logic in the configuration to disable the 
ac and battery modules. They are not needed if SBS is active.

Is it possible to load sbs and i2c-ec automatically together with the 
other ACPI modules? On my Debian system I had to load the modules via 
/etc/modules.conf.


Regards,
Berthold
