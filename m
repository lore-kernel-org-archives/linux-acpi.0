From: Patrick Ale <patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Acer Aspire 1705SMi LNKx?
Date: Mon, 25 Oct 2004 21:10:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <8d158e1f04102512101b5808e2@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F84041ABFE3@pdsmsx403>
Reply-To: Patrick Ale <patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFE3@pdsmsx403>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I can send you the output of a "diff -u5" so you can see what I did if
you llike.
Next to the DSDT changes I patched my vanilla 2.6.9 kernel with the
latest Alax Cox patch (-ac4) which also solved the last errors about
the LNKx errors. So my guess is that it is both an DSDT plus an kernel
issue.

Maybe Windows has some nifty way of not needing the exact/specific
adresses for hardware/functionality, I dunno, I am not a programmer :D

Let me know if you want the diff file and i'll send you right away.


Cheers,

Patrick


On Mon, 25 Oct 2004 23:52:27 +0800, Yu, Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> It's nice to hear that you have fixed the buggy DSDT.
> But I want to say MS windows should be ok with
> the original DSDT, which breaks linux somehow.
> To make sure linux can live with the original one,
> I think we need to identify the quirks in the specific box, that
> we can take into linux acpi for the sake of compatibility.
> So, please give a brief description on what you did.
>=20
> Thanks
> Luming=20
>=20
>=20
>=20
> >-----Original Message-----
> >From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of
> >Patrick Ale
> >Sent: 2004=E5=B9=B410=E6=9C=8825=E6=97=A5 22:31
> >To: Ois=C3=ADn Mac Fheara=C3=AD
> >Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >Subject: Re: [ACPI] Acer Aspire 1705SMi LNKx?
> >
> >Hello,
> >
> >I'd be interested in the answer on this question aswell.
> >On my Aspire 1703SM battery, temperature reading et all is working now
> >(long live boring sundays where one has nothing better to do than
> >drinking coffee and try to fix stuff).
> >
> >If anyone is interested in the modified DSDT I am using now, please
> >send me an email and I'll hook you up.
> >
> >BIG PHAT WARNING: DO NOT, and again I repeat DO NOT use ANY of the
> >1703 series DSDT from the repository on acpi.sourceforge.net. The DSDT
> >for the SMi and SCME will do stuff that you dont want, like 50 ACPI
> >errors in your syslog every second or a temperature that says 255C.
> >
> >The modifications to the DSDT of the 1703SM ARE the same as the ones
> >in the repository, just on different lines of the dsl file.
> >
> >
> >Thanks for all the people that helped me out.
> >
> >Patrick
> >
> >
> >On Mon, 25 Oct 2004 09:09:41 +0100, Ois=C3=ADn Mac Fheara=C3=AD
> ><destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org> wrote:
> >> I finally got around to compiling in my custom DSDT for my
> >Acer Aspire 1705SMi
> >> laptop, and have battery giving useful information now.
> >>
> >> However, there's still some somewhat confusing messages at
> >bootup; can anyone
> >> shed some light on this - is it bad/fixable?
> >>
> >> PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
> >> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> >> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKA._CRS] (Node dfdeb7a8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10) *0
> >> ACPI: PCI Interrupt Link [LNKB] (IRQs 3) *0, disabled.
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKC._CRS] (Node dfde93a8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKC] (IRQs 5) *0
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKD._CRS] (Node dfde91a8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10) *0
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKE._CRS] (Node dfdeaea8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKE] (IRQs 7 10) *0
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKF._CRS] (Node dfdeaca8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKF] (IRQs 7 10) *0
> >>   uteval-0205: *** Error: Return object type is incorrect
> >> [\_SB_.PCI0.LPCB.LNKG._CRS] (Node dfdeaaa8), AE_TYPE
> >> ACPI: PCI Interrupt Link [LNKG] (IRQs 7 10) *0
> >> ACPI: PCI Interrupt Link [LNKH] (IRQs 7 10) *0, disabled.
> >>
> >> The portions of the DSDT in question are like this (in this
> >instance, in
> >> Device (LNKA)):
> >>
> >>                     Method (_CRS, 0, NotSerialized)
> >>                     {
> >>                         Store (Z00B, Local0)
> >>                         CreateWordField (Local0, 0x01, IRA0)
> >>                         If (LEqual (And
> >(\_SB.PCI0.LPCB.PIRA, 0x80), Zero))
> >>                         {
> >>                             And (\_SB.PCI0.LPCB.PIRA, 0x0F, Local0)
> >>                             ShiftLeft (0x01, Local0, IRA0)
> >>                         }
> >>                         Else
> >>                         {
> >>                             Store (0x00, IRA0)
> >>                         }
> >>
> >>                         Return (Local0)
> >>                     }
> >>
> >> Ois=C3=ADn
> >>
> >> -------------------------------------------------------
> >> This SF.net email is sponsored by: IT Product Guide on
> >ITManagersJournal
> >> Use IT products in your business? Tell us what you think of
> >them. Give us
> >> Your Opinions, Get Free ThinkGeek Gift Certificates! Click
> >to find out more
> >> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> >> _______________________________________________
> >> Acpi-devel mailing list
> >> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >>
> >
> >
> >-------------------------------------------------------
> >This SF.net email is sponsored by: IT Product Guide on
> >ITManagersJournal
> >Use IT products in your business? Tell us what you think of
> >them. Give us
> >Your Opinions, Get Free ThinkGeek Gift Certificates! Click to
> >find out more
> >http://productguide.itmanagersjournal.com/guidepromo.tmpl
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
