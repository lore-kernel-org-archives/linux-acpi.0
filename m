From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [BISECTED 3.16-rc REGREGRESSION] backlight control stopped working
Date: Mon, 14 Jul 2014 23:46:22 +0200
Message-ID: <8761iztxzl.fsf@nemi.mork.no>
References: <87pph8kse7.fsf@nemi.mork.no> <53C3D7C3.7090505@redhat.com>
	<CA+55aFxYYKApOC+1TQkoxSzi-zTSB8OmkU=ypvNb_Gc2+K6Hmw@mail.gmail.com>
	<CA+55aFzHo4BEO8W0yza7g0YMgg-b=hPbk20-vpR3s==ydpmAOg@mail.gmail.com>
	<877g3fsm98.fsf@nemi.mork.no>
	<CA+55aFztNg4aFUnmqxoR-Hwva87D1TMOZ2Gyy8CVmEov9ToDQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:54339 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756890AbaGNVqi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 17:46:38 -0400
In-Reply-To: <CA+55aFztNg4aFUnmqxoR-Hwva87D1TMOZ2Gyy8CVmEov9ToDQg@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 14 Jul 2014 13:49:10 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jul 14, 2014 at 1:45 PM, Bj=C3=B8rn Mork <bjorn@mork.no> wrot=
e:
>>> brightness change from user mode comes in during that delay, we can=
cel
>>> the kernel-induced pending change.
>>
>> That sounds like a good solution to me FWIW.
>
> Try the patch. It *might* work. I'm not saying it will, but it seemed
> to at least compile for me.

Yes, the patch works as advertised for me.  Thanks.

But this will break existing configs:

> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -68,8 +68,8 @@ MODULE_AUTHOR("Bruno Ducrot");
>  MODULE_DESCRIPTION("ACPI Video Driver");
>  MODULE_LICENSE("GPL");
> =20
> -static bool brightness_switch_enabled;
> -module_param(brightness_switch_enabled, bool, 0644);
> +static int brightness_switch_enabled =3D -1;
> +module_param(brightness_switch_enabled, int, 0644);
> =20
>  /*
>   * By default, we don't allow duplicate ACPI video bus devices

Any setup using e.g "options video brightness_switch_enabled=3DY" will
barf on this, won't they?


Bj=C3=B8rn

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
