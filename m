From: Felix Kuehling <fkuehlin@ati.com>
Subject: Re: Power-button event after resume from S3
Date: Thu, 13 Apr 2006 10:28:38 -0400
Message-ID: <1144938518.1936.8.camel@localhost.localdomain>
References: <E1FT8ip-00028X-00@skye.ra.phy.cam.ac.uk>
	 <200604111414.59650.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-res.frontbridge.com ([63.161.60.49]:62409 "EHLO
	outbound1-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S964950AbWDMO3D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 10:29:03 -0400
In-Reply-To: <200604111414.59650.ncunningham@cyclades.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org, Matthew Tippett <mtippett@ati.com>, Chang-Hwa Lee <changl@ati.com>, Samuel Li <samli@ati.com>

On Tue, 2006-11-04 at 14:14 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 11 April 2006 12:35, Sanjoy Mahajan wrote:
> > >  if(acpi_during_suspend_resume)
> > >	don't generate power button event to confuse user space daemon
> >
> > This patch might be useful useful in setting and unsetting
> > acpi_during_suspend_resume (and also using it, but you should ignore
> > those as they are hacks for a different problem).  The equivalent
> > variable in the patch below is acpi_in_suspend.
> 
> If you want this to get wider testing, I'll be happy to include it in the 
> Suspend2 patchset.

Just to clarify, software suspend is not affected by this problem. Only
S3, possibly S1 and maybe S4BIOS are affected, though I've never seen
the latter on any real system.

Regards,
  Felix

> 
> Regards,
> 
> Nigel


