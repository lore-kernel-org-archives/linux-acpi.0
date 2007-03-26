From: fred <fredmfp@gmail.com>
Subject: Re: ACPI/sound issue with my Toshiba laptop (P100-473)...
Date: Mon, 26 Mar 2007 10:16:46 +0200
Message-ID: <4607816E.5070005@gmail.com>
References: <4606BF08.5070706@gmail.com> <46070F06.4070309@gmail.com> <200703252354.36510.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:21961 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933660AbXCZIQu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Mar 2007 04:16:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1525148uga
        for <linux-acpi@vger.kernel.org>; Mon, 26 Mar 2007 01:16:49 -0700 (PDT)
In-Reply-To: <200703252354.36510.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Len Brown a =E9crit :
> Thanks for the pointer - no, your post is not noise.
>
> Was changing "PNP0C14" to "PNP0C14" in the DSDT sufficient to fix the=
 issue?
>  =20
(I think you mean "*PNP0C14" by "PNP0C14").
Not really.
I only followed the gentoo's advices:

- replace all occurences of _T_[0-7] by something else because iasl doe=
s=20
not like them;
- complete the return path for method BTST with Return (Zero)
- replace "*PNP0C14" by "PNP0C14"
- comment a few lines in Scope (\_SB) and added to the end
   Store (0x07D6, OSYS)
which is commented as "Fake Windows 2006" in the gentoo's page.

But I can test it with only modifying PNPC014 (and _T_[0-7] of course)
if you want...
> It may be that we have a simple "Microsoft Bug Compatibility" issue h=
ere.
>
> Linux's goal should be for machines that run Windows to also run Linu=
x,
> without the need for users to hack their DSDT...
>  =20
I full agree ;-)
>> By the way, as the toshiba p100-473 is not present in your repositor=
y,
>> should I post mine ?
>>    =20
>
> Can't hurt, but getting Linux to work properly w/o needing a DSDT
> hack is much more important.
>
>  =20
But is it not the aim of the repo ?
> So it may be even more useful to open a bug report here:
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> (sub-category BIOS)
> and attach the complete output from acpidump, along with the minimum
> change you needed to make to your DSDT to get sound to work.
Ok, thanks for the advice.

By the way, I just realized that I have nothing in /proc/acpi/fan
whereas I have set it in my conf kernel file:

 CONFIG_ACPI_FAN=3Dy

and I think its behavior is quite strange (on/off, on/off etc...)

It seems that something is wrong, no ?

Cheers,

--=20
http://scipy.org/FredericPetit

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
