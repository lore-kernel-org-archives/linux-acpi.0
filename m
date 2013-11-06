From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [SeaBIOS] [RFC PATCH] Add _PXM to CPU objects for NUMA hot-plug
Date: Wed, 6 Nov 2013 13:44:03 +0100
Message-ID: <20131106134403.7beb75d7@nial.usersys.redhat.com>
References: <1382693530-31137-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
	<20131104105149.GB30503@dhcp-192-168-178-175.profitbricks.localdomain>
	<1383596774.1847.12.camel@misato.fc.hp.com>
	<20131105102029.GA3933@shadowkeep>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756360Ab3KFMoa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 07:44:30 -0500
In-Reply-To: <20131105102029.GA3933@shadowkeep>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Cc: Toshi Kani <toshi.kani@hp.com>, thilo.fromm@profitbricks.com, seabios@seabios.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

On Tue, 5 Nov 2013 12:20:29 +0200
Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com> wrote:

> Hi Toshi,
>=20
> On Mon, Nov 04, 2013 at 01:26:14PM -0700, Toshi Kani wrote:
> > On Mon, 2013-11-04 at 11:51 +0100, Vasilis Liaskovitis wrote:
> > > Any comment on this?
> > >=20
> > > On Fri, Oct 25, 2013 at 11:32:10AM +0200, Vasilis Liaskovitis wro=
te:
> > > > This patch adds a _PXM object to seabios CPU objects. The _PXM =
value is derived
> > > > from CPU SRAT entries, so build_ssdt needs to be called after b=
uild_srat for
> > > > this to work.
> > > >=20
> > > > The motivation for this patch is a CPU hot-unplug/hot-plug bug =
observed when
> > > > using seabios and a 3.11 linux guest kernel on a multi-NUMA nod=
e qemu/kvm VM.
> > > > The linux guest kernel parses the SRAT CPU entries at boot time=
 and stores them
> > > > in the array __apicid_to_node. When a CPU is hot-removed, the l=
inux guest kernel
> > > > resets the removed CPU's __apicid_to_node entry to NO_NUMA_NODE=
 (kernel commit
> > > > c4c60524). When the removed cpu is hot-added again, the linux k=
ernel looks up
> > > > the hot-added cpu object's _PXM  value instead of somehow re-us=
ing the SRAT
> > > > entry info (acpi_map_cpu2node calls acpi_get_node which calls a=
cpi_get_pxm). If
> > > > the _PXM value is not found, the CPU is assumed to be on node 0=
, and it is
> > > > hot-plugged in the wrong NUMA node.
> > > >=20
> > > > Which is the preferred OSPM way of looking up a CPU's proximity=
 info at hotplug
> > > > time? Is it the CPU object's _PXM value, or the already-parsed =
CPU SRAT entry?
> > > > Or maybe both ways are valid?
> >=20
> > SRAT describes proximity values at boot-time.  During hotplug, the
> > kernel is supposed to obtain the current proximity value from _PXM
> > method.
quoting ACPI spec 5.0 (5.2.16 System Resource Affinity Table (SRAT)):
"If the Local APIC ID / Local SAPIC ID / Local x2APIC ID
of a dynamically added processor is not present in the SRAT, a _PXM obj=
ect must exist for the
processor=E2=80=99s device or one of its ancestors in the ACPI Namespac=
e."

so _PXM in not MUST have if there is entry for device in SRAT table and=
 it seems Seabios
builds table with possible CPUs included, so kernel just don't use alre=
ady present info.
Perhaps kernel should be fixed (i.e take affinity from SRAT table first=
 and
override value with _PXM if present).

>=20
> thanks for the clarification.
> >=20
> > > > This issue may require a kernel fix alternatively or additional=
ly to the seabios
> > > > fix: The kernel can save the originally parsed SRAT entry info =
somewhere before
> > > > it resets it at hot-remove time, and use that info on hot-plug =
time if the _PXM
> > > > value is missing for the hot-plugged CPU BIOS object. This way =
CPU hot-plug
> > > > works well against a BIOS with no CPU _PXM info.
> >=20
> > To support CPU hotplug, seabios needs to implement _PXM to CPU or i=
ts
> > parent device object when the system has multiple nodes.
>=20
> ok, so no linux kernel changes are needed. Only adding PXM to seabios=
 CPUs
> objects should be enough, which is what this RFC patch does.=20
>=20
> thanks,
>=20
> - Vasilis
> >=20
> >=20
> >=20
> >=20
>=20
> _______________________________________________
> SeaBIOS mailing list
> SeaBIOS@seabios.org
> http://www.seabios.org/mailman/listinfo/seabios

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
