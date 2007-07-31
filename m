From: Doug Chapman <doug.chapman@hp.com>
Subject: RE: regression on HP zx1 platform from ACPI autoload modulespatches
Date: Tue, 31 Jul 2007 12:59:56 -0400
Message-ID: <1185901196.4478.16.camel@deimos.americas.hpqcorp.net>
References: <617E1C2C70743745A92448908E030B2A020E3AD2@scsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:38540 "EHLO atlrel7.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbXGaRD1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2007 13:03:27 -0400
In-Reply-To: <617E1C2C70743745A92448908E030B2A020E3AD2@scsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Tony Luck <tony.luck@gmail.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, trenn@suse.de

On Tue, 2007-07-31 at 09:29 -0700, Luck, Tony wrote:
> > commit 8c8eb78f673c07b60f31751e1e47ac367c60c6b7
> 
> Oops.  I cut & pasted the wrong commit id.  The fix went in as
> commit 7091138fb762aed22317b4ff91eb211e7da3865c.
> 
> > FYI, I did a git pull yesterday just before I hit this issue so I should
> > have had the latest stuff.
> 
> So this confuses me.  Linus pulled this into his tree on Friday (IIRC), but
> at the very latest on Saturday (as there is a commit *after* this one that
> is dated 2007-07-28 19:29:37).
> 
> The patch that is in the tree appears to be identical to the one that
> Thomas Renninger posted to this thread, and you confirmed as working.
> 
> So when you have a moment, please pull latest Linus tree.  Confirm that
> this patch is present:
>  $ grep hp_ioc_iommu_device_ids arch/ia64/hp/common/sba_iommu.c
>  static const struct acpi_device_id hp_ioc_iommu_device_ids[] = {
>  	.ids		= hp_ioc_iommu_device_ids,
>  $
> 
> and that it builds and boots for you.
> 
> Thanks
> 
> -Tony
>  

Tony, all,

I think I have solved the mystery.  I have my git tree pointing to
git.frob.com to try to lessen the load on kernel.org.  I am guessing
that the last time I pulled linus's tree from there they had not pulled
since the commit was made so I was still a little out of date.

The latest git pull now does indeed grab this commit.

sorry for any confusion I may have caused.

- Doug


