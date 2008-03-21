From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH  1/16][BUG] Export kobject_rename for pci_hotplug_core
	(Not for mainline!)
Date: Fri, 21 Mar 2008 09:15:32 -0700
Message-ID: <20080321161532.GA2349@suse.de>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E334E2.6060306@jp.fujitsu.com> <20080321155605.GE17292@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:36297 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749AbYCUQnQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Mar 2008 12:43:16 -0400
Content-Disposition: inline
In-Reply-To: <20080321155605.GE17292@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew

On Fri, Mar 21, 2008 at 09:56:05AM -0600, Alex Chiang wrote:
> Hi Greg,
> 
> This patch looks like a candidate for the current 2.6.25 cycle.
> Any chance of getting it in there?

Is this a problem today?  I don't see it being one, so when you need
this function exported, we can do it then.  Otherwise people will just
start sending me patches unexporting it as they don't see any in-kernel
users of it :)

So just keep it as part of your patchset, it's easier for everyone that
way.

And it will remind me to verify that you really should be calling
kobject_rename and not just getting the name correctly the first time
around...{hint}

thanks,

greg k-h
