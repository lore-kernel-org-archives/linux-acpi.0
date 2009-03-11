From: Mattia Dongili <malattia@linux.it>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics
	(Intel and Nvidia)
Date: Wed, 11 Mar 2009 22:08:47 +0900
Message-ID: <20090311130847.GC13101@kamineko.org>
References: <1236739527.2820.178.camel@rzhang-dt> <20090311024652.GA14493@srcf.ucam.org> <1236756550.2820.218.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:55746
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbZCKNIw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2009 09:08:52 -0400
Content-Disposition: inline
In-Reply-To: <1236756550.2820.218.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, Mar 11, 2009 at 03:29:10PM +0800, Zhang Rui wrote:
> On Wed, 2009-03-11 at 10:46 +0800, Matthew Garrett wrote:
> > On Wed, Mar 11, 2009 at 10:45:27AM +0800, Zhang Rui wrote:
> > 
> > > The problem can be fixed by disabling Nvidia card via ACPI _DSM method.
> > > And it seems that there are some works already done for this issue.
> > > http://archive.netbsd.se/?ml=xorg&a=2009-02&t=9908058
> > 
> > This method is specific to Sony. What would be most helpful here would 
> > be for Intel to tell us how this is actually meant to work. 
> > 
> Well, the change in sony-laptop driver is a new feature rather than a
> bug fix.
> the new sony-laptop driver introduces a new sysfs I/F:
> /sys/devices/platform/sony-laptop/speed_stamina
> and users can echo {speed, stamina} to this file to switch between
> Intel and Nvidia graphics card.

and see their Xorg miserably die. ;)

Jokes aside, I have no big problem incorporating the differences in the
driver, just that:
- I can't test it
- some models have different magic numbers for the _DSM invocation, from
  the DSDT I have available:
	DSDT.sz.xxx.dsl (some uknown model)
	DSDT.sz61mn-forXP.dsl
	DSDT.tt11lnb.dsl
	DSDT.z11vn.dsl
	DSDT.z90s.dsl
	VGN-SZ4XWNC-R0111N0.dsl
  and for what I can see, z and tt have the same magic numbers while the
  sz has different ones. So the code that calls _DSM will need to have
  some DMI switch to make sure we are calling it with the right
  parameters (for now supporting z and tt might be enough)

I'll see what I can do (I accept patches in case someone feels like
doing it)
-- 
mattia
:wq!
