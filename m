From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Thu, 23 Apr 2009 15:50:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
 <20090423164642.GF495@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57960 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZDWTux (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 15:50:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIK003TVKGK2UCQ@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 14:50:45 -0500 (CDT)
In-reply-to: <20090423164642.GF495@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, rui.zhang@intel.com, Keith Packard <keithp@keithp.com>, linux-acpi@vger.kernel.org




On Thu, 23 Apr 2009, Norbert Preining wrote:

> On Do, 23 Apr 2009, Len Brown wrote:
> > I thought we had addressed this, no?
> 
> The last I have seen are the two patches by  Zhao Yakui in the emails
> subject: 
> 	ACPI: Weaken the dependency between ACPI video driver and I915
> and
> 	ACPI: Check whether the acpi video is deferrable only when KMS is enabled
> 
> > CONFIG_DRM_I915=y
> > CONFIG_ACPI_VIDEO=m
> > 
> > drivers/built-in.o: In function `intel_opregion_init':
> > (.text+0x9d540): undefined reference to `acpi_video_register'
> 
> For me these two patches fix the problem.

Matthew's response to those patches seems to be sufficient:

http://patchwork.kernel.org/patch/18420/

thanks,
Len Brown, Intel Open Source Technology Center

