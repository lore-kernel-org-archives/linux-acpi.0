From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Date: Sat, 19 Mar 2005 15:50:16 +0200
Message-ID: <pan.2005.03.19.13.50.15.938352@yahoo.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 18 Mar 2005 13:38:57 -0800, Rajesh Shah wrote:

> Here is a series of patches to support ACPI hot-add of a root bridge
> hierarchy. The added hierarchy may contain other p2p bridges and end/le=
af
> I/O devices too. The root bridge itself is assumed to have been assigne=
d
> resource ranges, but the p2p bridges and end devices are not required t=
o
> be initialized by firmware. Most of the code changes are to make the
> existing code flows suitable for such a hierarchy of bridges & devices.
>=20
> This code supports hot-add on ia64 only for now.It does not yet support
> I/O APIC hot-add, which is needed to make this fully functional.  The
> patches are against 2.6.11-mm4 (plus the patch needed for ia64 to boot)=
.
> I've tested to make sure this does not break end/leaf device hotplug on
> the hotplug capable ia64 box I have.
>=20
> Thanks,
> Rajesh

Does this mean that when it will be ported for i386, I will be able to
really use my Docking Station ?
Does it rescan the DSDT to find new additions to ACPI devices ?

I have an IBM docking station with a PCI bus inside and some other
devices, and when I hot plug my IBM ThinkPad T41 in it, it does not
recognize those devices. Only if I boot in dock they are usable.
And the DSDT is different if I boot in dock or not.
So I wander if this patch would help me to hot plug my T41 in the dock an=
d
all devices will be recognized. (when the patch will be for i386 too)


Thx,
Paul



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
