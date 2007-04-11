From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 21:23:17 +0200
Message-ID: <461D35A5.3010005@gmail.com>
References: <22473653910004885@karneval.cz> <461CE6AA.6050806@gmail.com> <200704112018.31026.dkukawka@suse.de> <200704112032.11772.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:6599 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965194AbXDKTXT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Apr 2007 15:23:19 -0400
Received: by mu-out-0910.google.com with SMTP id g7so343286muf
        for <linux-acpi@vger.kernel.org>; Wed, 11 Apr 2007 12:23:17 -0700 (PDT)
In-Reply-To: <200704112032.11772.dkukawka@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Danny Kukawka <dkukawka@suse.de>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, corentincj@iksaif.net, sziwan@users.sourceforge.net

Danny Kukawka napsal(a):
> On Mittwoch, 11. April 2007, Danny Kukawka wrote:
>> Jiri Slaby wrote:
>>> Corentin CHARY napsal(a):
>>>> Le Wednesday 11 April 2007 11:33:48 Jiri Slaby, vous avez =C3=A9cr=
it :
>>>>> asus_acpi, support F2JE model
>>>> Just use the new asus-laptop driver =3D)
>>>> (see acpi4asus-0.40)
>>> code seems good, but this is not so good:
>>> #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,20)
>>> #warning "This module does not support 2.6.20 yet, wait for a new r=
elease
>>> #=3D)" endif
>>>
>>> When do you plan to support latest kernels and merge it to mainline=
?
>> This patch fixes acpi4asus-0.40 for me at least with 2.6.20 on a ASU=
S R1F.
>=20
> Btw. looks as if a new version of the driver (v0.41) is already in th=
e mm-tree.

Good to hear, I've got a look only to .21-rc6-mm1, where are no changes=
 like
this (there is 0.30).

I'm satisfied, thanks,
--=20
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
