From: Len Brown <lenb@kernel.org>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 12:00:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907301139530.17818@localhost.localdomain>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
 <4D05DB80B95B23498C72C700BD6C2E0B315D65B6@pdsmsx502.ccr.corp.intel.com>
 <4A707DC1.9070708@goop.org>
 <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:33212 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbZG3QA5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 12:00:57 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KNL00FMZR56YPD3@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 30 Jul 2009 11:00:48 -0500 (CDT)
In-reply-to: <4D05DB80B95B23498C72C700BD6C2E0B315D6A67@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ke" <ke.yu@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

> >My understanding is that all that code is supposed to be
> >kernel-independent.  We could lift all that code as-is, write some new
> >kernel interface shims and shove it all into Xen.   But I don't know if
> >that solves any more problems than it causes.

Many have incorporated ACPICA into their OS, from BeOS to BSD, 
Solaris to Linux.  And I'm not going to tell you that you can't
do the same and make the xen hypervisor into an OS that knows
about both policy and the hardware it is running on.

However, ACPI != all the ACPI code in Linux.  ACPICA is the
stuff in the drivers/acpi/acpica directory, and nothing else
(asside from a few header files outside that directory)

Also, I'm not sure the OS you build will be competitive with
other OS's when you're done.

> >>> s/extcntl/xen/ to make it clear why this code exists --
> >>> or is there an expected "external control" other than Xen?
...
> >I don't think that's a good idea.  If we need to do that, then there's a
> >deeper design problem we need to address.  (And, if nothing else, people
> >have become hypersensitive to naked Xen-specific code references in
> >non-Xen files, and I'm tired of having those arguments.)
> 
> Can you explain what the deeper design problem is?

Obfuscating the code by calling a Xen-specific abstraction
"extcntl" instead of "xen" will not fly.

Jeremy's desire to create and use generic abstractions that have multliple 
users is a good thing.  It simply does not apply here.

I have no objection to having a xen-specific hook being called xen_*
To do otherwise would be a dis-service to future maintainers of the code.

thanks,
Len Brown, Intel Open Source Technology Center.




