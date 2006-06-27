From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Tue, 27 Jun 2006 03:37:06 -0400
Message-ID: <20060627073704.GD3438@neo.rr.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com> <20060627000324.b9457fb4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpe-71-64-120-181.neo.res.rr.com ([71.64.120.181]:701 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S1030734AbWF0HUD
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:03 -0400
Content-Disposition: inline
In-Reply-To: <20060627000324.b9457fb4.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, castet.matthieu@free.fr, bjorn.helgaas@hp.com, uwe.bugla@gmx.de, shaohua.li@intel.com

On Tue, Jun 27, 2006 at 12:03:24AM -0700, Andrew Morton wrote:
> On Tue, 27 Jun 2006 02:30:13 -0400
> "Brown, Len" <len.brown@intel.com> wrote:
> 
> > NAK, per Shaohua's comments in the bug report. 
> > 
> > ...
> >
> > >
> > >This patch fixes bug 6292 
> > >(http://bugzilla.kernel.org/show_bug.cgi?id=6292).
> 
> Sigh.  Uwe is available to test patches, should any happen to get written.

I think we want something like this one...

http://bugzilla.kernel.org/attachment.cgi?id=7931&action=view

Regarding the bug report: Shaohua, if I understand correctly, we used to
blacklist PCI root buses in the old implementation but it was changed here:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c4bb6f5ad968540d7f9619565bacd18d7419b85f

Thanks,
Adam
