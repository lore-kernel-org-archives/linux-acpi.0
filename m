From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sun, 4 Oct 2009 23:55:21 +0200
Message-ID: <ca2dc2820910041455h18ece909rc2280a40f1899c0a@mail.gmail.com>
References: <1254669853.26496.0.camel@carter>
	 <ca2dc2820910041046i47a1c3dhba82266bb14a440c@mail.gmail.com>
	 <4AC8F02B.6080209@suse.de> <200910042246.23712.rjw@sisk.pl>
	 <4AC91578.2020807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:40517 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758166AbZJDVz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2009 17:55:59 -0400
In-Reply-To: <4AC91578.2020807@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 4, 2009 at 11:36 PM, Alexey Starikovskiy
<astarikovskiy@suse.de> wrote:
> Hi Rafael,
>
> This is not my rule, it was/is the rule of power device class. If you=
 do not
> agree to it, please change
> appropriate documentation.

Oh, I did not know that. Thank you for pointing it out. I think you
are refering to:

 158Q: Suppose, my battery monitoring chip/firmware does not provides c=
apacity
 159   in percents, but provides charge_{now,full,empty}. Should I calc=
ulate
 160   percentage capacity manually, inside the driver, and register CA=
PACITY
 161   attribute? The same question about time_to_empty/time_to_full.
 162A: Most likely, no. This class is designed to export properties whi=
ch are
 163   directly measurable by the specific hardware available.
 164
 165   Inferring not available properties using some heuristics or math=
ematical
 166   model is not subject of work for a battery driver. Such function=
ality
 167   should be factored out, and in fact, apm_power, the driver to se=
rve
 168   legacy APM API on top of power supply class, uses a simple heuri=
stic of
 169   approximating remaining battery capacity based on its charge, cu=
rrent,
 170   voltage and so on. But full-fledged battery model is likely not =
subject
 171   for kernel at all, as it would require floating point calculatio=
n to deal
 172   with things like differential equations and Kalman filters. This=
 is
 173   better be handled by batteryd/libbattery, yet to be written.

We are not calculating anything new just by the pleasure of doing it,
we are correcting a wrong value provided by the hardware.

Please correct me if I misunderstood you.

>
> Regards,
> Alex.
>
> Rafael J. Wysocki =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On Sunday 04 October 2009, Alexey Starikovskiy wrote:
>>>
>>> Hi Miguel,
>>
>> Hi Alex,
>>
>>> I am going to reject your patch on the basis, that the battery driv=
er
>>> should report only
>>> information it gained from battery hardware, not interpret it in an=
y way.
>>> As your patch fall into "interpret" category, it does not belong in=
 the
>>> kernel and battery
>>> driver in particular. You may suggest it to any/all user space batt=
ery
>>> monitoring applications,
>>> this is the place for "interpretations".
>>
>> Well, we do quirks for PCI devices, suspend quirks etc. in the kerne=
l, so
>> I'm
>> not really sure we should use the "no interpretation" as a general r=
ule.
>> =C2=A0IMO,
>> if there's a known broken system needing a quirk, it may just be mor=
e
>> reasonable to put the quirk into the kernel than to put it into ever=
y
>> single
>> user application out there.
>>
>> In this particular case we have an evidently quirky hardware (or BIO=
S) and
>> it's
>> not a fundamentally wrong idea to try to address that problem in the
>> kernel.
>>
>> Thanks,
>> Rafael
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
