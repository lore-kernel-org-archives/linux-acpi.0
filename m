From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: Disable _GTS and _BFS support by default
Date: Mon, 20 Apr 2009 11:01:06 +0200
Message-ID: <200904201101.07693.trenn@suse.de>
References: <alpine.LFD.2.00.0904172349110.985@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52118 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbZDTJBK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Apr 2009 05:01:10 -0400
In-Reply-To: <alpine.LFD.2.00.0904172349110.985@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, jm@lentin.co.uk, yakui.zhao@intel.com

On Saturday 18 April 2009 05:51:42 Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Executing BIOS code paths not exercised by Windows
> tends to get Linux into trouble.
Where do we know Windows does not use them?
Is that confirmed by a Windows developer or has this been
tried with KVM?
For the latter, it could be that these are only called under
certain circumstances.

> However, if a system does benefit from _GTS or _BFS,
> acpi.gts=1 an acpi.bfs=1 are now available to enable them.
If the systems works better it's probably a good idea to add
that patch, I'd just like to know how sure we can be that
Windows never calls these.

Thanks,

     Thomas

> http://bugzilla.kernel.org/show_bug.cgi?id=13041

