From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics
	(Intel and Nvidia)
Date: Wed, 11 Mar 2009 15:29:10 +0800
Message-ID: <1236756550.2820.218.camel@rzhang-dt>
References: <1236739527.2820.178.camel@rzhang-dt>
	 <20090311024652.GA14493@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47266 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbZCKH2O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Mar 2009 03:28:14 -0400
In-Reply-To: <20090311024652.GA14493@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2009-03-11 at 10:46 +0800, Matthew Garrett wrote:
> On Wed, Mar 11, 2009 at 10:45:27AM +0800, Zhang Rui wrote:
> 
> > The problem can be fixed by disabling Nvidia card via ACPI _DSM method.
> > And it seems that there are some works already done for this issue.
> > http://archive.netbsd.se/?ml=xorg&a=2009-02&t=9908058
> 
> This method is specific to Sony. What would be most helpful here would 
> be for Intel to tell us how this is actually meant to work. 
> 
Well, the change in sony-laptop driver is a new feature rather than a
bug fix.
the new sony-laptop driver introduces a new sysfs I/F:
/sys/devices/platform/sony-laptop/speed_stamina
and users can echo {speed, stamina} to this file to switch between
Intel and Nvidia graphics card.

And the bug above happens to depend on this new feature, i.e. it needs
to disable/enable/disable the Nvidia card to get a working X.
please refer to https://bugs.freedesktop.org/show_bug.cgi?id=17508
comment #93.
About the reason why it helps in this issue, I don't know.
As this(disabling one graphics card) is usually done by BIOS, I guess it
may be the BIOS that doesn't disable Nvidia card cleanly.

thanks,
rui


