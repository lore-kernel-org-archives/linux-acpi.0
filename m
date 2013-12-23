From: Alex Barattini <alex.barattini@gmail.com>
Subject: Re:
Date: Mon, 23 Dec 2013 17:24:40 +0100
Message-ID: <CANsOggaAS4xqCQyobt_ZSWf-HRb4PnbW_R9Oz-0-kLVbazFpJQ@mail.gmail.com>
References: <CANsOggaW_Fve_AAt3=Zae62bcZeOeHiQpPrmg3B3YTV0H0gY_A@mail.gmail.com>
	<52B79590.5030405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:58161 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625Ab3LWQYm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Dec 2013 11:24:42 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so5736179oah.8
        for <linux-acpi@vger.kernel.org>; Mon, 23 Dec 2013 08:24:41 -0800 (PST)
In-Reply-To: <52B79590.5030405@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

At the moment, set acpi_backlight=vendor on GRUB as a workaround,
works only with kernel version 3.11.0-14-generic (Ubuntu stable
kernel).
Set the workaround in the Kernel v3.13-rc5 produce blackscreen at startup.
You can see the update and the evolution of the bug here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1261853

2013/12/23 Aaron Lu <aaron.lu@intel.com>:
> On 12/22/2013 12:48 AM, Alex Barattini wrote:
>> [1.] One line summary of the problem:
>>
>> 8086:0166 [Dell Inspiron 15R 5521] Impossible to adjust the screen backlight
>>
>> [2.] Full description of the problem/report:
>>
>> The change in the level of illumination of the screen, through the
>> corresponding option in the control panel, has no effect.
>
> Does this patch help?
> http://www.spinics.net/lists/linux-acpi/msg47755.html
>
