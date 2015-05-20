From: Adam Goode <agoode@google.com>
Subject: Re: [Devel] Correct place to send patches?
Date: Wed, 20 May 2015 15:52:43 -0400
Message-ID: <CAOf41Nm5yjmuYuzSj34xrdE2NA41waNbvxw0Bh6ySLVQmqnm2Q@mail.gmail.com>
References: <CAOf41Nnj3pmqDmc4xx9bwzhEpFsoxq5P2caNtsVBX31js9Ehgg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAA86@ORSMSX112.amr.corp.intel.com>
 <CAOf41NnO0RQVEmiX5KeMCMDtONxBfPO9BYZpAOBSNexWd1w_Fg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EAAE9@ORSMSX112.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E880271AE0F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E8802720637@SHSMSX101.ccr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE073@ORSMSX112.amr.corp.intel.com>
 <CAOf41N=Ps3jgrxA7kU-Tu-tca1CsqZ_Wac3GFRGCu5U3ZN9p1g@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0C7@ORSMSX112.amr.corp.intel.com>
 <CAOf41Nm50Y6dz5KA=KJaoQHqMxGHxzH2KCER91GA-AaAg=fAPQ@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE0FF@ORSMSX112.amr.corp.intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE133@ORSMSX112.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vn0-f45.google.com ([209.85.216.45]:42790 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbbETTxF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2015 15:53:05 -0400
Received: by vnbg129 with SMTP id g129so4431276vnb.9
        for <linux-acpi@vger.kernel.org>; Wed, 20 May 2015 12:53:04 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D2EE133@ORSMSX112.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>, "devel@acpica.org" <devel@acpica.org>

Interesting point about ACPICA throwing an exception when there is no
handler. The spec (6.0) says this:
"When an operation region handler is unavailable, AML cannot access
data fields in that region. (Operation region writes will be ignored
and reads will return indeterminate data.)."

If unavailable reads just returned 0, this code would all work. I have
no idea when this field would ever be set. I don't know if Windows
Installer has particular bytes it sets in the CMOS.

Perhaps Windows is just returning 0 on read. Why does ACPICA throw an e=
xception?



Here is the relevant device and _INI disassembly, with most things
elided. OSDW is a method that determines if the OS is Darwin.
\_SB.PCI0.LPCB.RTC.ISWI is the field of interest. I have not elided
any of these RTC references. On unpatched ACPICA/Linux (when Darwin
mode is disabled), the first Debug =3D \_SB.PCI0.LPCB.RTC.ISWI fails.




=2E....
                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00") /* AT Real-Time
Clock */)  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current
Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            )
                    })
                    OperationRegion (CMS0, SystemCMOS, 0x00, 0x40)
                    Field (CMS0, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x38),
                        ISTB,   1,
                            ,   2,
                        ISWI,   1,
                        Offset (0x39)
                    }
                }

=2E....

    Scope (\_SB.PCI0)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
=2E.... [elided]
            Debug =3D \_SB.PCI0.LPCB.RTC.ISWI
            If (!OSDW ())
            {
                If ((OSYS >=3D 0x07DC))
                {
                    Debug =3D "Save Ridge Config on Boot"
=2E.... [thunderbolt init code elided]
                    If ((\_SB.PCI0.LPCB.RTC.ISWI !=3D 0x01))
                    {
                        Debug =3D "Enable ICM on Boot"
=2E.... [more init code elided]
                    }
                    Else
                    {
                        Debug =3D "Windows Installation"
                    }
=2E.... [more code elided]
                    Debug =3D "Enable ICM on Boot, Complete"
                }
            }

On Wed, May 20, 2015 at 1:24 PM, Moore, Robert <robert.moore@intel.com>=
 wrote:
> Another possibility is that Windows just *ignores* a CMOS access from=
 the _INI before it gets a real CMOS driver installed. We've seen simil=
