From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Thu, 12 Nov 2009 15:43:38 +0800
Message-ID: <1258011818.3802.16.camel@localhost.localdomain>
References: <4AF7D820.5040503@kernel.org> <200911091315.13151.rjw@sisk.pl>
	 <4AFA210B.3020207@kernel.org>
	 <1257930767.31183.113.camel@localhost.localdomain>
	 <4AFB0B02.4050306@kernel.org>
	 <1257988632.31183.134.camel@localhost.localdomain>
	 <4AFB7D21.6050004@kernel.org>
	 <1257997072.3888.4.camel@localhost.localdomain>
	 <4AFB9B60.7010009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751651AbZKLHpK@vger.kernel.org>
In-Reply-To: <4AFB9B60.7010009@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2009-11-12 at 13:21 +0800, Yinghai Lu wrote:
> ykzhao wrote:
> > On Thu, 2009-11-12 at 11:12 +0800, Yinghai Lu wrote:
> >> ykzhao wrote:
> >>> On Thu, 2009-11-12 at 03:05 +0800, Yinghai Lu wrote:
> >>>> ykzhao wrote:
> >>>>> On Wed, 2009-11-11 at 10:27 +0800, Yinghai Lu wrote:
> >>>>>> try to find_e820_area/reserve_early, and call acpi_reserve_mem=
ory early
> >>>>>>
> >>>>>> to get area is below 1M
> >>>>>>
> >>>>>> -v2: change function name to acpi_reserve_wakeup_memory accord=
ing to Rafael
> >>>>> It seems that the function of find_e820_area is called in sever=
al
> >>>>> places.
> >>>>>    >Initmem_init: bootmap =3D find_e820_area(0, end_pfn<<PAGE_S=
HIFT,
> >>>>> bootmap_size, PAGE_SIZE);
> >>>>>   =20
> >>>>> If we also call it in the acpi_reserve_wakeup_memory, do we get=
 the same
> >>>>> base address as that obtained in initmem_init?
> >>>> no. find_e820_area will check the reserve res array that could b=
e updated by reserve_early.
> >>> It will check the reserved region array when calling the function=
 of
> >>> find_e820_area.=20
> >>> But it seems that the array is not updated when the find_e820_are=
a is
> >>> called in the function of initmem_init.
> >> right after that will use reserve_bootmem for those range in initm=
em_init.
> > Yes. The reserve_bootmem is called for the range in initmem_init.
> > But the reserved_early array is not updated.
>=20
> it is not needed anymore because bootmem for that node is ready at th=
at point, could use=20
> reserve_bootmem_node directly. and before that early_res_to_bootmem w=
ill convert that early resource that=20
> fall into that node range to bootmem reserved too.
>=20
> please check code setup_node_bootmem/early_node_mem/early_res_to_boot=
mem ...and reserve_bootmem_node...
Sorry that I don't notice that the function
of =EF=BB=BFacpi_reserve_wakeup_memory is also moved early before initi=
alizing
the bootmem allocator.
If so, there is no problem.

thanks.
>=20
> YH
