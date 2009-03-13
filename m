From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 18:06:46 +0000
Message-ID: <20090313180646.GA3171@srcf.ucam.org>
References: <20090312154741.GA1055@hygelac> <1236910092.2807.103.camel@rzhang-dt> <20090313030030.GA23571@srcf.ucam.org> <20090313173604.GB13342@hygelac> <20090313174726.GA2888@srcf.ucam.org> <20090313175812.GE13342@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59324 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZCMSGz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Mar 2009 14:06:55 -0400
Content-Disposition: inline
In-Reply-To: <20090313175812.GE13342@hygelac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, Mar 13, 2009 at 12:58:12PM -0500, Terence Ripperda wrote:
> On Fri, Mar 13, 2009 at 10:47:26AM -0700, mjg59@srcf.ucam.org wrote:
> > Yeah, this is the bit I don't understand. The design we've adopted for 
> > output switching ignores any BIOS provided information, and instead just 
> > enables outputs based on the user preferences. The X driver then has 
> > responsibility for performing the actual switch. Nouveau appears to be 
> > able to handle this on nvidia platforms without any problem. So, really, 
> > I guess I'm not clear on what functionality NVIF is intended to provide 
> > here. Is it impossible to enable outputs on some systems without it?
> 
> yes, this is what I mean by platform customizations. some notebook platforms
> will rely on the DCS/DGS methods to perform hotkeys, others will rely on other
> mechanisms, such as NVIF methods. I suspect you'll find that nouveau's mechanism
> will work on a lot of notebooks, but not work at all on other notebooks.

Can we make sure we're clear on terminology here? I'm using hotkey 
events to refer purely to the process by which the user hits a key, the 
firmware generates a notification, the kernel catches this notification 
and generates a KEY_SWITCHVIDEOMODE which we then catch in the user 
session.

There's then the issue of actually performing a display output change in 
response to this. This is curently handled by generating an xrandr 
request. The X driver (potentially in combination with the kernel 
driver, in a kernel modesetting world) then enables or disables outputs 
as appropriate.

The actual output changing is related to but not dependent upon the 
hotkey press, as the user may want to change output configuration via 
the graphical UI rather than by hitting the hotkey. So is the NVIF 
functionality required for generating the event in the first place, 
performing the actual output switch or simply providing the firmware's 
preferred set of enabled outputs?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
