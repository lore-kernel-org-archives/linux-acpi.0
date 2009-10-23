From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [Resend] [PATCH] ACPI: New driver for Lenovo SL laptops
Date: Sat, 24 Oct 2009 00:57:09 +0400
Message-ID: <4AE218A5.5070008@gmail.com>
References: <1253805163-12493-1-git-send-email-ike.pan@canonical.com> <1256325108-22626-1-git-send-email-ike.pan@canonical.com> <4AE20560.5020908@gmail.com> <4AE20AA2.2090201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:48663 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZJWU5G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Oct 2009 16:57:06 -0400
In-Reply-To: <4AE20AA2.2090201@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Rostovtsev <tetromino@gmail.com>, Corentin CHARY <corentincj@iksaif.net>

Hi Ike,

I'm sorry to say this, bit it looks like your design is seriously=20
flowed. Not any ACPI device should
require interception of EC query events.

You should register device for HID "ATK0101" and get all notifications=20
there, as it is done for
for ASUS ATK0100 hot key driver (drivers/platform/x86/asus-laptop.c),=20
and I would guess,
that driver for ASUS ATK0101 hot key driver may be either an extension=20
to ATK0100 driver
or based on it, if new device does not share any events.
This would be real solution, and not a hack for a single notebook/BIOS=20
version.
 From the DSDT it is obvious that _Q numbers are not permanent and coul=
d=20
change even
with the next BIOS revision.

You may also contact current maintainer of asus-laptop driver, Corentin=
=20
Chary, as he might help you with design.

Regards,
Alex.

Ike Panhc =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi Alex,
>
> The attachment is the acpidump.
>
> I register for EC query events because it is an event source of hotke=
y
> press
>
> Alexey Starikovskiy wrote:
>  =20
>> Hi,
>>
>> Could you please post acpidump from this machine, I would like to
>> understand,
>> why you need to register for EC query events.
>>
>> Thanks,
>> Alex.
>>
>>    =20
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
