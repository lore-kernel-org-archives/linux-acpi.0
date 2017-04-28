From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Fri, 28 Apr 2017 02:33 +0200
Message-ID: <2213549.Q4Z823dSPo@aspire.rjw.lan>
References: <20170420201219.21568-1-drake@endlessm.com> <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60008 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033828AbdD1AjP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Apr 2017 20:39:15 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Daniel Drake <drake@endlessm.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

On Thursday, April 27, 2017 03:18:04 AM Zheng, Lv wrote:
> Hi,
> 
> > From: Daniel Drake [mailto:drake@endlessm.com]
> > Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
> > 
> > Hi Lv,
> > 
> > Thanks for the detailed response. In trying to decode the tricky code
> > flow and seeing all this first_ec / boot_ec / DSDT EC / ECDT EC stuff,
> > I seem to have made the wrong interpretation about how this is
> > designed.
> > 
> > On Sun, Apr 23, 2017 at 10:43 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> > > The entire problem looks to me is:
> > > When GPE setting differs between ECDT and DSDT, which one should be
> > > trusted by OS?
> > 
> > This case suggests that Windows uses the ECDT setting, right?
> 
> I checked the provided acpi tables.
> Indeed, the ECDT EC is correct.
> [000h 0000   4]                    Signature : "ECDT"    [Embedded Controller Boot Resources Table]
> [004h 0004   4]                 Table Length : 000000C1
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : EC
> [00Ah 0010   6]                       Oem ID : "_ASUS_"
> [010h 0016   8]                 Oem Table ID : "Notebook"
> [018h 0024   4]                 Oem Revision : 01072009
> [01Ch 0028   4]              Asl Compiler ID : "AMI."
> [020h 0032   4]        Asl Compiler Revision : 00000005
> 
> 
> [024h 0036  12]      Command/Status Register : [Generic Address Structure]
> [024h 0036   1]                     Space ID : 01 [SystemIO]
> [025h 0037   1]                    Bit Width : 08
> [026h 0038   1]                   Bit Offset : 00
> [027h 0039   1]         Encoded Access Width : 00 [Undefined/Legacy]
> [028h 0040   8]                      Address : 0000000000000066
> 
> [030h 0048  12]                Data Register : [Generic Address Structure]
> [030h 0048   1]                     Space ID : 01 [SystemIO]
> [031h 0049   1]                    Bit Width : 08
> [032h 0050   1]                   Bit Offset : 00
> [033h 0051   1]         Encoded Access Width : 00 [Undefined/Legacy]
> [034h 0052   8]                      Address : 0000000000000062
> 
> [03Ch 0060   4]                          UID : 00000000
> [040h 0064   1]                   GPE Number : 23
> [041h 0065  19]                     Namepath : "\_SB.PCI0.LPCB.EC0"
> 
> While the DSDT EC is in fact invalid as it returns 0 from its _STA:
>     Scope (_SB.PCI0.LPCB)
>     {
>         Device (H_EC)
>         {
>             Name (_HID, EisaId ("PNP0C09") /* Embedded Controller Device */)  // _HID: Hardware ID
>             Name (_UID, One)  // _UID: Unique ID
>             Method (_STA, 0, NotSerialized)  // _STA: Status
>             {
>                 ^^^GFX0.CLID = 0x03
>                 Return (Zero)
>             }
>             ...
>         }
>     }
> 
> It doesn't contain _CRS, so it's likely that it will fail in
> acpi_ec_dsdt_probe() due to failure of walk _CRS.
> 
> Are you sure the same problem can be seen no this platform?
> 
> If so, possibly you only need to add some sanity checks in
> acpi_ec_dsdt_probe().

Can you suggest a patch, please?

Ideally, something that can be tested?

Thanks,
Rafael

