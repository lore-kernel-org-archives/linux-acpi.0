From: Len Brown <lenb@kernel.org>
Subject: RE: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external
 control operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 12:29:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907301204260.17818@localhost.localdomain>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com>
 <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com>
 <4D05DB80B95B23498C72C700BD6C2E0B315D671A@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:32452 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZG3Q3b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 12:29:31 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KNL00FILSGP4PA0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 30 Jul 2009 11:29:19 -0500 (CDT)
In-reply-to: <4D05DB80B95B23498C72C700BD6C2E0B315D671A@pdsmsx502.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Ke" <ke.yu@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>, "Tian, Kevin" <kevin.tian@intel.com>

Unclear that the power management partitioning between xen hypervisor
and dom0 is fully baked.

Uncear (to me) what xen is doing internally with these power management 
objects, and how that differs from what Linux would do.

While patches to the Linux kernel may be a good RFE, prototype, or base
for discussion, the unknowns above need to be addressed to before it
makes much sense to spent a large amount of time on the source.

some things did jump out of the patch, however...

I do not recommend believing _PSD.
Our experience is that 50% of the time it is crap.

Why does xen_processor_px exists when it is the same as acpi_processor_px?
ditto for acpi_processor_cx and xen_processor_cx

Lose the ifdefs.
Lose the tests for xen on the inline code when
they can be inside the called routines.

This doesn't look like an abstraction layer,
it looks more like a simple conduit.
The thing at the other end (xen) will need to know
just as much about these data structures as the
thing that sent them (linux)

the patch doesn't apply to the upstream kernel --
even the ACPI specific parts.

checkpatch.pl:
total: 168 errors, 42 warnings, 643 lines checked

Don't send me another patch that can't pass checkpatch.pl,
even if just an RFC.

thanks,
Len Brown, Intel Open Source Technology Center

