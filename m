From: Alistair John Strachan <s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Date: Thu, 5 Feb 2004 21:30:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402052130.30344.s0348365@sms.ed.ac.uk>
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk> <4022505B.1020900@vision.ee>
Reply-To: s0348365-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4022505B.1020900-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar-w3PkqIkA8A2zQB+pC5nmwQ@public.gmane.org>, Arjen Verweij <A.Verweij2-V356GuK0og6dIhEUFHOBvg@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Luis Miguel =?iso-8859-1?q?Garc=EDa?= <ktech-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 05 February 2004 14:16, you wrote:
> Alistair John Strachan wrote:
> >On Thursday 05 February 2004 09:44, Andrew Morton wrote:
> >
> >
> >Still doesn't boot on my nForce 2 system, hangs while probing PDC RAID
> > card. Confirmed from 2.6.2-rc3-mm1 that it was likely related to ACPI
> > changes, but reverting bk-acpi.patch makes no difference.
> >
> >I'd like to test mainline, but I'm using gcc 3.4 snapshot, so I'll try
> > later today with 2.6.2 + linus.patch.
>
> Same here, hangs probing hpt366 ide controller. After some time says:
>
> hde: lost interrupt
>
> boots ok with pci=noacpi
>
> Lenar

This fix doesn't work for me because I get problems if I disable ACPI IRQ 
routing and still have apic enabled. Normally these problems would be 
gracefully solved, but my USB HCD complains about not having been assigned an 
IRQ.

This ACPI problem is definitely present in mainline, so this is a regression 
at least on my nForce 2.

If this is helpful, in 2.6.2-rc1-mm1 I would see:

..MPBIOS bug: 8254 timer not connected to IO-APIC.

This error seemed to be harmless and made no difference to the kernel while 
booting. It's been like that since latter 2.5 kernels, so that's quite a long 
time. The board is an EPoX 8RDA+ in case this is a vendor bug.

Now, instead, I see (in 2.6.2 and 2.6.2-mm1):

IOAPIC[0]: Invalid reference to IRQ 0

Later my kernel hangs when detecting hde, as described in another thread.
pci=noacpi allows me to get to init, but it breaks my USB HCD.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
