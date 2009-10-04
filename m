From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Mon, 5 Oct 2009 01:58:10 +0200
Message-ID: <ca2dc2820910041658w18a5b37drcb4328f35f135e7a@mail.gmail.com>
References: <1254669853.26496.0.camel@carter> <200910042246.23712.rjw@sisk.pl>
	 <4AC91578.2020807@suse.de> <200910050043.56667.rjw@sisk.pl>
	 <4AC92837.80708@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:58345 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbZJDX6s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 19:58:48 -0400
In-Reply-To: <4AC92837.80708@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 5, 2009 at 12:56 AM, Alexey Starikovskiy
<astarikovskiy@suse.de> wrote:
> Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On Sunday 04 October 2009, Alexey Starikovskiy wrote:
>>>
>>> Hi Rafael,
>>
>> Alex,
>>
>>> This is not my rule, it was/is the rule of power device class. If y=
ou do
>>> not agree to it, please change
>>> appropriate documentation.
>>
>> I think we're talking about two different things. =C2=A0One thing is=
 that we
>> shouldn't put any _arbitrary_ interpretation rules into the kernel, =
which
>> I
>> agree with. =C2=A0The other one is that if there's a _known_ _broken=
_ hardware
>> and one possible way of handling it is to add a quirk into the kerne=
l, we
>> should at least consider doing that.
>>
>> In my opinion adding a quirk for a broken hardware is not equivalent=
 to
>> "inferring not available properties using some heuristics or mathema=
tical
>> model", if that's what you're referring to.
>
> No, this is not a clear "bug" and not a clear "fix". Please read my r=
eply to
> Miguel.
>
>>
>> That said, the patch should not change the _default_ code in order t=
o
>> handle
>> the quirky hardware correctly. =C2=A0IMO, the quirky hardware should=
 be
>> recognized
>
> It will change behaviour of at least Samsung notebooks, for which I
> personally saw the charge_now/full_charge being greater then design_c=
harge.
>>
>> during initialisation, if possible, and later handled in a special w=
ay.
>> =C2=A0If
>> it's not possible to detect the broken hardware reliably, I agree th=
at
>> there's
>> nothing we can do about that in the kernel.
>
> I am still not sure if we have a broken hardware here.

I have no idea about batteries, but jumping from 5950 mAh to 7650 mAh
within one second does not seem non-broken to me. ;)

>
> Regards,
> Alex.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
