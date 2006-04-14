From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Power-button event after resume from S3
Date: Fri, 14 Apr 2006 11:29:15 +0200
Message-ID: <200604141129.17043.rjw@sisk.pl>
References: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk> <1144938518.1936.8.camel@localhost.localdomain> <200604141533.40747.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53376 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965118AbWDNJab (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 05:30:31 -0400
In-Reply-To: <200604141533.40747.ncunningham@cyclades.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Felix Kuehling <fkuehlin@ati.com>, Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

Hi,

On Friday 14 April 2006 07:33, Nigel Cunningham wrote:
> On Friday 14 April 2006 00:28, Felix Kuehling wrote:
> > On Tue, 2006-11-04 at 14:14 +1000, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > On Tuesday 11 April 2006 12:35, Sanjoy Mahajan wrote:
> > > > >  if(acpi_during_suspend_resume)
> > > > >	don't generate power button event to confuse user space daemon
> > > >
> > > > This patch might be useful useful in setting and unsetting
> > > > acpi_during_suspend_resume (and also using it, but you should ignore
> > > > those as they are hacks for a different problem).  The equivalent
> > > > variable in the patch below is acpi_in_suspend.
> > >
> > > If you want this to get wider testing, I'll be happy to include it in the
> > > Suspend2 patchset.
> >
> > Just to clarify, software suspend is not affected by this problem. Only
> > S3, possibly S1 and maybe S4BIOS are affected, though I've never seen
> > the latter on any real system.
> 
> Thanks. I still think it would be worth including, because Suspend2 (and now 
> uswsusp, I believe) lets you choose what to do after writing the image. One 
> of the options is suspending to ram, so that you effectively get disk-backed 
> suspend to ram. It might be useful in this situation.

Yes we support suspend-to-disk-and-RAM now, so it may be useful to us too.

Greetings,
Rafael
