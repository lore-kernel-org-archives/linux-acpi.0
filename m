From: Paolo Valente <paolo.valente@linaro.org>
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
Date: Wed, 10 Apr 2019 11:33:43 +0200
Message-ID: <E5BA70BA-D560-4C4C-BEC7-83E7D6407070@linaro.org>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk> <20190409163304.GA23829@amd>
 <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org> <20190410093044.GA3776@amd>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410093044.GA3776@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jens Axboe <axboe@kernel.dk>, kernel list <linux-kernel@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



> Il giorno 10 apr 2019, alle ore 11:30, Pavel Machek <pavel@ucw.cz> ha =
scritto:
>=20
> Hi!
>=20
>>> I now noticed it said:
>>>=20
>>> EIP is in bfq_bfqq_expire
>>>=20
>>>> Can you try and revert:
>>>>=20
>>>> 9dee8b3b057e1
>>>>=20
>>>> and see if that helps?
>>>=20
>>> Yes, I tried and yes, it helps. What are the next steps?=20
>>>=20
>>=20
>> Try my fix:
>>=20
>> =
https://lore.kernel.org/linux-block/20190409191420.3f56d493@fire.localdoma=
in/T/#m30a14045e710b870f00f7c51cdaa7c403977b767
>>=20
>> and cross your fingers :)
>=20
> It seems to work... even without fingers crossed.
>=20

Great!  I've submitted a final version of this fix patch a few minutes
ago (not yet archived anywhere, sorry).

Thanks,
Paolo

> Tested-by: Pavel Machek <pavel@ucw.cz>
> 									=
Pavel
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
