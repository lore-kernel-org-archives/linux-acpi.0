From: "Howell, David P" <david.p.howell-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: kernel update (relative to v2.5.67)
Date: Mon, 14 Apr 2003 10:00:59 -0700
Sender: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
Message-ID: <331AD7BED1579543AD146F5A1A44D525011CA6E2@fmsmsx403.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: linux-ia64-admin-WygotPe7DYIabbyE177sbg@public.gmane.org
List-Help: <mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+JSyx/Wj9/Chdaaq/uiDbmg@public.gmane.org>
List-Post: <mailto:linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org>
List-Subscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+EfZv34bSr6CyrRgqdI+6y4@public.gmane.org>
List-Unsubscribe: <http://lists.linuxia64.org/lists/listinfo/linux-ia64>,
	<mailto:linux-ia64-request-WygotPe7DYL3TpFAQG+J+I4vVymAtk2CuCKOA6ERizqzQB+pC5nmwQ@public.gmane.org>
List-Archive: <http://lists.linuxia64.org/archives//linux-ia64/>
To: Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>, davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Cc: linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just downloaded linux-2.5.67 and the linux-2.5.67-ia64-030411.diff
patch
and built the kernel, and for a config that was booting with
linux-2.5.64=20
I now get the same errors reported below on the initial PCI
configuration.

This is on a tiger4 with 1 Itanium-2 900MHz processor. The same system
does
boot properly with RH AS 2.1 with the latest patches.

So it does appear that something bad did happen to the ACPI config
support=20
for this new cut. For now, back to linux-2.5.64.

Thanks,
Dave Howell=20

These are my opinions and not official opinions of Intel Corp.

David Howell
Intel Corporation
Telco Server Development
Server Products Division
Voice: (803) 461-6112  Fax: (803) 461-6292

Intel Corporation
Columbia Design Center, CBA-2
250 Berryhill Road, Suite 100
Columbia, SC 29210

david.p.howell-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org


-----Original Message-----
From: Takayoshi Kochi [mailto:kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org]=20
Sent: Monday, April 14, 2003 8:55 AM
To: davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org
Cc: linux-ia64-WygotPe7DYIabbyE177sbg@public.gmane.org; greg@kroah.com;
acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [Linux-ia64] kernel update (relative to v2.5.67)

[Added Cc: to Greg KH and acpi-devel list]

From: David Mosberger <davidm-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>
Subject: [Linux-ia64] kernel update (relative to v2.5.67)
Date: Fri, 11 Apr 2003 21:28:29 -0700
Message-ID: <200304120428.h3C4STTw004554-o/PNRNCSakrWxDs0y9d3MAC/G2K4zDHf@public.gmane.org>

> This kernel was tested on various zx1-based machines and the HP Ski
> simulator.  I also tried it on a Big Sur, but it failed with ACPI
> errors (attached below).  Perhaps someone who actually understands
> ACPI could look into this?  It's also possible that the firmware on my
> Big Sur is too old.  So before digging into this too deep, you may
> want to make sure you have the latest firmware installed.

<snip>=20

> ACPI: Subsystem revision 20030328
>     ACPI-0341: *** Error: Handler for [PCI_Config] returned AE_ERROR
>     ACPI-1121: *** Error: Method execution failed [\_SB_.CBN_._BBN]
(Node e000000005340900), AE_ERROR
>     ACPI-0098: *** Error: Method execution failed [\_SB_.CBN_._BBN]
(Node e000000005340900), AE_ERROR
> kernel unaligned access to 0x000000000000059d, ip=3D0xe0000000048a9821
>     ACPI-0341: *** Error: Handler for [PCI_Config] returned AE_ERROR
>     ACPI-1121: *** Error: Method execution failed [\PLAT] (Node
e00000003f22f840), AE_AML_NO_RETURN_VALUE
>     ACPI-1121: *** Error: Method execution failed [\_SB_.PCI2._STA]
(Node e000000005347e00), AE_AML_NO_RETURN_VALUE

It seems that newly integrated PCI segment support is incomplete.

In acpi/osl.c, it does PCI configuration space access like:

  struct pci_bus bus;
  ..
  bus.number =3D __bus_number_to_access__;
  pci_root_ops->write(&bus, ...);

But the ia64 dependent pci_root_ops uses &bus->sysdata to know
which PCI segment to access:(

I also noticed that in acpi/pci_root.c, _SEG is detected but
ignored;)  So segment support is now meanless (though it's easy
to remove these two lines).

	case AE_OK:
		root->id.segment =3D (u16) value;
		printk("_SEG exists! Unsupported. Abort.\n");	<=3D !!!!!
		BUG();						<=3D !!!!!
		break;


To make things worse, ia64 2.5 tree has a dependency loop in
PCI config space initialization.

  1. To access PCI config space, we need in-kernel PCI tree
  2. To construct the PCI tree, we need ACPI namespace to
     detect PCI root bridges
  3. To check whether a PCI root bridge exists, we have to
     execute _STA method
  4. Often _STA method is implemented using PCI config
     space access, so we need to access the config space
  5. To access PCI config space, ...

To resolve this problem,

 a) blindly probe bus 0 - 255, as we did in early days before
    ACPI initialization
 b) resurrect pci_config_read/write functions so that we can access
    pci config space (with segment specified) regardless of in-kernel
    PCI tree
 c) add #ifdef CONFIG_IA64 to acpi/osl.c to make a fake sysdata
    to specify segment
 d) other (any good ideas?)

I think b) is the most straightforward way to solve the situation,
but as it's once removed, it will be hard to persuade everyone;)

And currently segment support is only implemented on ia64
(using bus->sysdata) which seems ad hoc and is not implemented
on i386.  This is also a problem, though it's not so urgent.

Thanks,
---
Takayoshi Kochi <kochi-PTg2hmCz6mgYz5ZhgtY7qeqrae++aQT8@public.gmane.org>

_______________________________________________
Linux-IA64 mailing list
Linux-IA64-WygotPe7DYIabbyE177sbg@public.gmane.org
http://lists.linuxia64.org/lists/listinfo/linux-ia64
