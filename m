From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Aspire 1705SMi LNKx?
Date: Mon, 25 Oct 2004 23:52:27 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFE3@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Ale <patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?gb2312?B?T2lzqKpuIE1hYyBGaGVhcmGoqg==?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's nice to hear that you have fixed the buggy DSDT.
But I want to say MS windows should be ok with=20
the original DSDT, which breaks linux somehow.
To make sure linux can live with the original one,
I think we need to identify the quirks in the specific box, that
we can take into linux acpi for the sake of compatibility.
So, please give a brief description on what you did.

Thanks
Luming=20

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org=20
>[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of=20
>Patrick Ale
>Sent: 2004=C4=EA10=D4=C225=C8=D5 22:31
>To: Ois=A8=AAn Mac Fheara=A8=AA
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] Acer Aspire 1705SMi LNKx?
>
>Hello,
>
>I'd be interested in the answer on this question aswell.
>On my Aspire 1703SM battery, temperature reading et all is working now
>(long live boring sundays where one has nothing better to do than
>drinking coffee and try to fix stuff).
>
>If anyone is interested in the modified DSDT I am using now, please
>send me an email and I'll hook you up.
>
>BIG PHAT WARNING: DO NOT, and again I repeat DO NOT use ANY of the
>1703 series DSDT from the repository on acpi.sourceforge.net. The DSDT
>for the SMi and SCME will do stuff that you dont want, like 50 ACPI
>errors in your syslog every second or a temperature that says 255C.
>
>The modifications to the DSDT of the 1703SM ARE the same as the ones
>in the repository, just on different lines of the dsl file.
>
>
>Thanks for all the people that helped me out.
>
>Patrick
>
>
>On Mon, 25 Oct 2004 09:09:41 +0100, Ois=A8=AAn Mac Fheara=A8=AA
><destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org> wrote:
>> I finally got around to compiling in my custom DSDT for my=20
>Acer Aspire 1705SMi
>> laptop, and have battery giving useful information now.
>>=20
>> However, there's still some somewhat confusing messages at=20
>bootup; can anyone
>> shed some light on this - is it bad/fixable?
>>=20
>> PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
>> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
>> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKA._CRS] (Node dfdeb7a8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10) *0
>> ACPI: PCI Interrupt Link [LNKB] (IRQs 3) *0, disabled.
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKC._CRS] (Node dfde93a8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *0
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKD._CRS] (Node dfde91a8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10) *0
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKE._CRS] (Node dfdeaea8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKE] (IRQs 7 10) *0
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKF._CRS] (Node dfdeaca8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKF] (IRQs 7 10) *0
>>   uteval-0205: *** Error: Return object type is incorrect
>> [\_SB_.PCI0.LPCB.LNKG._CRS] (Node dfdeaaa8), AE_TYPE
>> ACPI: PCI Interrupt Link [LNKG] (IRQs 7 10) *0
>> ACPI: PCI Interrupt Link [LNKH] (IRQs 7 10) *0, disabled.
>>=20
>> The portions of the DSDT in question are like this (in this=20
>instance, in
>> Device (LNKA)):
>>=20
>>                     Method (_CRS, 0, NotSerialized)
>>                     {
>>                         Store (Z00B, Local0)
>>                         CreateWordField (Local0, 0x01, IRA0)
>>                         If (LEqual (And=20
>(\_SB.PCI0.LPCB.PIRA, 0x80), Zero))
>>                         {
>>                             And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
>>                             ShiftLeft (0x01, Local0, IRA0)
>>                         }
>>                         Else
>>                         {
>>                             Store (0x00, IRA0)
>>                         }
>>=20
>>                         Return (Local0)
>>                     }
>>=20
>> Ois=A8=AAn
>>=20
>> -------------------------------------------------------
>> This SF.net email is sponsored by: IT Product Guide on=20
>ITManagersJournal
>> Use IT products in your business? Tell us what you think of=20
>them. Give us
>> Your Opinions, Get Free ThinkGeek Gift Certificates! Click=20
>to find out more
>> http://productguide.itmanagersjournal.com/guidepromo.tmpl
>> _______________________________________________
>> Acpi-devel mailing list
>> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: IT Product Guide on=20
>ITManagersJournal
>Use IT products in your business? Tell us what you think of=20
>them. Give us
>Your Opinions, Get Free ThinkGeek Gift Certificates! Click to=20
>find out more
>http://productguide.itmanagersjournal.com/guidepromo.tmpl
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
