From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off aftersuspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 16:46:31 -0800
Message-ID: <200802211646.31603.jesse.barnes@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com> <200802211623.55450.jesse.barnes@intel.com> <b6a2187b0802211642i17730ccav6744b614c086df72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55736 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683AbYBVArK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 19:47:10 -0500
In-Reply-To: <b6a2187b0802211642i17730ccav6744b614c086df72@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Romano Giannetti <romano@dea.icai.upcomillas.es>, Linus Torvalds <torvalds@linux-foundation.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Thursday, February 21, 2008 4:42 pm Jeff Chua wrote:
> On Fri, Feb 22, 2008 at 8:23 AM, Jesse Barnes <jesse.barnes@intel.com> 
wrote:
> >  Your system (either your distro suspend/resume scripts or your platform)
> > must be running the video BIOS at resume time, otherwise it would
> > probably come back blank.
>
> But I don't think so, unless acpid is doing just that. In my
> suspend/resume event script, it's just doing a simple s2ram (without
> options), and exit after resume.

Your s2ram script is doing your STD also?  Seems counterintuitive.  Anyway, 
some machines also re-POST the GPU on resume from S3; maybe yours is doing 
that.

Jesse
