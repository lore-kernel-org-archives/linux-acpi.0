From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Acpi on compaq evo N1000v
Date: Tue, 13 May 2003 14:33:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F842722FA@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Currently, I want to find out  what causes battery missing on (Presario =
1500, 1505, 2800T).
I looked into your fixes in 007dsdt, and found that the changes in =
method C0CF._REG() could take effect to your original problem.
To verify it, could you please only apply below change in C0CF._REG().

-                            If (LAnd (Arg1, LNot (LLess (\C009 (), =
0x03))))
+                            If (Arg1)

Thanks,
Luming

-----Original Message-----
From: Oeystein Olsen [mailto:oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org]
Sent: 2003?5?13? 2:48
To: Yu, Luming; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Brown, Len; Moore, Robert; Grover, Andrew
Subject: Re: [ACPI] Acpi on compaq evo N1000v


On Monday 12 May 2003 09:50, Yu, Luming wrote:
> On this mailing list, I saw some similar battery issues on various =
Compaq
> laptop, such as (Presario 1500, 1505us, 2800T). I'm interested in the =
dsdt
> tables that can make battery status work on your presario 2800T. Would =
you
> please share it with us? To let us better understand the original =
problme
> you ran into, would you please send me the orginal DSDT on N800v as =
well as
> the fixed one. I hope guys who were defeated by battery could absorb =
some
> useful information from your experience.  :) If you still have =
problem,
> please file it on bugzilla.kernel.org.
>
> Thanks
> Luming

Sorry, I probably wasn't very clear. Since the Compaq Evo N1000v, Evo =
N800v=20
and the Presario 2800T are very similar laptops, I tested dsdt-tables =
from=20
the Evo N800v and the Presario on the Evo N1000v. (Probably not a very=20
sensible thing to do, but I had a bad hangover and was bored.) If you =
look at=20
the dsdt-table from the Evo N1000v, it actually claims that the laptop =
is an=20
Evo N800v. Anyway, neither the Evo N800v nor the the Presario worked =
very=20
well, but the presario-table managed to get battery-status on the Evo =
N1000v.=20

Since the only knowledge I have about dsdt-tables and how they are=20
written/work is what I've been able to deduce from looking at few =
tables, it=20
required a few attempts to get a working dsdt-table. [ Don't expect the=20
changes to be very well written either:-) ] The original table (version =
000)=20
and my current (version 007) can be downloaded from=20

http://folk.uio.no/oeysteio/Compaq/DSDT/

The current version has been uploaded to the dsdt-section at=20
http://acpi.sourceforge.net. I've also added a comment about the one =
error=20
message I still get a boot. The dsdt-tables for the Evo N800v and the=20
Presario 2800T were downloaded from acpi.sourceforge.net.=20

I've just noticed that I get the following messages when I remove or =
insert=20
the ac-adapter. If anybody has any suggestions, I would welcome those.

acpi_processor-0842 [691] acpi_processor_get_pla: Error evaluation _PPC
[ACPI Debug] Integer: 0000000000000D9A
[ACPI Debug] Integer: 0000000000000D36
[ACPI Debug] Integer: 0000000000000D04
[ACPI Debug] Integer: 0000000000000CD2
[ACPI Debug] Integer: 0000000000000C3C
[ACPI Debug] Integer: 0000000000000DFE
[ACPI Debug] Integer: 0000000000000D68
[ACPI Debug] Integer: 0000000000000D04
[ACPI Debug] Integer: 0000000000000C6E



> -----Original Message-----
> From: Oeystein Olsen [mailto:oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org]
> Sent: 2003?5?11? 0:02
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] Acpi on compaq evo N1000v
>
>
> Followup to my own post now.
>
> I've finally gotten battery status on my laptop:-) Acpi seems to fully
> functional now. I solved my last problems by looking at how dsdt-table =
from
> evo N800v and presario 2800T loaded. I was rather suprised to see that =
the
> presario-table produced battery-status. Hence I rewrote parts of my
> original dsdt-table to reflect the battery part in the presario table =
and
> bingo! I
>
> still get these errors at boot though:
> > psparse-1121: *** Error: Method execution failed
> > [\_SB_.C03B.C04E.C0CF.C0D3] (Node c185e728), AE_NOT_EXIST
> >
> > Method execution failed [\_SB_.C03B.C04E.C0CF._INI] (Node c185b6a8),
> > AE_NOT_EXIST
> >
> > nsinit-0397 [06] ns_init_one_device    : \_SB_.C03B.C04E.C0CF._INI
> > failed: AE_NOT_EXIST
> >
> >  .........................................evrgnini-0261: *** Error: =
Could
> > not install pci_config handler for C03B, AE_ALREADY_EXISTS
>
> but I'm happy for now.

--=20
=D8ystein Olsen, oystein.olsen-rcBQPNaXqvV2YatnTvQNog@public.gmane.org, http://folk.uio.no/oeysteio
Institute of Theoretical Astrophysics, http://www.astro.uio.no
University of Oslo, Norway




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
