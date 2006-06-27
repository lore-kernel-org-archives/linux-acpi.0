From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Tue, 27 Jun 2006 15:29:50 +0800
Message-ID: <1151393390.21189.59.camel@sli10-desk.sh.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <20060627000324.b9457fb4.akpm@osdl.org>  <20060627073704.GD3438@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:7691 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161025AbWF0HcL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 03:32:11 -0400
In-Reply-To: <20060627073704.GD3438@neo.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, castet.matthieu@free.fr, bjorn.helgaas@hp.com, uwe.bugla@gmx.de

On Tue, 2006-06-27 at 15:37 +0800, Adam Belay wrote:
> On Tue, Jun 27, 2006 at 12:03:24AM -0700, Andrew Morton wrote: 
> > On Tue, 27 Jun 2006 02:30:13 -0400 
> > "Brown, Len" <len.brown@intel.com> wrote: 
> >  
> > > NAK, per Shaohua's comments in the bug report.  
> > >  
> > > ... 
> > > 
> > > > 
> > > >This patch fixes bug 6292  
> > > >(http://bugzilla.kernel.org/show_bug.cgi?id=6292). 
> >  
> > Sigh.  Uwe is available to test patches, should any happen to get
> written.
> 
> I think we want something like this one...
> 
> http://bugzilla.kernel.org/attachment.cgi?id=7931&action=view
Exactly.

> Regarding the bug report: Shaohua, if I understand correctly, we used
> to 
> blacklist PCI root buses in the old implementation but it was changed
> here:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c4bb6f5ad968540d7f9619565bacd18d7419b85f
Thanks and sorry I didn't find the issue before. We'd better blacklist
root bridge. I saw at lest one BIOS (IA64 box) didn't assign correct
producer/consumer flag to root bridge resources. Blacklist it is much
safer.

Thanks,
Shaohua
