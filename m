From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [Intel-gfx] [RFC] i915/acpi: add lid status notification and
	detection
Date: Thu, 11 Jun 2009 15:16:27 +0800
Message-ID: <1244704587.3616.109.camel@localhost.localdomain>
References: <20090513115734.338b7d55@jbarnes-g45>
	 <1242264144.3773.415.camel@localhost.localdomain>
	 <20090519171545.GA17801@srcf.ucam.org>
	 <1242896273.32574.10.camel@rzhang-dt> <20090521093418.3f1a03d5@jbarnes-g45>
	 <4A15FE57.7040002@linux.intel.com>  <20090527015801.2f47089f@jbarnes-x200>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28803 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbZFKHPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2009 03:15:17 -0400
In-Reply-To: <20090527015801.2f47089f@jbarnes-x200>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Fu Michael <michael_fu@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "lenb@kernel.org" <lenb@kernel.org>

On Wed, 2009-05-27 at 16:58 +0800, Jesse Barnes wrote:
> > >   
> > Jesse, Just talked with Rui,  the above status is based on "BIOS
> > upgrade or FW fix is acceptable as a bug fix solution". are you ok
> > with this? :) Many lid status has to be fixed via action such as DSDT
> > upgrade...
> 
> Yeah, I think that's ok, even if we need quirks for some platforms.  I
> really hate relying on BIOS vendors/OEMs to provide BIOS updates in
> general:  if Windows works on a given platform, why should Linux
> require a BIOS "fix" on it?  In this case though, we can work around
> broken platforms by just returning "open" all the time, if it comes to
> that.
Hi, 
    It is a good point that the LID status is used to decide whether the
LVDS is connected or not.
    As Rui said in the previous thread, sometimes the initial status of
LID is incorrect on some laptops. If we expect that LVDS can be
initialized correctly on such boxes, we will have to add the quirk so
that the LID status is not used for LVDS detection.
   But maybe on such boxes the LID initial status is correct after BIOS
upgrading or using custom DSDT. Do we need to delete the quirk for such
box?  It is difficult to manage.
    
   So IMO we had better not use the LID status to determine whether the
LVDS is connected or not.
   Thanks.
> 
> Jesse
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/intel-gfx

