From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: asus_atk0110 not working on Asus P7P55D PRO
Date: Mon, 21 Sep 2009 18:52:00 -0600
Message-ID: <51f3faa70909211752i29ab88b4kbf33278e171e3fd5@mail.gmail.com>
References: <4AB1C907.1070503@gmail.com>
	 <20090920162306.GA18214@dreamland.darkstar.lan>
	 <51f3faa70909201047x56313d99q7cdc49bcc4634b01@mail.gmail.com>
	 <20090920185824.GA23206@dreamland.darkstar.lan>
	 <51f3faa70909201551k70ace90x2b25351bfc04c555@mail.gmail.com>
	 <20090921190434.GA10101@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f213.google.com ([209.85.219.213]:62166 "EHLO
	mail-ew0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbZIVBSo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 21:18:44 -0400
In-Reply-To: <20090921190434.GA10101@dreamland.darkstar.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Sep 21, 2009 at 1:04 PM, Luca Tettamanti <kronos.it@gmail.com> =
wrote:
> Il Sun, Sep 20, 2009 at 04:51:10PM -0600, Robert Hancock ha scritto:
>> On Sun, Sep 20, 2009 at 12:58 PM, Luca Tettamanti <kronos.it@gmail.c=
om> wrote:
>> >> >> I'm guessing this board uses a different format than what the =
driver
>> >> >> is expecting. I'm attaching the gzipped decompiled DSDT from t=
he
>> >> >> board, hopefully it's useful to somebody..
>> >> >
>> >> > Please try the following patch, it should detect the proper buf=
fer size.
>> >> >
>> >>
>> >> Obviously something not quite right:
>> >
>> > Ah yes, the pointer for the output buffer was pointing to the wron=
g
>> > variable. Sorry for that ;)
>>
>> Cool, seems to be working.
>
> Excellent :)
>
>> Though the high and critical temperatures
>> seem a bit odd, but maybe that's what the BIOS actually reports:
> [...]
>> CPU Temperature: =A0 =A0+32.5=B0C =A0(high =3D +45.0=B0C, crit =3D +=
45.5=B0C)
>> MB Temperature: =A0 =A0 +31.0=B0C =A0(high =3D +45.0=B0C, crit =3D +=
46.0=B0C)
>
> The limits are declared in the DSDT, the driver doesn't do any
> calculation.
> It's possible that Asus changed the encoding (again); so far I've bee=
n
> unable to locate a "version" field that would allow the driver to det=
ect
> a change in the data structures.
>
> I've got a new patch for you: instead of probing and preallocating th=
e
> buffer this version lets ACPI code do the allocation; the return valu=
e
> is cached anyway, so there won't be a big number of allocations.
> Can you please test and see if it works?

Yes, this version still works..
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
