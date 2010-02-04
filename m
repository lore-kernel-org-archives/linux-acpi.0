From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v1 0/7] PCI: try enabling "pci=use_crs" again
Date: Wed, 03 Feb 2010 22:37:43 -0600
Message-ID: <4B6A4F17.2080806@lwfinger.net>
References: <20100203233617.10803.92102.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:64090 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756182Ab0BDEhq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2010 23:37:46 -0500
In-Reply-To: <20100203233617.10803.92102.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org, Peter Haight <peterh@sapros.com>, Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>

On 02/03/2010 05:38 PM, Bjorn Helgaas wrote:
> Historically, Linux has assumed a single PCI host bridge, with that bridge
> claiming all the address space left after RAM and legacy devices are taken out.
> 
> If the system contains multiple host bridges, we can no longer operate under
> that assumption.  We have to know what parts of the address space are claimed
> by each bridge so that when we assign resources to a PCI device, we take them
> from a range claimed by the upstream host bridge.
> 
> We use ACPI to enumerate all the PCI host bridges in the system, and part of
> the host bridge description is the "_CRS" (current resource settings" property,
> which lists the address space used by the bridge.  On x86, we currently ignore
> most of the _CRS information.  This patch series changes this, so we will use
> _CRS to learn about the host bridge windows.
> 
> Since most x86 machines with multiple host bridges are relatively new, this
> series only turns this on for machines with BIOS dates of 2010 or newer and for
> a few machines that we know need it.
> 
> These apply on 0148b041be4e7, which is the current head of the linux-next
> branch of Jesse's pci-2.6 git tree.  The first patch is just Jeff Garrett's
> patch to remove intel_bus.c, so that is only here for people who want to test
> the rest of the patches.  I expect Jesse will pick up Jeff's patch via Linus'
> tree.
> 
> Gary and Peter have some of these problem machines, so I'm hoping they can give
> this a whirl.
> 
> Larry, you reported the problem the last time I tried to turn on "pci=use_crs"
> by default.  This series shouldn't affect your machine because it's not in the
> whitelist, but I expect that if you boot the current kernel with "pci=use_crs",
> it should still fail, and if you boot with these patches and "pci=use_crs", it
> *should* work.  I know it's a lot to ask, but it'd be great if you had a chance
> to try that.

On my system, "git describe" returns v2.6.33-rc6-146-gc80d292. Patch 1 does not
apply and can be reverted. That is not a problem, but beginning with patch 5,
these do not apply.

In addition to the above, my system now boots with "pci=use_crs", unlike when I
filed the Bugzilla.

What kernel should I be running to test these patches?

Larry
