From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: ATK0110 GITM[0x6020011] ACPI exception: AE_BAD_PARAMETER errors
Date: Sun, 9 Jul 2017 14:05:12 +0930
Message-ID: <c3774583-930e-a683-bf2f-0684689e12a4@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:23481 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750836AbdGIEke (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2017 00:40:34 -0400
Content-Language: en-AU
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kronos.it@gmail.com
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On post 4.12.0 kernels on an ASUS M3A7A Pro motherboard, I've been 
getting messages about the asus_atk0110 module:

am64:/usr/src/linux# dmesg|grep -i atk
[   12.517304] ATK0110 ATK0110:00: hwmon_device_register() is 
deprecated. Please convert the driver to use 
hwmon_device_register_with_info().
[   54.749748] ATK0110 ATK0110:00: GITM[0x6020011] ACPI exception: 
AE_BAD_PARAMETER
[   54.752680] ATK0110 ATK0110:00: GITM[0x6020061] ACPI exception: 
AE_BAD_PARAMETER
[   54.755502] ATK0110 ATK0110:00: GITM[0x6020062] ACPI exception: 
AE_BAD_PARAMETER
[   54.758310] ATK0110 ATK0110:00: GITM[0x6020063] ACPI exception: 
AE_BAD_PARAMETER
[   54.758390] ATK0110 ATK0110:00: GITM[0x6040013] ACPI exception: 
AE_BAD_PARAMETER
[   54.758466] ATK0110 ATK0110:00: GITM[0x6040073] ACPI exception: 
AE_BAD_PARAMETER
[   54.758527] ATK0110 ATK0110:00: GITM[0x60400c3] ACPI exception: 
AE_BAD_PARAMETER
[   54.758579] ATK0110 ATK0110:00: GITM[0x6030012] ACPI exception: 
AE_BAD_PARAMETER
[   54.758631] ATK0110 ATK0110:00: GITM[0x6030074] ACPI exception: 
AE_BAD_PARAMETER

This might be related to hard CPU lock-ups that I see later on, so for 
now I've unloaded the asus_atk0110 module to see if that prevents later 
lock-ups.

I can supply more configuration/log information and run tests if anyone 
want them.

Arthur.
