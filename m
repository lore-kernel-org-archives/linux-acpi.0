From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/4] ACPI: video - fix oops when unloading module
Date: Sat, 29 Aug 2009 22:55:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908292255080.15619@localhost.localdomain>
References: <20090808072150.2980.3863.stgit@localhost.localdomain>
 <20090808075631.77F4F526EC9@mailhub.coreip.homeip.net>
 <1249867875.2670.529.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:42233 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbZH3Czx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Aug 2009 22:55:53 -0400
Received: from localhost.localdomain ([64.140.212.33])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KP600ETI5H6NWE8@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 29 Aug 2009 21:55:55 -0500 (CDT)
In-reply-to: <1249867875.2670.529.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 10 Aug 2009, Zhang Rui wrote:

> On Sat, 2009-08-08 at 15:26 +0800, Dmitry Torokhov wrote:
> > Don't assume that backlight is always present.
> > 
> Patch is already available.
> http://patchwork.kernel.org/patch/39704/

it is upstream now:


commit e29b3ee3b005897fbdcfdd4b3190776e38739d70
Author: Keith Packard <keithp@keithp.com>
Date:   Thu Aug 6 15:57:54 2009 -0700

    ACPI: don't free non-existent backlight in acpi video module

