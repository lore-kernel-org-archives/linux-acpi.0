From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Tue, 21 Sep 2004 00:34:53 -0500
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200409210034.53554.dtor_core@ameritech.net>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409202020.05776.dtor_core@ameritech.net> <1095730900.8780.76.camel@mythbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1095730900.8780.76.camel@mythbox>
Content-Disposition: inline
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, "Brown, Len" <len.brown@intel.com>, LHNS list <lhns-devel@lists.sourceforge.net>, Linux IA64 <linux-ia64@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Monday 20 September 2004 08:41 pm, Alex Williamson wrote:
> Dmitry,
>=20
> =C2=A0 =C2=A0I imagined the sanitized interfaces would be provided vi=
a a userspace
> library, similar to how lspci provides a clean interface to all of th=
e
> PCI data. =C2=A0An "lsacpi" tool could extract the information into s=
omething
> more like you suggest. =C2=A0If you have objects exposed as human
> readable/writable files, I think you'll quickly end up with a _STA
> driver, _HID driver, _CID driver, _ADR driver, _UID driver, _EJx driv=
er,
> etc, etc, etc... =C2=A0I don't think we want that kind of bloat in th=
e kernel
> (that's what userspace is for ;^). =C2=A0Providing a solid, direct in=
terface
> to ACPI methods in the kernel seems like the most flexible, powerful
> interface IMHO.

Hmm, I do not quite agree. Except for "eject" being writeable to initia=
te
eject action the rest of the attributes would reflect kernel's view of =
the
device state and not re-evaluated when userspace references them. Monit=
oring
(or rather reacting to various events, like DEVICE_CHECK and BUS_CHECK)=
 and
updating devices' statuses and other data is responsibility of the core=
 ACPI
system. If system administrator is forced to manually (via libacpi or s=
ysfs)
query device status to "kick" the device into working state I'd conside=
r it
a bug, would'nt you agree?=20

I see that in your other mail you mention _CRS parsing and chipset disc=
overy.
I think that if you had an ability to just retrieve raw ACPI data from =
the
system that would suffice. In other words during normal operations ther=
e
is no need for "active" ACPI methods (such as _WAK, _S4, etc) to be ava=
ilable
from userspace. And just exporting raw data solves problem of bloating =
kernel
with parsing of vendor-specific data. I wonder if any of these methods =
need
arguments to run - if not then we would not need any adjustments to sys=
fs
opeen/close methods.

I am not saying that we should chose one method or another. I think the=
y both
can co-exist, as they can be used for diffectent purposes - the raw ACP=
I access=20
can affect state of the box while the sanitized attributes present kern=
el's
view and can be used to verify results of some action from kernel's POV=
=2E

--=20
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
