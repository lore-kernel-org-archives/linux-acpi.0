From: Sergio Correia <lists@uece.net>
Subject: Re: [v3.4-rc] regression: reboot not working
Date: Wed, 18 Apr 2012 12:12:33 -0400
Message-ID: <CAJyhjX0QMf7FcDfx+KDggF7avBnRFcGX6KWy6hJZ_p=ceTFh+g@mail.gmail.com>
References: <CADDKRnALwHa=QteDDcMxBU24rfbKoTOGX=iTcfeE7=M7a+NFcw@mail.gmail.com>
 <CADDKRnAhqi-fwFrr85QC-ZP2g0=_ZSb__jEbZqAekCKXs2CtCg@mail.gmail.com> <CADDKRnDJ_u7FkOHPDr0kJ+mh4k06wv2imVh8DV=GzDUQiKEWQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42815 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2DRQMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Apr 2012 12:12:55 -0400
Received: by vcqp1 with SMTP id p1so4987219vcq.19
        for <linux-acpi@vger.kernel.org>; Wed, 18 Apr 2012 09:12:54 -0700 (PDT)
In-Reply-To: <CADDKRnDJ_u7FkOHPDr0kJ+mh4k06wv2imVh8DV=GzDUQiKEWQw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@googlemail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, hpa@zytor.com, torvalds@linux-foundation.org

On Wed, Apr 18, 2012 at 12:00 PM, J=F6rg Otte <jrg.otte@googlemail.com>=
 wrote:
> 9 days and still no response. Maybe I addressed the wrong person(s).
> I Cc to Linus.
>
> Who can help with this topic?
>

CC'ing linux-acpi.

> Thanks, Joerg
>
>
>
> Am 14. April 2012 12:46 schrieb J=F6rg Otte <jrg.otte@googlemail.com>=
:
>> It's now bisected:
>>
>> cf450136bfde77c7f95065c91bffded4aa7fa731 =A0 ACPI: ignore FADT reset=
-reg-sup flag
>>
>> Thanks, Joerg
>>
>>
>> Am 9. April 2012 17:19 schrieb J=F6rg Otte <jrg.otte@googlemail.com>=
:
>>> Hi,
>>>
>>> On reboot it shuts down as normal.
>>> The last lines displayed are:
>>>
>>>>.
>>>>Unmounting temporary filesystems.. [OK]
>>>>Deactivating swap... =A0 =A0 =A0 =A0 =A0 =A0 =A0 [OK]
>>>>Unmounting local filesystems... =A0 =A0[OK]
>>>>Will now restart
>>>> =A0 =A0Restarting system
>>>
>>> Then I hear it accessing the cd-drive, but then
>>> it's being stuck.
>>>
>>> v3.3 was ok. HW is a Thinkpad T43.
>>>
>>> Please Cc me I'm not subscribed.
>>>
>>> Thanks,Joerg
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
