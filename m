From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 00/24] acpi4asus update
Date: Sat, 29 Aug 2009 10:27:22 +0200
Message-ID: <71cd59b00908290127l2c60129bp183fe5fb6a99de0b@mail.gmail.com>
References: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
	 <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45595 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbZH2I1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 04:27:20 -0400
Received: by fxm17 with SMTP id 17so1936192fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 29 Aug 2009 01:27:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908281524080.27023@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk

On Fri, Aug 28, 2009 at 9:33 PM, Len Brown<lenb@kernel.org> wrote:
> Thanks for the series Corentin,
> it applied and built cleanly.
>
> Please go to
>
> http://patchwork.kernel.org/project/linux-acpi/list/?order=3Dsubmitte=
r
> and mark the patches from Alan that you forwarded in state "Supercede=
d"
> so that I don't end up trying to apply them again when I get
> to sifting through the many patches from Alan.

Done for those present in my tree.

Two patchs were not in my tree:
http://patchwork.kernel.org/patch/42553/
http://patchwork.kernel.org/patch/42554/

I refreshed the first patch (a conflict due to "eeepc-laptop: add
rfkill support for the Wimax in ASUS Eee PC 1000HG"), and merged the
second. I'll send them in reply to this mail and mark them Superceded.

> I fixed a couple of whitespace warnings like this:
> WARNING: suspect code indent for conditional statements (8, 17)
> #459: FILE: drivers/platform/x86/eeepc-laptop.c:1150:
> + =A0 =A0 =A0 if (!device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> please run checkpatch.pl on your patches before submitting
> them so that we don't trip on trivial stuff like this.

I usually do that, not this time, sorry :/

> This one is considered an actual error by the checkpatch maintainers:
>
> ERROR: do not use C99 // comments
> #1466: FILE: drivers/platform/x86/asus-laptop.c:89:
> +#define KEY_ON =A0 =A0 =A00x200 =A0 =A0 =A0 //Keyboard backlight
>
> I left it alone since it was consistent with the existing code.
> Please send a single patch to convert all of these at once.

Done,

Thanks,

--=20
Corentin Chary
http://xf.iksaif.net - http://uffs.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
