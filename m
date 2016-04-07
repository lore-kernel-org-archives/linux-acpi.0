From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 01/14] x86/boot: enumerate documentation for the x86
 hardware_subarch
Date: Fri, 8 Apr 2016 00:36:35 +0200
Message-ID: <20160407223635.GJ1990@wotan.suse.de>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-2-git-send-email-mcgrof@kernel.org>
 <1460028338.6620.19.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39955 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756165AbcDGWgh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Apr 2016 18:36:37 -0400
Content-Disposition: inline
In-Reply-To: <1460028338.6620.19.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, kozerkov@parallels.com

On Thu, Apr 07, 2016 at 02:25:38PM +0300, Andy Shevchenko wrote:
> On Wed, 2016-04-06 at 17:06 -0700, Luis R. Rodriguez wrote:
> > Although hardware_subarch has been in place since the x86 boot
> > protocol 2.07 it hasn't been used much. Enumerate current possible
> > values to avoid misuses and help with semantics later at boot
> > time should this be used further.
> >=20
> > These enums should only ever be used by architecture x86 code,
> > and all that code should be well contained and compartamentalized,
> > clarify that as well.
>=20
> Nitpick:
>=20
> > + * @X86_SUBARCH_PC: Should be used if the hardware is enumerable
> > using standard
> > + *	PC mechanisms (PCI, ACPI) and doesn't need a special boot
> > flow.
> > + * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest
> > + * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV
> > boot path,
> > + *=A0	which start at asm startup_xen() entry point and later
> > jump to the C
> > + *=A0	xen_start_kernel() entry point.
> > + * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet
> > Device) platform
> > + *	systems which do not have the PCI legacy interfaces.
> > + * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100)
> > SOC for
>=20
> I think 'SoC' (without quotes) will be better.

Amended, since I think I'll need a re-spin and since we may need to tak=
e
care of the dom0 Vs domU semantics I'll also make some changes to inclu=
de
X86_SUBARCH_XEN documentation to annotate that PV guests can be of domU
or dom0 type...

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
