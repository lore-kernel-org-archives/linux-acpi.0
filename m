From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI Error under 2.6.26-rc*
Date: Tue, 15 Jul 2008 16:41:00 +0800
Message-ID: <1216111260.1617.131.camel@rzhang-dt>
References: <20080709083829.GA5748@linux.int.dgn.ag>
	 <200807102255.23090.rjw@sisk.pl> <1215739210.1617.28.camel@rzhang-dt>
	 <1215739682.1617.32.camel@rzhang-dt>
	 <20080714080914.GA4965@linux.int.dgn.ag>
	 <1216026701.1617.82.camel@rzhang-dt>
	 <20080715074130.GA4724@linux.int.dgn.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080715074130.GA4724-VuQAYsv1561O042OENdYwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andre Prendel <andre_prendel-Mmb7MZpHnFY@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Zhao, Yakui" <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2008-07-15 at 15:41 +0800, Andre Prendel wrote:
> On Mon, Jul 14, 2008 at 05:11:41PM +0800, Zhang Rui wrote:
> > > Hello Rui,
> > >
> > > that's quite strange. Booting the system to get an acpidump I hav=
e
> > > looked at the dmesg output and there is no ACPI Error like the on=
e
> > > above. There is only an ACPI Exeption.
> > >
> > > [...]
> > > Jul 13 22:00:18 ubuntu kernel: [    0.104111] ACPI: Core revision
> > > 20080321
> > > Jul 13 22:00:18 ubuntu kernel: [    0.104259] ACPI Exception
> > > (tbxface-0629): AE_NO_ACPI_TABLES, While loading namespace from
> ACPI
> > > tables [20080321]
> > > [...]
> > >
> > > Booting again I found the error again
> > >
> > > [...]
> > > Jul 13 22:10:50 ubuntu kernel: [    0.000000] ACPI Error
> > > (tbutils-0472): Invalid length 0x0 in RSDT/XSDT [20080321]
> > > [...]
> > >
> > > and acpidump says:
> > > root@ubuntu:/home/andre/src/acpi/pmtools-20071116/acpidump#
> > > ./acpidumpACPI tables were not found. If you know location of RSD
> PTR
> > > table (from dmesg, etc), supply it with either --addr or -a optio=
n
> > >
> > > Linux 2.6.25.10 always works.
> >
> > It seems that OS failed to get the correct RSDT address
> (0x1fff0000),
> > although the RSDP is found correctly. (=EF=BB=BFACPI: RSDP 000FA340=
, 0014)
> >
> > please run "./acpidump --addr 0xFA340 --length 0x14 > rsdp_xxx",
> > and attach the rsdp for all of the three cases (good, ACPI Error,
> ACPI
> > Exception).
>=20
> Hello Rui,
>=20
> here is the output of the three cases. The dump files are attached
> too.
>=20
> ----
> good
> ----
> andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump rsdp_good
> 0000000 5352 2044 5450 2052 418c 494d 2020 0020
> 0000010 0000 1fff                            =20
> 0000014
>=20
> -----
> error
> -----
> andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump rsdp_error
> 0000000 5352 2044 5450 2052 418a 494d 2020 0020
> 0000010 0000 21ff                            =20
> 0000014
>=20
> ---------
> exception
> ---------
> andre@ubuntu:~/src/acpi/pmtools-20071116/acpidump$ hexdump
> rsdp_exception
> 0000000 5352 2044 5450 2052 417c 494d 2020 0020
> 0000010 0000 2fff                            =20
> 0000014

Weird.
The dmesg shows that the memory map gotten from e820 table is changed.
And the file attached shows that rsdp points to different rsdt address.
>=20
> Now I see the ACPI Error under the 2.6.25.10 kernel sometimes too, bu=
t
> power off works well. So I also attach the two configs. Maybe the
> different config is the reason why power off works under 2.6.25.10.
so you may get different e820 table when running 2.6.25.10 as well?
could you please attach the dmesg output of a 2.6.25.10 kernel which ha=
s
the ACPI error?

> Is it possible that it is a hardware related issue?
Don't know. :(
It looks like a hardware issue as BIOS export different e820 tables.
But from your description, it seems to be a software regression.
please try to revert c3965bd15118742d72b4bc1a290d37b3f081eb98 and see i=
f
it helps.
Please re-attach the kernel config files as attachments.

thanks,
rui
