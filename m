From: Adam Goode <agoode@google.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 12:55:37 -0400
Message-ID: <CAOf41N=Ps3jgrxA7kU-Tu-tca1CsqZ_Wac3GFRGCu5U3ZN9p1g@mail.gmail.com>
References: <CAOf41Nnj3pmqDmc4xx9bwzhEpFsoxq5P2caNtsVBX31js9Ehgg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAA86@ORSMSX112.amr.corp.intel.com>
 <CAOf41NnO0RQVEmiX5KeMCMDtONxBfPO9BYZpAOBSNexWd1w_Fg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAAE9@ORSMSX112.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880271AE0F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802720637@SHSMSX101.ccr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE073@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vn0-f48.google.com ([209.85.216.48]:35114 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431AbbETQz7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 12:55:59 -0400
Received: by vnbf1 with SMTP id f1so4058588vnb.2
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2015 09:55:58 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE073@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

No, I did not see a _REG method defined in the code.


Adam


On Wed, May 20, 2015 at 12:46 PM, Moore, Robert <robert.moore@intel.com=
> wrote:
> Does the CMOS operation region have a _REG method?
>
>
>
>
>
> From: Zheng, Lv
> Sent: Tuesday, May 19, 2015 11:03 PM
> To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>
>
> Subject: RE: [Devel] Correct place to send patches?
>
>
>
> Since no reply from Tianyu=E2=80=A6
>
> What if we move _INI invocation out of ACPICA, and let OSPM to invoke=
 it.
>
>
>
> Thanks
>
> -Lv
>
>
>
> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zheng, Lv
> Sent: Thursday, May 14, 2015 8:33 AM
> To: Moore, Robert; Adam Goode; Lan, Tianyu
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: Re: [Devel] Correct place to send patches?
>
>
>
> You should discuss this in the linux-acpi mailing list where the Linu=
x CMOS
> opregion driver is implemented, reviewed, and merged.
>
> Let me Cc Tianyu who is the original author of the CMOS opregion driv=
er.
>
>
>
> Thanks
>
> -Lv
>
>
>
> From: Moore, Robert
> Sent: Wednesday, May 13, 2015 10:25 PM
> To: Adam Goode; Zheng, Lv
> Cc: devel@acpica.org
> Subject: RE: [Devel] Correct place to send patches?
>
>
>
> I=E2=80=99ll have to let Lv answer this question.
>
>
>
>
>
> From: Adam Goode [mailto:agoode@google.com]
> Sent: Wednesday, May 13, 2015 7:23 AM
> To: Moore, Robert
> Cc: devel@acpica.org
> Subject: Re: [Devel] Correct place to send patches?
>
>
>
> The problem is that on new Apple hardware (Macmini7,1 and others), th=
e
> system reads and writes from CMOS in _INI. With no CMOS handler, the
> Thunderbolt device doesn't initialize correctly.
>
>
>
> The current framework in Linux doesn't register the PNP* CMOS devices=
 until
> after _INI runs. Do you have a suggestion on what to do in this case?=
 Is it
> possible to register a device driver before _INI runs?
>
>
>
>
>
> Thanks,
>
>
>
> Adam
>
>
>
>
>
> On Wed, May 13, 2015 at 4:07 PM, Moore, Robert <robert.moore@intel.co=
m>
> wrote:
>
> Actually, I had a question about this.
>
>
>
> Given that the CMOS device has a _HID and requires a device driver (t=
here
> can be multiple types of CMOS devices), in ACPICA we decided that we =
could
> not provide CMOS interfaces.
>
>
>
> What problem does this patch solve, and how will it work in the face =
of
> different CMOS devices?
>
>
>
> Thanks,
>
> Bob
>
>
>
>
>
> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Adam Goode
> Sent: Wednesday, May 13, 2015 4:53 AM
> To: devel@acpica.org
> Subject: [Devel] Correct place to send patches?
>
>
>
> Hi,
>
>
>
> Is this the correct place to send patches for review? I have a patch =
from a
> few weeks ago
> (https://lists.acpica.org/pipermail/devel/2015-May/000698.html) that =
I would
> like feedback on.
>
>
>
>
>
> Thanks,
>
>
>
> Adam
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
