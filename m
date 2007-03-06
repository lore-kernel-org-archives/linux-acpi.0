From: Dave Jones <davej@redhat.com>
Subject: Re: backlight mystery
Date: Tue, 6 Mar 2007 12:10:50 -0500
Message-ID: <20070306171050.GE26813@redhat.com>
References: <20070305233037.0c5727e7.akpm@linux-foundation.org> <20070306074312.GC23955@redhat.com> <20070305234812.d8b2b08d.akpm@linux-foundation.org> <ac8af0be0703052358j281e9e4dn648fd61675255be4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965969AbXCFRLF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 12:11:05 -0500
Content-Disposition: inline
In-Reply-To: <ac8af0be0703052358j281e9e4dn648fd61675255be4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Purdie <rpurdie@rpsys.net>, linux-acpi@vger.kernel.org

On Tue, Mar 06, 2007 at 03:58:01PM +0800, Zhao Forrest wrote:
 > On 3/6/07, Andrew Morton <akpm@linux-foundation.org> wrote:
 > > On Tue, 6 Mar 2007 02:43:12 -0500 Dave Jones <davej@redhat.com> wrote:
 > >
 > > > On Mon, Mar 05, 2007 at 11:30:37PM -0800, Andrew Morton wrote:
 > > >  >
 > > >  > I always get stuff like this coming out when I boot my x86_64 machine:
 > > >  >
 > > >  > asus_acpi: Unknown symbol backlight_device_unregister
 > > >  > asus_acpi: Unknown symbol backlight_device_register
 > > >  > ibm_acpi: Unknown symbol backlight_device_unregister
 > > >  > ibm_acpi: Unknown symbol backlight_device_register
 > > >  > toshiba_acpi: Unknown symbol backlight_device_unregister
 > > >  > toshiba_acpi: Unknown symbol backlight_device_register
 > > >  > video: Unknown symbol backlight_device_unregister
 > > >  > video: Unknown symbol backlight_device_register
 > > >  >
 > > >  > This is a nocoma server, not a laptop.  I'm not sure how those modules are
 > > >  > even getting loaded.  The distro is FC4, which might be doing something
 > > >  > peculiar.
 > > >
 > > > I covered this on the list last week.  There's no way to
 > > > have a module autoload based on dmi strings or the like,
 > > > (Which is the only sane way these modules can determine
 > > >  if they need to run).
 > > >
 > > > Given the absense of mechanism, there's a pretty gross hack
 > > > in Fedora's rc.sysinit which loads every module in drivers/acpi/*/*
 > > > that it finds.  Shameful I know.
 > >
 > > I thought it might be something like that.  I'm a bit surprised that we
 > > can't get at the DMI stuff from userspace, or export it from the kernel.
 > > But whatever.
 > 
 > I have a question: why can't we get at the DMI stuff from userspace
 > since "dmidecode" is a tool in userspace?

We can, but we could do better.
What's missing is an *event* that udev can see, so that it
knows what to do.

Imagine: asus_acpi gets a MODULE_DMI("ASUS") or whatever, and then
at boottime, we register a sysfs modalias of the system DMI string.
Suddenly we have two pieces of the puzzle, and udev will see the
modalias and happily pull in any modules that match the alias.

All without any changes to userspace at all.

	Dave

-- 
http://www.codemonkey.org.uk
