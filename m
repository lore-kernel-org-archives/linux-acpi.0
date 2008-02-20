From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk.
 Screen becomes green.
Date: Wed, 20 Feb 2008 13:47:18 -0500
Message-ID: <47BC75B6.7000509@rtr.ca>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2647 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759460AbYBTSrU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Feb 2008 13:47:20 -0500
In-Reply-To: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jesse Barnes <jesse.barnes@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

Jeff Chua wrote:
> 
> 
> On Feb 20, 2008 2:19 PM, Jeff Chua
>> I'll try the "idle=poll" to see if that works and will try some printk
> 
> I don't know what exactly the i915_suspend() and i915_resume() are 
> supposed to do because it works better without them.
> 
> After inserting "return 0;" right at the top of those two functions, 
> suspend (and power-off properly), and resume (without green screen) 
> works just fine.
..

Does this machine have more than one CPU core?  If so..
Does your kernel have CONFIG_HOTPLUG_CPU=y (if not, enable it).

??
