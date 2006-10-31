From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc3-mm1 - udev doesn't work (was: ATI SATA controller not detected)
Date: Tue, 31 Oct 2006 08:29:28 +0100
Message-ID: <200610310829.31554.rjw@sisk.pl>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <200610302148.34218.rjw@sisk.pl> <20061030205742.GA4084@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:64927 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422905AbWJaHbE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Oct 2006 02:31:04 -0500
In-Reply-To: <20061030205742.GA4084@kroah.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

[Resending due to a network problem on my side.]

On Monday, 30 October 2006 21:57, Greg KH wrote:
> On Mon, Oct 30, 2006 at 09:48:33PM +0100, Rafael J. Wysocki wrote:
> > On Monday, 30 October 2006 21:22, Greg KH wrote:
> > > On Mon, Oct 30, 2006 at 09:15:37PM +0100, Rafael J. Wysocki wrote:
> > > > Sorry, I was wrong.
> > > > 
> > > > The controller _is_ detected and handled properly, but udev is apparently
> > > > unable to create the special device files for SATA drives/partitions even
> > > > though CONFIG_SYSFS_DEPRECATED is set.
> > > 
> > > This config option should not affect the block device sysfs files at all
> > > at this point in time.
> > > 
> > > What does 'tree /sys/block/' show?
> > 
> > I can't run 'tree', but 'ls' works somehow (can't mount the root fs).  The
> > block device sysfs files seem to be present
> 
> If they are there, then udev should work just fine.
> 
> > > If the files show up there properly, udev should handle them just fine.
> > 
> > It doesn't.
> > 
> > Well, I can binary search for the offending patch if that helps.
> 
> That would be very helpful, thanks.

It's one of these:

git-acpi.patch
git-acpi-fixup.patch
git-acpi-more-build-fixes.patch

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
