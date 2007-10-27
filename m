From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] 2.6.24-rc1: ensure "present" sysfs attribute even if
 battery is absent
Date: Sat, 27 Oct 2007 21:16:05 +0400
Message-ID: <47237255.9020001@gmail.com>
References: <200710272054.31160.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:31677 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbXJ0RQi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 13:16:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so817433ugc
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 10:16:36 -0700 (PDT)
In-Reply-To: <200710272054.31160.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, cbou@mail.ru, dwmw2@infradead.org

Andrey Borzenkov wrote:
> I am not exactly sure about this one ... what other power_supply class drivers 
> do? Should I fix HAL instead (but then, I do not know whether HAL is the only 
> application that is using this interface).
> 
> 
Hm, do you need separate set of properties for that? You could register either 
of existing two, and read function will not allow read of anything but "present".
IMHO, this is what other modules do (/drivers/power)
One remaining trick here, you need to call unregister/register for power_supply 
if you change attributes -- so please check if your patched driver survives 
insertion of the battery.

Regards,
Alex.
