From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acer Aspire 1705SMi LNKx?
Date: Wed, 27 Oct 2004 14:54:55 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE055027255D0@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: =?iso-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> The thing that worries me a little about this is, as time goes by and =
you
> create workarounds in the ACPI code (as, presumably, Windows has) for
> machine
> specific behaviour, will we end up with a constantly growing mess of =
code
> to
> handle them all, or will workarounds be phased out in favour of proper
> fixes?
>

A growing mess of code :(

Fortunately, most of the 'workarounds' are small and contained.

Bob

> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Ois=EDn Mac Fheara=ED
> Sent: Monday, October 25, 2004 2:48 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Yu, Luming
> Subject: Re: [ACPI] Acer Aspire 1705SMi LNKx?
>=20
> On Monday 25 October 2004 16:52, Yu, Luming wrote:
> > It's nice to hear that you have fixed the buggy DSDT.
> > But I want to say MS windows should be ok with
> > the original DSDT, which breaks linux somehow.
> > To make sure linux can live with the original one,
> > I think we need to identify the quirks in the specific box, that
> > we can take into linux acpi for the sake of compatibility.
> > So, please give a brief description on what you did.
> >
> > Thanks
> > Luming
>=20
> The thing that worries me a little about this is, as time goes by and =
you
> create workarounds in the ACPI code (as, presumably, Windows has) for
> machine
> specific behaviour, will we end up with a constantly growing mess of =
code
> to
> handle them all, or will workarounds be phased out in favour of proper
> fixes?
>=20
> I've uploaded the original binary dsdt, disassembled version (which I =
did
> using quite an old version of iasl) and fixed version to
> http://www.redbrick.dcu.ie/~exolon/dsdt , /dsdt.dsl and /fixed.dsl
> respectively.
>=20
> Here is the -U5 diff for summary. The fixes I used were all standard
> except
> for the Z00D problem. I found no references to Z00D in any of the =
tables
> supplied by the machine, so using a fixed version uploaded to the dsdt
> repository, replaced them with Z00C. Robert Moore mentioned that these
> values
> may get overwritten anyway and 0 would also have worked, so I suppose =
it
> doesn't matter. :)
>=20
> good luck,
> Ois=EDn
>=20
> ___
>=20
> --- dsdt.dsl	2004-10-25 22:11:22.501511136 +0100
> +++ fixed.dsl	2004-10-25 22:11:03.349422696 +0100
> @@ -1,10 +1,10 @@
>  /*
>   * Intel ACPI Component Architecture
> - * AML Disassembler version 20040715
> + * AML Disassembler version 20030918
>   *
> - * Disassembly of dsdt, Mon Oct 25 22:11:22 2004
> + * Disassembly of dsdt, Mon Aug 30 08:05:46 2004
>   */
>  DefinitionBlock ("DSDT.aml", "DSDT", 1, "PTLTD ", "650M", 100925440)
>  {
>      OperationRegion (P80G, SystemIO, 0x80, 0x01)
>      Field (P80G, ByteAcc, NoLock, Preserve)
> @@ -19,11 +19,11 @@
>          FANR,   8,
>          Offset (0x58),
>          F1CR,   8
>      }
>=20
> -    Scope (_PR)
> +    Scope (\_PR)
>      {
>          Processor (CPU0, 0x00, 0x00008010, 0x06) {}
>      }
>=20
>      Name (_S0, Package (0x02)
> @@ -50,11 +50,11 @@
>      Method (_PIC, 1, NotSerialized)
>      {
>          Store (Arg0, PICF)
>      }
>=20
> -    Scope (_SB)
> +    Scope (\_SB)
>      {
>          Name (OSTB, Ones)
>          Name (FWSO, "FWSO")
>          Name (ECEN, 0x00)
>          Name (ACST, 0x01)
> @@ -838,10 +838,11 @@
>                              {
>                                  Notify (VGA, 0x80)
>                                  Return (0x00)
>                              }
>                          }
> +		    	Return (0x00)
>                      }
>=20
>                      Method (USTA, 0, NotSerialized)
>                      {
>                          If (LEqual (\_SB.PCI0.LPCB.Z000, 0x00))
> @@ -3425,12 +3426,12 @@
>                  "          "
>              })
>              Name (PBST, Package (0x04)
>              {
>                  0x00,
> -                Z00D,
> -                Z00D,
> +                Z00C,
> +                Z00C,
>                  0x2710
>              })
>              Name (ERRC, 0x00)
>              Name (_PCL, Package (0x01)
>              {
> @@ -3719,10 +3720,11 @@
>                          }
>                      }
>                  }
>=20
>                  Decrement (Local1)
> +		Return (0x0)
>              }
>          }
>=20
>          Scope (\_TZ)
>          {
> @@ -3829,13 +3831,14 @@
>=20
>          If (LEqual (Arg0, 0x05))
>          {
>              \_SB.PCI0.LPCB.PHSR (0x06, 0x00)
>          }
> +	Return(Package(2){0, 0})
>      }
>=20
> -    Scope (_GPE)
> +    Scope (\_GPE)
>      {
>          Method (_L17, 0, NotSerialized)
>          {
>              Notify (\_SB.LID, 0x80)
>          }


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
