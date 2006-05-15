From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Output ACPI info via sysfs
Date: Mon, 15 May 2006 12:36:25 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4492F11@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:56252 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964943AbWEOTlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2006 15:41:25 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Jones <pjones@redhat.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>



> Doing this probe in userland means
> we've got two sets of code to parse the same thing, which pretty much
> always leads to bug fixes that fail to be applied to both sets of
code.
> So that means I've essentially got to track changes to what the kernel
> parsing code (or some library-ized version of pmtools) in order to get
> bug fixes.  This is a maintenance nightmare!

If nothing else, this is why even user code that pokes around with the
ACPI tables should be using the ACPICA code, which works anywhere.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Peter Jones
> Sent: Monday, May 15, 2006 11:38 AM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; Prarit Bhargava
> Subject: RE: Output ACPI info via sysfs
> 
> On Sat, 2006-05-13 at 00:17 -0400, Brown, Len wrote:
> >  >Anaconda can't determine the number of CPUs or sockets actually
> present
> > >(in use or not, enabled or disabled) in a system, which we
> > >need to do in
> > >order to determine what kernel we should install.
> >
> > do you care about logical processors only,
> > or do you also care if the processors are HT or multi-core
> > in the same package?
> 
> For this case, I only really care about logical processors.  It'd be
> *nice* if the full topology were available, but it's not required
here.
> 
> >
> > >On x86_64 in RHEL, installation uses the default kernel, which is
> > >compiled with support for 16 CPUs.  We can't change that because
> > >changing CONFIG_NR_CPUS changes the module ABI, and breaks
> > >modules built
> > >by our ISVs.  But on systems with more CPUs than that, our users
are ok
> > >with us breaking that ABI to use more CPUs, as long as it does not
> > >effect systems with 16 or fewer processors.  So we need to probe
the
> > >number of processors and install the appropriate kernel.
> > >
> > >I've got code to read the ACPI tables from userland right now, but
it
> > >isn't terribly reliable.  Some systems lock up if you read the
tables
> > >while X is running, and some systems sometimes give erroneous data.
In
> > >both cases, it seems the earlier you read the tables the better,
and of
> > >course the kernel reads them while it's still only got 1 CPU
running,
> > >which is the best possible case.  The kernel hasn't triggered
> > >any of the
> > >failures we've seen, and since it already has to read the tables,
this
> > >would be the best place for userland to get that data.
> >
> > This makes zero sense to me.
> > Except for very very large systems the enumerate the processors in
the
> > DSDT
> > (eg altix with > 256),
> > the processors are enumerated in the MADT, which is completely
static.
> 
> Yeah, that's what I'd expect as well.
> 
> > In no way should dumping
> > it and parsing it in user-space have any effect on the integrity
> > of the system.
> 
> So I've seen it produce less than positive results on machines from 3
> vendors.  2 of the vendors are shipping one particular (rather old)
> video card, which seems to be a supporting condition of the failure.
On
> these machines, reading the ACPI tables while running X on the
currently
> active virtual terminal causes a hard lockup.  Both of those vendors
are
> shipping exactly the same video card, but I've seen machines with that
> card that didn't fail as well.
> 
> The other vendor's hardware _sometimes_ has bad data in the XSDT if
> you've got more than 1G of ram, and I've now got workarounds in my
> parser for it -- but the kernel doesn't have those, and it works just
> fine.  Dunno why this is happening, but the BIOS guys at that vendor
are
> looking into it.  Just FWIW, acpidump has the same failure as the code
> I've got (both were hacked up from the kernel code) -- on my 4G box it
> tries to read 4026571728 bytes at 0x2b858abbd0 , which is clearly
bogus.
> But when the kernel is parsing the tables, it's getting the right
data.
> I really have no idea what's happening on that hardware.  I suspect a
> bus analyzer is needed to tell for sure what's going on.
> 
> > in pmtools, acpidump does this, and the madt utility below --
> > a rip-off of the kernel parsing code -- looks at it:
> >
> > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> >
> > There is no reason you couldn't combine them into a single
> > utility to answer the question that you are asking.
> > It requires 0 kernel support, and doesn't even require
> > running in ACPI mode.
> 
> Yeah, this is basically what I did (but before I knew you'd written
this
> utility).  I still don't think it's the best idea -- poking around
> in /dev/mem is ugly and bug-prone.  Doing this probe in userland means
> we've got two sets of code to parse the same thing, which pretty much
> always leads to bug fixes that fail to be applied to both sets of
code.
> So that means I've essentially got to track changes to what the kernel
> parsing code (or some library-ized version of pmtools) in order to get
> bug fixes.  This is a maintenance nightmare!
> 
> --
>   Peter
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
