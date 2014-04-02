From: Nicolas Porcel <nicolasporcel06@gmail.com>
Subject: Re: Problem with recognizing lid state from 3.13.7 on i686
Date: Thu, 03 Apr 2014 04:42:15 +0800
Message-ID: <533C7627.5080700@gmail.com>
References: <CAN4dU3FyAO84RxttvTsmveOvxACXXf6=TP1ovEdT6dPd7KGQ8w@mail.gmail.com> <2222641.cumF3Fyysl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:35629 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbaDBUmU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2014 16:42:20 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so730221pbc.32
        for <linux-acpi@vger.kernel.org>; Wed, 02 Apr 2014 13:42:20 -0700 (PDT)
In-Reply-To: <2222641.cumF3Fyysl@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tobias Caspers <tcugma@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hello,

The problem have been fixed. You can see the explanation and the link t=
o=20
the patch on the Archlinux forum at this address:=20
https://bbs.archlinux.org/viewtopic.php?pid=3D1399911#p1399911

Here is the thread on the linux-acpi mailing:=20
http://marc.info/?l=3Dlinux-acpi&m=3D139564741817605&w=3D2

Best regards,

Nicolas Porcel

Le 03/04/2014 03:23, Rafael J. Wysocki a =C3=A9crit :
> On Wednesday, April 02, 2014 05:50:34 PM Tobias Caspers wrote:
>> --001a11c1d718bd39e404f6113eef
>> Content-Type: text/plain; charset=3DISO-8859-1
>>
>> Dear kernel developer,
>>
>> there seems to be a problem with recognizing lid state on some i686
>> hardware from kernel 3.13.7 on.
>> For me with a Samsung N150 and arch linux it is as follows:
>>
>> Monitoring lid by systemd: after first lid close, a endless chain of
>> suspends follows
>> Monitoring lid by XFCE: toggling suspend by lid close works sometime=
s.
>>
>> For some more details see https://bbs.archlinux.org/viewtopic.php?id=
=3D179216
> Care to file a bug report for this problem at bugzilla.kernel.org aga=
inst ACPI?
>
> Rafael
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
