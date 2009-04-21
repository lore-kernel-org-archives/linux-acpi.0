From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: Disable _GTS and _BFS support by default
Date: Tue, 21 Apr 2009 08:55:49 +0800
Message-ID: <1240275349.3638.73.camel@localhost.localdomain>
References: <alpine.LFD.2.00.0904172349110.985@localhost.localdomain>
	 <200904201101.07693.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13458 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbZDUAyj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 20:54:39 -0400
In-Reply-To: <200904201101.07693.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "jm@lentin.co.uk" <jm@lentin.co.uk>

On Mon, 2009-04-20 at 17:01 +0800, Thomas Renninger wrote:
> On Saturday 18 April 2009 05:51:42 Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> > 
> > Executing BIOS code paths not exercised by Windows
> > tends to get Linux into trouble.
> Where do we know Windows does not use them?
> Is that confirmed by a Windows developer or has this been
> tried with KVM?
> For the latter, it could be that these are only called under
> certain circumstances.
It is tested by using KVM. And this is tested on windows XP/Vista.
IMO this should be consistent with the native windows.
> 
> > However, if a system does benefit from _GTS or _BFS,
> > acpi.gts=1 an acpi.bfs=1 are now available to enable them.
> If the systems works better it's probably a good idea to add
> that patch, I'd just like to know how sure we can be that
> Windows never calls these.
> 
> Thanks,
> 
>      Thomas
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13041
> 

