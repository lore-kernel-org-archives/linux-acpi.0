From: Adam Goode <agoode@google.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 13:11:02 -0400
Message-ID: <CAOf41Nm50Y6dz5KA=KJaoQHqMxGHxzH2KCER91GA-AaAg=fAPQ@mail.gmail.com>
References: <CAOf41Nnj3pmqDmc4xx9bwzhEpFsoxq5P2caNtsVBX31js9Ehgg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAA86@ORSMSX112.amr.corp.intel.com>
 <CAOf41NnO0RQVEmiX5KeMCMDtONxBfPO9BYZpAOBSNexWd1w_Fg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAAE9@ORSMSX112.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880271AE0F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802720637@SHSMSX101.ccr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE073@ORSMSX112.amr.corp.intel.com>
 <CAOf41N=Ps3jgrxA7kU-Tu-tca1CsqZ_Wac3GFRGCu5U3ZN9p1g@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0C7@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vn0-f54.google.com ([209.85.216.54]:41267 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbbETRLX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 13:11:23 -0400
Received: by vnbg62 with SMTP id g62so4080469vnb.8
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2015 10:11:22 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0C7@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Box, David E" <david.e.box@intel.com>

Yes, it really looks like a bug in the firmware. Still, Windows works
correctly without any special support.

What is the policy for ACPICA in this case where Windows works in a
spec-violating way?


Adam


On Wed, May 20, 2015 at 1:07 PM, Moore, Robert <robert.moore@intel.com>=
 wrote:
> Then perhaps this is where the machine is violating the ACPI specific=
ation:
>
>
> 6.5.1 _INI (Init)
>
> The _INI method must only access Operation Regions that have been ind=
icated to be available as defined by the _REG method.
>
>
>
>
>> -----Original Message-----
>> From: Adam Goode [mailto:agoode@google.com]
>> Sent: Wednesday, May 20, 2015 9:56 AM
>> To: Moore, Robert
>> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi@vger.kernel.org; devel@acpica=
=2Eorg
>> Subject: Re: [Devel] Correct place to send patches?
>>
>> No, I did not see a _REG method defined in the code.
>>
>>
>> Adam
>>
>>
>> On Wed, May 20, 2015 at 12:46 PM, Moore, Robert <robert.moore@intel.=
com>
>> wrote:
>> > Does the CMOS operation region have a _REG method?
>> >
>> >
>> >
>> >
>> >
>> > From: Zheng, Lv
>> > Sent: Tuesday, May 19, 2015 11:03 PM
>> > To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
>> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> >
>> >
>> > Subject: RE: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > Since no reply from Tianyu=E2=80=A6
>> >
>> > What if we move _INI invocation out of ACPICA, and let OSPM to inv=
oke
>> it.
>> >
>> >
>> >
>> > Thanks
>> >
>> > -Lv
>> >
>> >
>> >
>> > From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, =
Lv
>> > Sent: Thursday, May 14, 2015 8:33 AM
>> > To: Moore, Robert; Adam Goode; Lan, Tianyu
>> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> > Subject: Re: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > You should discuss this in the linux-acpi mailing list where the L=
inux
>> > CMOS opregion driver is implemented, reviewed, and merged.
>> >
>> > Let me Cc Tianyu who is the original author of the CMOS opregion d=
river.
>> >
>> >
>> >
>> > Thanks
>> >
>> > -Lv
>> >
>> >
>> >
>> > From: Moore, Robert
>> > Sent: Wednesday, May 13, 2015 10:25 PM
>> > To: Adam Goode; Zheng, Lv
>> > Cc: devel@acpica.org
>> > Subject: RE: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > I=E2=80=99ll have to let Lv answer this question.
>> >
>> >
>> >
>> >
>> >
>> > From: Adam Goode [mailto:agoode@google.com]
>> > Sent: Wednesday, May 13, 2015 7:23 AM
>> > To: Moore, Robert
>> > Cc: devel@acpica.org
>> > Subject: Re: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > The problem is that on new Apple hardware (Macmini7,1 and others),=
 the
>> > system reads and writes from CMOS in _INI. With no CMOS handler, t=
he
>> > Thunderbolt device doesn't initialize correctly.
>> >
>> >
>> >
>> > The current framework in Linux doesn't register the PNP* CMOS devi=
ces
>> > until after _INI runs. Do you have a suggestion on what to do in t=
his
>> > case? Is it possible to register a device driver before _INI runs?
>> >
>> >
>> >
>> >
>> >
>> > Thanks,
>> >
>> >
>> >
>> > Adam
>> >
>> >
>> >
>> >
>> >
>> > On Wed, May 13, 2015 at 4:07 PM, Moore, Robert
>> > <robert.moore@intel.com>
>> > wrote:
>> >
>> > Actually, I had a question about this.
>> >
>> >
>> >
>> > Given that the CMOS device has a _HID and requires a device driver
>> > (there can be multiple types of CMOS devices), in ACPICA we decide=
d
>> > that we could not provide CMOS interfaces.
>> >
>> >
>> >
>> > What problem does this patch solve, and how will it work in the fa=
ce
>> > of different CMOS devices?
>> >
>> >
>> >
>> > Thanks,
>> >
>> > Bob
>> >
>> >
>> >
>> >
>> >
>> > From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Adam Go=
ode
>> > Sent: Wednesday, May 13, 2015 4:53 AM
>> > To: devel@acpica.org
>> > Subject: [Devel] Correct place to send patches?
>> >
>> >
>> >
>> > Hi,
>> >
>> >
>> >
>> > Is this the correct place to send patches for review? I have a pat=
ch
>> > from a few weeks ago
>> > (https://lists.acpica.org/pipermail/devel/2015-May/000698.html) th=
at I
>> > would like feedback on.
>> >
>> >
>> >
>> >
>> >
>> > Thanks,
>> >
>> >
>> >
>> > Adam
>> >
>> >
>> >
>> >
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
