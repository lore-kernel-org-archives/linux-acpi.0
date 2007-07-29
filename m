From: Adrian Bunk <bunk@stusta.de>
Subject: acpi_battery_add(): use-after-free
Date: Sun, 29 Jul 2007 17:00:46 +0200
Message-ID: <20070729150046.GM16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47888 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763954AbXG2PBK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Jul 2007 11:01:10 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The Coverity checker spotted the following use-after-free in 
acpi_battery_add():

<--  snip  -->

...
static int acpi_battery_add(struct acpi_device *device)
{
...
        if (result) {
                acpi_battery_remove_fs(device);
                kfree(battery);
        }

        mutex_unlock(&battery->mutex);
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

