From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] eeepc-laptop - switch to using sparse keymap library
Date: Sun, 3 Jan 2010 16:03:38 +0100
Message-ID: <71cd59b01001030703v1b0dfd4ey6469fc8156128f1d@mail.gmail.com>
References: <20091218062454.GE21231@core.coreip.homeip.net>
	 <9b2b86520912200425p48bd83fy40d7070d07d3e3b2@mail.gmail.com>
	 <20091221052839.GA324@core.coreip.homeip.net>
	 <9b2b86520912210203g4bcd08edkc40f4233b8b9744f@mail.gmail.com>
	 <71cd59b00912210300t684ce249g67a8fb4e05caee91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:48256 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0ACPDj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jan 2010 10:03:39 -0500
Received: by fxm25 with SMTP id 25so8106497fxm.21
        for <linux-acpi@vger.kernel.org>; Sun, 03 Jan 2010 07:03:38 -0800 (PST)
In-Reply-To: <71cd59b00912210300t684ce249g67a8fb4e05caee91@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Dec 21, 2009 at 12:00 PM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Mon, Dec 21, 2009 at 11:03 AM, Alan Jenkins
> <sourcejedi.lkml@googlemail.com> wrote:
>> On 12/21/09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>> On Sun, Dec 20, 2009 at 12:25:11PM +0000, Alan Jenkins wrote:
>>
>>>> Thanks! =A0Everything seems to work except for the "brightness up"=
 key :-).
>>>>
>>>
>>> Hmm, indeed, not sure what exactly I was thinking... How about this=
 one?
>>>
>>> --
>>> Dmitry
>>>
>>>
>>> Input: eeepc-laptop - switch to using sparse keymap library
>>>
>>> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>>> ---
>>>
>>> =A0drivers/platform/x86/Kconfig =A0 =A0 =A0 =A0| =A0 =A01
>>> =A0drivers/platform/x86/eeepc-laptop.c | =A0186
>>> ++++++++++-------------------------
>>> =A02 files changed, 52 insertions(+), 135 deletions(-)
>>
>>
>> Yes, that fixes it.
>>
>>
>> Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>>
>>
>> Thanks
>> Alan
>>
>
> Acked-by: Corentin Chary <corentincj@iksaif.net>
>
> --
> Corentin Chary
> http://xf.iksaif.net
>


Merged into acpi4asus, will be sent to Len soon (before the end of the
week) for inclusion in 2.6.23-rc3 (or 4)

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