ar before.
>
> Could you please post the disassembled _INI method, or the binary DSD=
T where it came from?
> Thanks.
>
>> -----Original Message-----
>> From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Moore, Ro=
bert
>> Sent: Wednesday, May 20, 2015 10:17 AM
>> To: Adam Goode
>> Cc: Lan, Tianyu; linux-acpi@vger.kernel.org; Box, David E;
>> devel@acpica.org
>> Subject: Re: [Devel] Correct place to send patches?
>>
>> ACPICA does in fact try to bug-for-bug compatible with Windows.
>>
>> The trick is to figure out just *how* Windows works in these cases.
>>
>> I might guess that a solution may be that a "default handler" for th=
e CMOS
>> operation region should be installed immediately at boot time. If an=
d when
>> this handler is first run, it should figure out which CMOS device is
>> present on the system and then install the "real" handler for the de=
vice.
>> Or, if you want to support only one CMOS device, just install the re=
gion
>> handler at boot time and be done with it.
>>
>>
>>
>> > -----Original Message-----
>> > From: Adam Goode [mailto:agoode@google.com]
>> > Sent: Wednesday, May 20, 2015 10:11 AM
>> > To: Moore, Robert
>> > Cc: Zheng, Lv; Lan, Tianyu; linux-acpi@vger.kernel.org;
>> > devel@acpica.org; Box, David E
>> > Subject: Re: [Devel] Correct place to send patches?
>> >
>> > Yes, it really looks like a bug in the firmware. Still, Windows wo=
rks
>> > correctly without any special support.
>> >
>> > What is the policy for ACPICA in this case where Windows works in =
a
>> > spec- violating way?
>> >
>> >
>> > Adam
>> >
>> >
>> > On Wed, May 20, 2015 at 1:07 PM, Moore, Robert
>> > <robert.moore@intel.com>
>> > wrote:
>> > > Then perhaps this is where the machine is violating the ACPI
>> > specification:
>> > >
>> > >
>> > > 6.5.1 _INI (Init)
>> > >
>> > > The _INI method must only access Operation Regions that have bee=
n
>> > indicated to be available as defined by the _REG method.
>> > >
>> > >
>> > >
>> > >
>> > >> -----Original Message-----
>> > >> From: Adam Goode [mailto:agoode@google.com]
>> > >> Sent: Wednesday, May 20, 2015 9:56 AM
>> > >> To: Moore, Robert
>> > >> Cc: Zheng, Lv; Lan, Tianyu; linux-acpi@vger.kernel.org;
>> > >> devel@acpica.org
>> > >> Subject: Re: [Devel] Correct place to send patches?
>> > >>
>> > >> No, I did not see a _REG method defined in the code.
>> > >>
>> > >>
>> > >> Adam
>> > >>
>> > >>
>> > >> On Wed, May 20, 2015 at 12:46 PM, Moore, Robert
>> > >> <robert.moore@intel.com>
>> > >> wrote:
>> > >> > Does the CMOS operation region have a _REG method?
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > From: Zheng, Lv
>> > >> > Sent: Tuesday, May 19, 2015 11:03 PM
>> > >> > To: Zheng, Lv; Moore, Robert; Adam Goode; Lan, Tianyu
>> > >> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> > >> >
>> > >> >
>> > >> > Subject: RE: [Devel] Correct place to send patches?
>> > >> >
>> > >> >
>> > >> >
>> > >> > Since no reply from Tianyu=E2=80=A6
>> > >> >
>> > >> > What if we move _INI invocation out of ACPICA, and let OSPM t=
o
>> > >> > invoke
>> > >> it.
>> > >> >
>> > >> >
>> > >> >
>> > >> > Thanks
>> > >> >
>> > >> > -Lv
>> > >> >
>> > >> >
>> > >> >
>> > >> > From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Zh=
eng,
>> > >> > Lv
>> > >> > Sent: Thursday, May 14, 2015 8:33 AM
>> > >> > To: Moore, Robert; Adam Goode; Lan, Tianyu
>> > >> > Cc: linux-acpi@vger.kernel.org; devel@acpica.org
>> > >> > Subject: Re: [Devel] Correct place to send patches?
>> > >> >
>> > >> >
>> > >> >
>> > >> > You should discuss this in the linux-acpi mailing list where =
the
>> > >> > Linux CMOS opregion driver is implemented, reviewed, and merg=
ed.
>> > >> >
>> > >> > Let me Cc Tianyu who is the original author of the CMOS opreg=
ion
>> > driver.
>> > >> >
>> > >> >
>> > >> >
>> > >> > Thanks
>> > >> >
>> > >> > -Lv
>> > >> >
>> > >> >
>> > >> >
>> > >> > From: Moore, Robert
>> > >> > Sent: Wednesday, May 13, 2015 10:25 PM
>> > >> > To: Adam Goode; Zheng, Lv
>> > >> > Cc: devel@acpica.org
>> > >> > Subject: RE: [Devel] Correct place to send patches?
>> > >> >
>> > >> >
>> > >> >
>> > >> > I=E2=80=99ll have to let Lv answer this question.
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > From: Adam Goode [mailto:agoode@google.com]
>> > >> > Sent: Wednesday, May 13, 2015 7:23 AM
>> > >> > To: Moore, Robert
>> > >> > Cc: devel@acpica.org
>> > >> > Subject: Re: [Devel] Correct place to send patches?
>> > >> >
>> > >> >
>> > >> >
>> > >> > The problem is that on new Apple hardware (Macmini7,1 and
>> > >> > others), the system reads and writes from CMOS in _INI. With =
no
>> > >> > CMOS handler, the Thunderbolt device doesn't initialize corre=
ctly.
>> > >> >
>> > >> >
>> > >> >
>> > >> > The current framework in Linux doesn't register the PNP* CMOS
>> > >> > devices until after _INI runs. Do you have a suggestion on wh=
at
>> > >> > to do in this case? Is it possible to register a device drive=
r
>> > >> > before
>> > _INI runs?
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > Thanks,
>> > >> >
>> > >> >
>> > >> >
>> > >> > Adam
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > On Wed, May 13, 2015 at 4:07 PM, Moore, Robert
>> > >> > <robert.moore@intel.com>
>> > >> > wrote:
>> > >> >
>> > >> > Actually, I had a question about this.
>> > >> >
>> > >> >
>> > >> >
>> > >> > Given that the CMOS device has a _HID and requires a device
>> > >> > driver (there can be multiple types of CMOS devices), in ACPI=
CA
>> > >> > we decided that we could not provide CMOS interfaces.
>> > >> >
>> > >> >
>> > >> >
>> > >> > What problem does this patch solve, and how will it work in t=
he
>> > >> > face of different CMOS devices?
>> > >> >
>> > >> >
>> > >> >
>> > >> > Thanks,
>> > >> >
>> > >> > Bob
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > From: Devel [mailto:devel-bounces@acpica.org] On Behalf Of Ad=
am
>> > >> > Goode
>> > >> > Sent: Wednesday, May 13, 2015 4:53 AM
>> > >> > To: devel@acpica.org
>> > >> > Subject: [Devel] Correct place to send patches?
>> > >> >
>> > >> >
>> > >> >
>> > >> > Hi,
>> > >> >
>> > >> >
>> > >> >
>> > >> > Is this the correct place to send patches for review? I have =
a
>> > >> > patch from a few weeks ago
>> > >> > (https://lists.acpica.org/pipermail/devel/2015-May/000698.htm=
l)
>> > >> > that I would like feedback on.
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > Thanks,
>> > >> >
>> > >> >
>> > >> >
>> > >> > Adam
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> _______________________________________________
>> Devel mailing list
>> Devel@acpica.org
>> https://lists.acpica.org/mailman/listinfo/devel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
