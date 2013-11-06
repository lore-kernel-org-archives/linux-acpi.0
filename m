From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [SeaBIOS] [RFC PATCH] Add _PXM to CPU objects for NUMA hot-plug
Date: Wed, 06 Nov 2013 09:30:00 -0700
Message-ID: <1383755400.1847.44.camel@misato.fc.hp.com>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
	 <20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
	 <1383596774.1847.12.camel@misato.fc.hp.com>
	 <20131105102029.GA3933@shadowkeep>
	 <20131106134403.7beb75d7@nial.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:14790 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab3KFQeg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 11:34:36 -0500
In-Reply-To: <20131106134403.7beb75d7@nial.usersys.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Igor Mammedov <imammedo@redhat.com>
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, thilo.fromm@profitbricks.com, seabios@seabios.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Wed, 2013-11-06 at 13:44 +0100, Igor Mammedov wrote:
> On Tue, 5 Nov 2013 12:20:29 +0200
> Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com> wrote:
>=20
> > Hi Toshi,
> >=20
> > On Mon, Nov 04, 2013 at 01:26:14PM -0700, Toshi Kani wrote:
> > > On Mon, 2013-11-04 at 11:51 +0100, Vasilis Liaskovitis wrote:
> > > > Any comment on this?
> > > >=20
> > > > On Fri, Oct 25, 2013 at 11:32:10AM +0200, Vasilis Liaskovitis w=
rote:
> > > > > This patch adds a _PXM object to seabios CPU objects. The _PX=
M value is derived
> > > > > from CPU SRAT entries, so build_ssdt needs to be called after=
 build_srat for
> > > > > this to work.
> > > > >=20
> > > > > The motivation for this patch is a CPU hot-unplug/hot-plug bu=
g observed when
> > > > > using seabios and a 3.11 linux guest kernel on a multi-NUMA n=
ode qemu/kvm VM.
> > > > > The linux guest kernel parses the SRAT CPU entries at boot ti=
me and stores them
> > > > > in the array __apicid_to_node. When a CPU is hot-removed, the=
 linux guest kernel
> > > > > resets the removed CPU's __apicid_to_node entry to NO_NUMA_NO=
DE (kernel commit
> > > > > c4c60524). When the removed cpu is hot-added again, the linux=
 kernel looks up
> > > > > the hot-added cpu object's _PXM  value instead of somehow re-=
using the SRAT
> > > > > entry info (acpi_map_cpu2node calls acpi_get_node which calls=
 acpi_get_pxm). If
> > > > > the _PXM value is not found, the CPU is assumed to be on node=
 0, and it is
> > > > > hot-plugged in the wrong NUMA node.
> > > > >=20
> > > > > Which is the preferred OSPM way of looking up a CPU's proximi=
ty info at hotplug
> > > > > time? Is it the CPU object's _PXM value, or the already-parse=
d CPU SRAT entry?
> > > > > Or maybe both ways are valid?
> > >=20
> > > SRAT describes proximity values at boot-time.  During hotplug, th=
e
> > > kernel is supposed to obtain the current proximity value from _PX=
M
> > > method.
> quoting ACPI spec 5.0 (5.2.16 System Resource Affinity Table (SRAT)):
> "If the Local APIC ID / Local SAPIC ID / Local x2APIC ID
> of a dynamically added processor is not present in the SRAT, a _PXM o=
bject must exist for the
> processor=E2=80=99s device or one of its ancestors in the ACPI Namesp=
ace."
>=20
> so _PXM in not MUST have if there is entry for device in SRAT table a=
nd it seems Seabios
> builds table with possible CPUs included, so kernel just don't use al=
ready present info.
> Perhaps kernel should be fixed (i.e take affinity from SRAT table fir=
st and
> override value with _PXM if present).

I think the above statement is to emphasize the need of _PXM for
hotplug, but I will check the intention of the statement. =20

Here is a quote from ACPI 5.0, which restates what I said before.
=3D=3D=3D           =20
17.2.1 System Resource Affinity Table Definition

This optional System Resource Affinity Table (SRAT) provides the boot
time description of the processor and memory ranges belonging to a
system locality. OSPM will consume the SRAT only at boot time. OSPM
should use _PXM for any devices that are hot-added into the system afte=
r
boot up.
=3D=3D=3D=3D

Thanks,
-Toshi



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
