From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Bug 197863] Thinkpad X240 resume dramatically slower on kernels 4.13+
Date: Wed, 7 Feb 2018 23:44:15 +0100
Message-ID: <CAJZ5v0jN2cQUmwWRQ=Rvb+dQpMg+Q+GuaDtt-X-tXWNThUx-NQ@mail.gmail.com>
References: <bug-197863-190391@https.bugzilla.kernel.org/> <bug-197863-190391-0fyd51NsnV@https.bugzilla.kernel.org/>
 <20180129182109.neh34gh7uaxymcb5@victor> <20180130063204.GA8652@kroah.com>
 <20180203182554.rpjvmjbptuqemul2@victor> <20180204061804.GB31023@kroah.com>
 <874lmw33fe.fsf@miraculix.mork.no> <fe58e542-81c6-9c44-8930-7d91120e80cb@intel.com>
 <87vafbzfoj.fsf@miraculix.mork.no> <a662d85c-e226-223e-3467-90b651dd291b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:41833 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeBGWoQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2018 17:44:16 -0500
In-Reply-To: <a662d85c-e226-223e-3467-90b651dd291b@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Greg KH <gregkh@linuxfoundation.org>, Markus Demleitner <m@tfiu.de>, Lv Zheng <lv.zheng@intel.com>, Andreas Lindhe <andreas@lindhe.io>, Gjorgji Jankovski <j.gjorgji@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>, Fernando Chaves <nanochaves@gmail.com>, Tomislav Ivek <tomislav.ivek@gmail.com>, "Denis P." <theoriginal.skullburner@gmail.com>, All applicable <stable@vger.kernel.org>, "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" <linux-usb@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Feb 5, 2018 at 6:06 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 2/5/2018 3:14 PM, Bj=C3=B8rn Mork wrote:
>>
>> "Rafael J. Wysocki" <rafael.j.wysocki@intel.com> writes:
>>>
>>> On 2/4/2018 9:28 PM, Bj=C3=B8rn Mork wrote:
>>>
>>>> But I do wonder if the attached (completely untested!!) patch makes
>>>> things any better?
>>>
>>> I don't think so, the macro is needed too.
>>
>> Doh! Obviously.  Don't know how I managed to miss that.
>>
>>> I'll queue up a full revert of 662591461c4b9a1e3b.
>>
>> Still with the additional exception for "ec =3D=3D first_ec"?
>>
>
> No, just a full revert for now.

That doesn't work, because we made some changes on top of this commit.

I'll send a patch to try tomorrow.

Thanks,
Rafael
