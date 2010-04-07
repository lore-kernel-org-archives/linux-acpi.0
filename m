From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Make current GPE changes to be consistent with ACPICA code base
Date: Wed, 7 Apr 2010 21:15:19 +0200
Message-ID: <201004072115.20029.rjw@sisk.pl>
References: <1270537259.3384.50.camel@minggr.sh.intel.com> <1270604708.13547.1.camel@minggr.sh.intel.com> <1270606643.13547.3.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37369 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756245Ab0DGTMA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Apr 2010 15:12:00 -0400
In-Reply-To: <1270606643.13547.3.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wednesday 07 April 2010, Lin Ming wrote:
> On Wed, 2010-04-07 at 09:45 +0800, Lin Ming wrote:
> > On Wed, 2010-04-07 at 05:54 +0800, Rafael J. Wysocki wrote:
> > > On Tuesday 06 April 2010, Lin Ming wrote:
> > > > Hi, Rafael
> > > > 
> > > > Bob has ported the major GPE changes into ACPICA code base.
> > > > http://git.moblin.org/cgit.cgi/acpica/commit/?id=45f0b38a921f3b2af7574d553a6c2e557d0567ed
> > > > 
> > > > But Bob's port and your original patch have some differences, so I made
> > > > below patch to make linux acpica code consistent with ACPICA code base.
> > > > 
> > > > I have build and tested it, would you please help to review?
> > > > If everything is OK, I'll include it in the next linux acpica update and
> > > > send it to Len.
> > > 
> > > While I'm generally fine with the code, it looks like the $subject patch includes
> > > the patches I sent earlier (slightly reworked):
> > > https://patchwork.kernel.org/patch/90471/
> > > https://patchwork.kernel.org/patch/86237/
> > > 
> > > I'll appreciate it if there's a notice in the changelog that the patch is based
> > > on them.
> > 
> > We ported your code to ACPICA code base.
> > I'll add the changelog to notice that.
> > 
> > > 
> > > Also, please add my sign-off to the final submission to indicate that some
> > > changes in the patch are in fact from me.
> > 
> > Sure.
> 
> Hi, 
> 
> How about below one?

Works for me.

> >From d79bb1feba87a22dece4ee7cfc30a2965ab54e02 Mon Sep 17 00:00:00 2001
> From: Lin Ming <ming.m.lin@intel.com>
> Date: Tue, 6 Apr 2010 14:52:37 +0800
> Subject: [PATCH] Minimize the differences between linux GPE code and ACPICA code base
> 
> We have ported Rafael's major GPE changes
> (ACPI: Use GPE reference counting to support shared GPEs) into ACPICA code base.
> But the port and Rafael's original patch have some differences, so we made
> below patch to make linux GPE code consistent with ACPICA code base.
> 
> Most changes are about comments and coding styles.
> Other noticeable changes are based on:
> 
> Rafael: Reduce code duplication related to GPE lookup
> https://patchwork.kernel.org/patch/86237/
> 
> Rafeal: Always use the same lock for GPE locking
> https://patchwork.kernel.org/patch/90471/
> 
> A new field gpe_count in struct acpi_gpe_block_info to record the number
> of individual GPEs in block.
> 
> Rename acpi_ev_save_method_info to acpi_ev_match_gpe_method.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Robert Moore <robert.moore@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>

Thanks,
Rafael
