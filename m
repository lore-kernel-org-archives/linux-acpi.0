From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Thu, 11 Mar 2010 08:55:15 +0800
Message-ID: <1268268915.3606.101.camel@localhost.localdomain>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>
	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com>
	 <1268186225.3606.25.camel@localhost.localdomain>
	 <4B979E63.1070806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41149 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932973Ab0CKA4r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Mar 2010 19:56:47 -0500
In-Reply-To: <4B979E63.1070806@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-03-10 at 21:28 +0800, Prarit Bhargava wrote:
> >
> > Why do we need to see whether the memory is onlined before bringing=
 cpu
> > to online state? It seems that there is no dependency between cpu o=
nline
> > and memory online.
> >
> >  =20
>=20
> Yakui,
>=20

=EF=BB=BFThanks for the explanation.

> Here's a deeper look into the issue.  New Intel processors have an=20
> on-die memory controller and this means that as the socket comes and=20
> goes, so does the memory "behind" the socket.

Yes. The nehalem processor has the integrated memory controller. But it
is not required that the hot-added memory should be onlined before
bringing up CPU.
    I do the following memory-hotplug test on one Machine.
    a. Before hot plugging memory, four CPUs socket are installed and
all the logical CPU are brought up. (Only one node has the memory)
    b. The memory is hot-plugged and then the memory is onlined so that
it can be accessed by the system.

In the above testing case the CPU is brought up before onlining the
hot-added memory. And the test shows that it can work well.

>=20
> ie) with new processors it is possible that an entire node which=20
> consists of memory and cpus comes and goes with the socket enable and=
=20
> disable.
>=20
> The cpu bringup code does local node allocations for the cpu.  If the=
=20
> memory connected to the node (which is "behind" the socket) isn't=20
> online, then these allocations fail, and then the cpu bringup fails.

If the CPU can't allocate the memory from its own node, it can turn to
other node and see whether the memory can be allocated. And this depend=
s
on the NUMA allocation policy.

  =20
>=20
> P.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
