From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Aspire 1705SMi LNKx?
Date: Wed, 27 Oct 2004 09:35:37 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFED@pdsmsx403>
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

_CRS for the device should return IRQ descriptor .
The first byte should be : Value =3D 0010001nB (Type =3D 0, small item =
name =3D 0x4, length =3D (2 or 3))

Thanks
Luming=20

>-----Original Message-----
>From: Patrick Ale [mailto:patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
>Sent: 2004=C4=EA10=D4=C227=C8=D5 2:46
>To: Ois=A8=AAn Mac Fheara=A8=AA
>Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Yu, Luming
>Subject: Re: [ACPI] Acer Aspire 1705SMi LNKx?
>
>Hello,
>
>When I use the fixed.dsl you mentioned in your earlyer mail I dont get
>the compile errors.
>Unfortunately the error messages regarding the PCI0.LNK thingies still
>appear for me.
>But like I mentioned, I have an Aspire 1703 so maybe for me the
>changes you made dont work quite as expected on an Aspire 1705 altho
>the earlyer changes that were needed were the same as for me.
>
>I apriciate your efford and time nevertheless. I'll just have to look
>a bit further.
>
>Thanks!
>
>Patrick
>
>
>On Tue, 26 Oct 2004 13:54:46 +0200, Patrick Ale=20
><patrick.ale-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Heya,
>>=20
>> @@ -3829,13 +3831,14 @@
>>=20
>>         If (LEqual (Arg0, 0x05))
>>         {
>>             \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
>>         }
>> +       Return(Package(2){0, 0})
>>=20
>> Does this actually work? When I try to compile it gives me an error
>> about an unexpected "("
>>=20
>> Take care!
>>=20
>> Patrick
>>=20
>> On Mon, 25 Oct 2004 22:47:38 +0100, Ois=A8=AAn Mac Fheara=A8=AA
>>=20
>>=20
>> <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org> wrote:
>> > On Monday 25 October 2004 16:52, Yu, Luming wrote:
>> > > It's nice to hear that you have fixed the buggy DSDT.
>> > > But I want to say MS windows should be ok with
>> > > the original DSDT, which breaks linux somehow.
>> > > To make sure linux can live with the original one,
>> > > I think we need to identify the quirks in the specific box, that
>> > > we can take into linux acpi for the sake of compatibility.
>> > > So, please give a brief description on what you did.
>> > >
>> > > Thanks
>> > > Luming
>> >
>> > The thing that worries me a little about this is, as time=20
>goes by and you
>> > create workarounds in the ACPI code (as, presumably,=20
>Windows has) for machine
>> > specific behaviour, will we end up with a constantly=20
>growing mess of code to
>> > handle them all, or will workarounds be phased out in=20
>favour of proper fixes?
>> >
>> > I've uploaded the original binary dsdt, disassembled=20
>version (which I did
>> > using quite an old version of iasl) and fixed version to
>> > http://www.redbrick.dcu.ie/~exolon/dsdt , /dsdt.dsl and /fixed.dsl
>> > respectively.
>> >
>> > Here is the -U5 diff for summary. The fixes I used were=20
>all standard except
>> > for the Z00D problem. I found no references to Z00D in any=20
>of the tables
>> > supplied by the machine, so using a fixed version uploaded=20
>to the dsdt
>> > repository, replaced them with Z00C. Robert Moore=20
>mentioned that these values
>> > may get overwritten anyway and 0 would also have worked,=20
>so I suppose it
>> > doesn't matter. :)
>> >
>> > good luck,
>> > Ois=A8=AAn
>> >
>> > ___
>> >
>> > --- dsdt.dsl    2004-10-25 22:11:22.501511136 +0100
>> > +++ fixed.dsl   2004-10-25 22:11:03.349422696 +0100
>> > @@ -1,10 +1,10 @@
>> >  /*
>> >   * Intel ACPI Component Architecture
>> > - * AML Disassembler version 20040715
>> > + * AML Disassembler version 20030918
>> >   *
>> > - * Disassembly of dsdt, Mon Oct 25 22:11:22 2004
>> > + * Disassembly of dsdt, Mon Aug 30 08:05:46 2004
>> >   */
>> >  DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "650M",=20
>100925440)
>> >  {
>> >      OperationRegion (P80G, SystemIO, 0x80, 0x01)
>> >      Field (P80G, ByteAcc, NoLock, Preserve)
>> > @@ -19,11 +19,11 @@
>> >          FANR,   8,
>> >          Offset (0x58),
>> >          F1CR,   8
>> >      }
>> >
>> > -    Scope (_PR)
>> > +    Scope (\_PR)
>> >      {
>> >          Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>> >      }
>> >
>> >      Name (_S0, Package (0x02)
>> > @@ -50,11 +50,11 @@
>> >      Method (_PIC, 1, NotSerialized)
>> >      {
>> >          Store (Arg0, PICF)
>> >      }
>> >
>> > -    Scope (_SB)
>> > +    Scope (\_SB)
>> >      {
>> >          Name (OSTB, Ones)
>> >          Name (FWSO, "FWSO")
>> >          Name (ECEN, 0x00)
>> >          Name (ACST, 0x01)
>> > @@ -838,10 +838,11 @@
>> >                              {
>> >                                  Notify (VGA, 0x80)
>> >                                  Return (0x00)
>> >                              }
>> >                          }
>> > +                       Return (0x00)
>> >                      }
>> >
>> >                      Method (USTA, 0, NotSerialized)
>> >                      {
>> >                          If (LEqual (\_SB.PCI0.LPCB.Z000, 0x00))
>> > @@ -3425,12 +3426,12 @@
>> >                  "          "
>> >              })
>> >              Name (PBST, Package (0x04)
>> >              {
>> >                  0x00,
>> > -                Z00D,
>> > -                Z00D,
>> > +                Z00C,
>> > +                Z00C,
>> >                  0x2710
>> >              })
>> >              Name (ERRC, 0x00)
>> >              Name (_PCL, Package (0x01)
>> >              {
>> > @@ -3719,10 +3720,11 @@
>> >                          }
>> >                      }
>> >                  }
>> >
>> >                  Decrement (Local1)
>> > +               Return (0x0)
>> >              }
>> >          }
>> >
>> >          Scope (\_TZ)
>> >          {
>> > @@ -3829,13 +3831,14 @@
>> >
>> >          If (LEqual (Arg0, 0x05))
>> >          {
>> >              \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
>> >          }
>> > +       Return(Package(2){0, 0})
>> >      }
>> >
>> > -    Scope (_GPE)
>> > +    Scope (\_GPE)
>> >      {
>> >          Method (_L17, 0, NotSerialized)
>> >          {
>> >              Notify (\_SB.LID, 0x80)
>> >          }
>> >
>> >
>> >
>>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
