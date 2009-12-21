From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop - switch to using sparse keymap library
Date: Mon, 21 Dec 2009 12:00:27 +0100
Message-ID: <71cd59b00912210300t684ce249g67a8fb4e05caee91@mail.gmail.com>
References: <20091218062454.GE21231@core.coreip.homeip.net>
	 <9b2b86520912200425p48bd83fy40d7070d07d3e3b2@mail.gmail.com>
	 <20091221052839.GA324@core.coreip.homeip.net>
	 <9b2b86520912210203g4bcd08edkc40f4233b8b9744f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46081 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbZLULA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 06:00:28 -0500
Received: by yxe17 with SMTP id 17so4724380yxe.33
        for <linux-acpi@vger.kernel.org>; Mon, 21 Dec 2009 03:00:27 -0800 (PST)
In-Reply-To: <9b2b86520912210203g4bcd08edkc40f4233b8b9744f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Dec 21, 2009 at 11:03 AM, Alan Jenkins
<sourcejedi.lkml@googlemail.com> wrote:
> On 12/21/09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> On Sun, Dec 20, 2009 at 12:25:11PM +0000, Alan Jenkins wrote:
>
>>> Thanks! =A0Everything seems to work except for the "brightness up" =
key :-).
>>>
>>
>> Hmm, indeed, not sure what exactly I was thinking... How about this =
one?
>>
>> --
>> Dmitry
>>
>>
>> Input: eeepc-laptop - switch to using sparse keymap library
>>
>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> ---
>>
>> =A0drivers/platform/x86/Kconfig =A0 =A0 =A0 =A0| =A0 =A01
>> =A0drivers/platform/x86/eeepc-laptop.c | =A0186
>> ++++++++++-------------------------
>> =A02 files changed, 52 insertions(+), 135 deletions(-)
>
>
> Yes, that fixes it.
>
>
> Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>
>
> Thanks
> Alan
>

Acked-by: Corentin Chary <corentincj@iksaif.net>

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
