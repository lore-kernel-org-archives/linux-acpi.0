From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: Regression in 3.1 causes Xen to use wrong idle
 routine
Date: Mon, 14 Nov 2011 13:19:01 -0500
Message-ID: <20111114181901.GA14966@phenom.dumpdata.com>
References: <CAJvTdK=yAek4sJFXUp=kQSmnuE=HpgefN5Q-GLWhMXo=LhJ-2A@mail.gmail.com>
 <CAE5A7DE.24C94%keir.xen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:18621 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1KNSUD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2011 13:20:03 -0500
Content-Disposition: inline
In-Reply-To: <CAE5A7DE.24C94%keir.xen@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keir Fraser <keir.xen@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Stefan Bader <stefan.bader@canonical.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>

On Sun, Nov 13, 2011 at 04:59:10PM +0000, Keir Fraser wrote:
> On 13/11/2011 03:46, "Len Brown" <lenb@kernel.org> wrote:
> 
> >> The problem I see is that select_idle_routine() is called from
> >> arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
> >> anymore, it can cause mwait_idle or amd_e400_idle functions to be selected.
> >> In testing it seem amd_e400_idle in PVM domU at least does not immediately
> >> cause
> >> problems, but mwait_idle just causes crashes. From the reports I have
> >> this may be related to older hypervisors (3.1 and older) not clearing the
> >> mwait
> >> capability. But overall there seems something wrong in the interaction.
> > 
> > Why is Xen advertising X86_FEATURE_MWAIT and then crashing
> > when the dom0 (or other guests) use what it advertises?
> > 
> > What versions of Xen have this bug?
> 
> Xen doesn't advertise MWAIT. Possibly Xen-pv_ops is lying to the rest of the
> kernel via the cpuid pv_ops hook. This would probably be because Xen is

I can't seem to find anything in there advertising the MWAIT feature.

> relying on the OSPM in dom0 kernel to parse out Cx/Px info which Xen itself
> *can* use.

The Cx/Px patches that would parse the Cx/Px and then percolate those up
to the hypervisor are in mainline. So that is not it.
