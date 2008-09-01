From: Zhao Yakui <yakui.zhao@intel.com>
Subject: a problem about the two patches in bug 10724 & 11428
Date: Mon, 01 Sep 2008 14:40:21 +0800
Message-ID: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8801 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087AbYIAG0e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Sep 2008 02:26:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: astarikovskiy@suse.de
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Hi, Alexey
    You have a lot of experiences about EC driver and a lot of EC patches are from you.
    You attach two patches related with EC driver in the bug 10724 & 11428.
    In the bug 10724:
        Add a boot ption of "ec_intr= " to select the EC work mode( Interrupt/Polling mode)
        After this patch is applied, EC won't switch to polling mode automatically from interrupt mode when EC irq storm is detected.
    In the bug 11428
        In this patch the EC won't switch off GPE mode on missing interrupts

    Will the above two patches hit the upstream kernel? If the above two patches hits the upstream kernel, it 
seems that the boot option of "ec_intr=" comes back again and EC can't be switched from interrupt mode to polling 
mode if EC GPE interrupt is missing. In such case maybe the battery/AC/thermal driver can't work well if the info of
battery/AC/thermal is related with EC. Maybe there exists the regression on some laptops.
    At the same time the boot option of "ec_intr=1" indicates that EC will work in EC GPE interrupt mode. But maybe the following
phenomenon will appear on some laptops:
   EC is initialized as polling mode. After the EC GPE interrupt is triggered, it will be switched to GPE interrupt mode. But if
no EC GPE interrupt is triggered, it will still work in polling mode. Although it is harmless and EC can also work well, 
maybe the EC working mode is inconsistent with the EC boot option. At the same time after the system is resumed from S3, the EC working
mode will also be polling mode in the function of acpi_ec_resume.

    IMO the EC working mode is not very reasonable if the above two patches hit the upstream kernel.
    Are the following two methods reasonable? Which of them is better?

    a. Add the boot option of "ec_intr=" (ec_intr=auto, intr, polling). For most laptops the boot option of "ec_intr=auto" is the default option
and "ec_intr=auto" means that the EC working mode can be switched automatically between interrupt mode and polling mode.The purpose of "ec_intr=auto"
is used to avoid the regression on some laptops.(Maybe some laptops can't work well if the EC mode switch is disabled.) 
     If the boot option of "ec_intr=intr" is added, the EC will be forced to work in interrupt mode and can't be switched to polling mode even 
when the EC confirmation GPE interrupt is missing. 
     If the boot option of "ec_intr=polling" is added, the EC will be forced to work in polling mode.
     
     In such case the EC working mode is related with user input. 

    b. EC mode switch is disabled on some specific laptops. In such case the user doesn't care for the EC working mode. At the same time
EC is still started in polling mode. It will be switched to interrupt mode if the EC GPE interrupt is triggered. EC will be switched to polling
mode on most laptops in case of missing confirmation GPE interrupt. But on some specific laptops the EC mode switch is disabled, which means
that EC will still work in interrupt mode even when the EC confirmation GPE interrupt is missing. This can be realized by adding EC DMI check table.

    I am not sure whether my above suggestion is appropriate. 

Thanks for the comments.

Best regards.
   Yakui

