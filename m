From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI Error under 2.6.26-rc*
Date: Tue, 22 Jul 2008 16:18:35 +0800
Message-ID: <1216714715.1617.267.camel@rzhang-fc9>
References: <20080709083829.GA5748@linux.int.dgn.ag>
	 <200807102255.23090.rjw@sisk.pl> <1215739210.1617.28.camel@rzhang-dt>
	 <1215739682.1617.32.camel@rzhang-dt>
	 <20080714080914.GA4965@linux.int.dgn.ag>
	 <1216026701.1617.82.camel@rzhang-dt>
	 <20080715074130.GA4724@linux.int.dgn.ag>
	 <1216111260.1617.131.camel@rzhang-dt>
	 <20080717084102.GA4597@linux.int.dgn.ag>
	 <1216693359.1617.258.camel@rzhang-fc9>
	 <20080722080112.GA4653@linux.int.dgn.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080722080112.GA4653-VuQAYsv1561O042OENdYwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andre Prendel <andre_prendel-Mmb7MZpHnFY@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Zhao, Yakui" <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2008-07-22 at 16:01 +0800, Andre Prendel wrote:
> On Tue, Jul 22, 2008 at 10:22:39AM +0800, Zhang Rui wrote:
> > On Thu, 2008-07-17 at 16:41 +0800, Andre Prendel wrote:
> > > On Tue, Jul 15, 2008 at 04:41:00PM +0800, Zhang Rui wrote:
> > > > > > It seems that OS failed to get the correct RSDT address
> > > > > (0x1fff0000),
> > > > > > although the RSDP is found correctly. (=EF=BB=BFACPI: RSDP =
000FA340,
> > > 0014)
> > > > > >
> > > > > > please run "./acpidump --addr 0xFA340 --length 0x14 >
> rsdp_xxx",
> > > > > > and attach the rsdp for all of the three cases (good, ACPI
> > > Error,
> > > > > ACPI
> > > > > > Exception).
> > > > > Hello Rui,
> > > > >
> > > > > here is the output of the three cases. The dump files are
> attached
> > > > > too.
> > > > >
> > > > > ----
> > > > > good
> > > > > ----
> > > > > andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump
> > > rsdp_good
> > > > > 0000000 5352 2044 5450 2052 418c 494d 2020 0020
> > > > > 0000010 0000 1fff                          =20
> > > > > 0000014
> > > > >
> > > > > -----
> > > > > error
> > > > > -----
> > > > > andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump
> > > rsdp_error
> > > > > 0000000 5352 2044 5450 2052 418a 494d 2020 0020
> > > > > 0000010 0000 21ff                          =20
> > > > > 0000014
> > > > >
> > > > > ---------
> > > > > exception
> > > > > ---------
> > > > > andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump
> > > > > rsdp_exception
> > > > > 0000000 5352 2044 5450 2052 417c 494d 2020 0020
> > > > > 0000010 0000 2fff                          =20
> > > > > 0000014
> > > >
> > > > Weird.
> > > > The dmesg shows that the memory map gotten from e820 table is
> > > changed.
> > > > And the file attached shows that rsdp points to different rsdt
> > > address.
> > > > >
> > > > > Now I see the ACPI Error under the 2.6.25.10 kernel sometimes
> too,
> > > but
> > > > > power off works well. So I also attach the two configs. Maybe
> the
> > > > > different config is the reason why power off works under
> > > 2.6.25.10.
> > > > so you may get different e820 table when running 2.6.25.10 as
> well?
> > > > could you please attach the dmesg output of a 2.6.25.10 kernel
> which
> > > has
> > > > the ACPI error?
> > >
> > > Attached. Yes, the e820 table differs, but power off still works.
> >
> > Hmm, there seems to be two bugs here.
> > 1. invalid e820 tables, which seems like a BIOS bug, please try to
> > upgrade your BIOS.
> > 2. poweroff doesn't work.
> >    Hmm, please try boot option "acpi=3Doff" in both 2.6.25 and 2.6.=
26.
> >    I guess power off works on 2.6.25 while it fails on 2.6.26,
> right?
>=20
> Hello Rui,
>=20
> I have found the power off problem. After bisecting the problem
> without
> success I compared the configs from 2.6.25.10 and 2.6.26-rc*. I have
> seen a difference in the APM section. In the 2.6.26-rc* config
> CONFIG_APM_DO_ENABLE was not enabled.
hah, this explains why power off doesn't work in 2.6.26 when ACPI is
disabled.

>  I dont know how this could happen. AFAIR
> I used the working 2.6.25 config and made just a "make oldconfig". So
> I have
> enabled CONFIG_APM_DO_ENABLE, build the kernel and now power off work=
s
> fine. Further the ACPI errors/exceptions do not appear with 2.6.26
> (stable)
> and the new config. Maybe this is why CONFIG_APM_DO_ENABLE is enabled=
=2E
> I dont
> know the relation between this option and ACPI.
>=20
> -----------------------
> dmesg (extract)
> -----------------------
> Linux version 2.6.26-default (andre@ubuntu) (gcc version 4.1.3
> 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #13 Mon Jul 21
> 22:48:01 CEST 2008
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
>  BIOS-e820: 000000002fff0000 - 000000002fff8000 (ACPI data)
>  BIOS-e820: 000000002fff8000 - 0000000030000000 (ACPI NVS)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
>  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> [...]
> ACPI: Interpreter disabled.
> Linux Plug and Play Support v0.97 (c) Adam Belay
> pnp: PnP ACPI: disabled
> [...]
>=20
> The bios problem still exists so maybe I will do an upgrade.
>=20
agree.
so there is no problem in the upstream kernel. :)

thanks,
rui
