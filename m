From: =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@googlemail.com>
Subject: Re: [v3.4-rc] regression: reboot not working
Date: Sat, 21 Apr 2012 11:12:08 +0200
Message-ID: <CADDKRnDM_=6XfH2c-3z9umeZcLX1i=6XRRAUS9nyV8D0W3fB7Q@mail.gmail.com>
References: <CADDKRnALwHa=QteDDcMxBU24rfbKoTOGX=iTcfeE7=M7a+NFcw@mail.gmail.com>
	<CADDKRnAhqi-fwFrr85QC-ZP2g0=_ZSb__jEbZqAekCKXs2CtCg@mail.gmail.com>
	<CADDKRnDJ_u7FkOHPDr0kJ+mh4k06wv2imVh8DV=GzDUQiKEWQw@mail.gmail.com>
	<CAJyhjX0QMf7FcDfx+KDggF7avBnRFcGX6KWy6hJZ_p=ceTFh+g@mail.gmail.com>
	<CA+55aFzjxrOGejBoMNbQxN=tri08ZZVG9DM3mA-3_uU+pMumtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzjxrOGejBoMNbQxN=tri08ZZVG9DM3mA-3_uU+pMumtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergio Correia <lists@uece.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, hpa@zytor.com
List-Id: linux-acpi@vger.kernel.org

Yes, for me it works.
I'm now now up to 6be5ceb02e98eaf6cfc4f8b12a896d04023f340d VM: add
"vm_mmap()" helper function

Thanks, J=F6rg

Am 20. April 2012 20:29 schrieb Linus Torvalds <torvalds@linux-foundati=
on.org>:
> Since nothing ever happened on this, and since the original bugzilla
> entry that caused the commit indicates that there were other
> workarounds for the problem, I have reverted the offending commit in
> my tree.
>
> J=F6rg, can you please verify that current -git works for you again?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Linus
>
> On Wed, Apr 18, 2012 at 9:12 AM, Sergio Correia <lists@uece.net> wrot=
e:
>> On Wed, Apr 18, 2012 at 12:00 PM, J=F6rg Otte <jrg.otte@googlemail.c=
om> wrote:
>>> 9 days and still no response. Maybe I addressed the wrong person(s)=
=2E
>>> I Cc to Linus.
>>>
>>> Who can help with this topic?
>>>
>>
>> CC'ing linux-acpi.
>>
>>> Thanks, Joerg
>>>
>>>
>>>
>>> Am 14. April 2012 12:46 schrieb J=F6rg Otte <jrg.otte@googlemail.co=
m>:
>>>> It's now bisected:
>>>>
>>>> cf450136bfde77c7f95065c91bffded4aa7fa731 =A0 ACPI: ignore FADT res=
et-reg-sup flag
>>>>
>>>> Thanks, Joerg
>>>>
>>>>
>>>> Am 9. April 2012 17:19 schrieb J=F6rg Otte <jrg.otte@googlemail.co=
m>:
>>>>> Hi,
>>>>>
>>>>> On reboot it shuts down as normal.
>>>>> The last lines displayed are:
>>>>>
>>>>>>.
>>>>>>Unmounting temporary filesystems.. [OK]
>>>>>>Deactivating swap... =A0 =A0 =A0 =A0 =A0 =A0 =A0 [OK]
>>>>>>Unmounting local filesystems... =A0 =A0[OK]
>>>>>>Will now restart
>>>>>> =A0 =A0Restarting system
>>>>>
>>>>> Then I hear it accessing the cd-drive, but then
>>>>> it's being stuck.
>>>>>
>>>>> v3.3 was ok. HW is a Thinkpad T43.
>>>>>
>>>>> Please Cc me I'm not subscribed.
>>>>>
>>>>> Thanks,Joerg
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>> Please read the FAQ at =A0http://www.tux.org/lkml/
