From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [RFC] acpi processor and cpufreq harester - aka pipe
 all of that up to the hypervisor (v3)
Date: Wed, 15 Feb 2012 11:33:41 -0500
Message-ID: <20120215163340.GD4093@phenom.dumpdata.com>
References: <1329196009-25268-1-git-send-email-konrad.wilk@oracle.com>
 <20120214183006.GJ12984@reaktio.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30765 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab2BOQhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2012 11:37:03 -0500
Content-Disposition: inline
In-Reply-To: <20120214183006.GJ12984@reaktio.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: ke.yu@intel.com, kevin.tian@intel.com, JBeulich@novell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xensource.com

On Tue, Feb 14, 2012 at 08:30:06PM +0200, Pasi K=E4rkk=E4inen wrote:
> On Tue, Feb 14, 2012 at 12:06:46AM -0500, Konrad Rzeszutek Wilk wrote=
:
> >=20
> > This "harvester" (I am horrible with names, if you have any suggest=
ions please
> > tell me them) collects the information that the cpufreq drivers and=
 the
> > ACPI processor code save in the 'struct acpi_processor' and then se=
nds it to
> > the hypervisor.
> >=20
>=20
> Btw there's a typo in the subject line.. "harester".

Duh!
>=20
> I'm not very good with names either: collector? passthru?=20

"passthru" sounds better.
>=20
>=20
> > The driver can be either an module or compiled in. In either mode t=
he driver
> > launches a thread that checks whether an cpufreq driver is register=
ed. If so
> > it reads all the 'struct acpi_processor' data for all online CPUs a=
nd sends
> > it to hypervisor. The driver also register a CPU hotplug component =
- so if a new
> > CPU shows up - it would send the data to the hypervisor for it as w=
ell.
> >=20
> > I've tested this with success on a variety of Intel and AMD hardwar=
e (need
> > a patch to the hypervisor to allow the rdmsr to be passed through).=
 The one
> > caveat is that dom0_max_vcpus inhibits the driver from reading the =
vCPUs
> > that are not present in dom0. One solution is to boot without dom0_=
max_vcpus
> > and utilize the 'xl vcpu-set' command to offline the vCPUs. Other o=
ne that
> > Nakajima Jun suggested was to hotplug vCPUS in - so bootup dom0 and=
 hotplug
> > the vCPUs in - but I am running in difficulties on how to do this i=
n the hypervisor.
> >=20
>=20
> When using this driver do you need to pass any options to Xen hypervi=
sor?=20
> (cpufreq=3Dsomething) ?=20

No need. You only need that if you want to change the default cpufreq d=
river from
the ondemand to performance (so cpufreq=3Dperformance) or want more ver=
bose information:
cpufreq=3Dverbose,performance

By default the Xen hypervisor will take the cpufreq data in account unl=
ess you
override that with 'dom0-is-deciding-power-management-and-I-cant-rememb=
er-exactly'
parameter.

>=20
> It might be good to mention something about that in the patch comment=
s.

I will include cpufreq=3Dverbose and mention that the effect before and=
 after. And also
with xenpm.

Thanks!
>=20
> -- Pasi
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
