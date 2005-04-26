From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 0/3] ACPI based I/O APIC hot-plug
Date: Tue, 26 Apr 2005 17:03:26 +0300
Message-ID: <pan.2005.04.26.14.03.23.413590@yahoo.com>
References: <4267AD0E.3080006@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Kenji,

On Thu, 21 Apr 2005 22:39:26 +0900, Kenji Kaneshige wrote:

> Hi,
>=20
> Here is a set of patches to support ACPI based I/O APIC hotplug. This c=
ode
> consists of the following three patches.
>=20
>     - Add the new interfaces for I/O APIC hot-add/hot-remove. The
>       implementation of these interfaces depends on each architecture.
>=20
>     - IA64 implementation of above-mentioned interfeces for I/O APIC
>       hot-add/hot-remove.

Any plans for i386 implementation ?

>=20
>     - Add I/O APIC hot-add support to ACPIPHP dirver. PCI root bridge
>       hot-add will be fully functional with this patch. This will be al=
so
>       needed to support hot-add of p2p bridge hierarchy that contains I=
/O
>       APICs. This code supports only hot-add for now.
>=20
> These patches support I/O APIC hot-plug on ia64 only for now. These are
> against 2.6.12-rc2-mm3.
>=20
> Thanks,
> Kenji Kaneshige




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
