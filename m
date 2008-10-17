From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend/resume regression between 2.6.26 and 2.6.27-rc1
Date: Fri, 17 Oct 2008 14:05:45 +0200
Message-ID: <200810171405.46523.rjw@sisk.pl>
References: <1223625973.2735.142.camel@rzhang-dt> <200810161621.54864.rjw@sisk.pl> <1224206865.3944.141.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:35099 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbYJQMBZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Oct 2008 08:01:25 -0400
In-Reply-To: <1224206865.3944.141.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, mingo@elte.hu

On Friday, 17 of October 2008, Zhao Yakui wrote:
> On Thu, 2008-10-16 at 16:21 +0200, Rafael J. Wysocki wrote:
> > On Thursday, 16 of October 2008, Zhao Yakui wrote:
> > > On Fri, 2008-10-10 at 14:41 +0200, Rafael J. Wysocki wrote:
> 
> > > 
> > >   The patches between the above two commits are related with X86. When
> > > using git-bisect between the above two commits, we will get the
> > > compiling errors(For example: some files don't exist) or the kernel
> > > panic. So we can't continue using git-bisect to identify which commit
> > > the regression is caused by.
> > 
> > If you test SMP kernels on a non-SMP box, that may be
> > http://bugzilla.kernel.org/show_bug.cgi?id=11568.  In which case, please test
> > the patch from http://bugzilla.kernel.org/show_bug.cgi?id=11568#c46 .
> > 
> Thanks for so quick response. The smp kernel is tested on the non-SMP
> box.
> After applying the patch in
> http://bugzilla.kernel.org/show_bug.cgi?id=11568#c46, 
> the box can be resumed very well on the latest kernel.

Thanks for testing.

The patch has been posted for mainline inclusion:
http://marc.info/?l=linux-kernel&m=122419938208201&w=4

Thanks,
Rafael
