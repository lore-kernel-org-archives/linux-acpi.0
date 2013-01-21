From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][Update 2][PATCH 3/4] sysfs: Functions for adding/removing
 symlinks to/from attribute groups
Date: Mon, 21 Jan 2013 14:38:14 -0800
Message-ID: <20130121223814.GA28518@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <7521411.VG2IjTvoWi@vostro.rjw.lan>
 <20130121205820.GC17006@kroah.com>
 <6110949.dY5glp6Ioa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:53986 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab3AUWiS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2013 17:38:18 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so2893481dad.13
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jan 2013 14:38:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6110949.dY5glp6Ioa@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Mon, Jan 21, 2013 at 11:41:35PM +0100, Rafael J. Wysocki wrote:
> On Monday, January 21, 2013 12:58:20 PM Greg Kroah-Hartman wrote:
> > On Mon, Jan 21, 2013 at 02:06:27PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The most convenient way to expose ACPI power resources lists of a
> > > device is to put symbolic links to sysfs directories representing
> > > those resources into special attribute groups in the device's sysfs
> > > directory.  For this purpose, it is necessary to be able to add
> > > symbolic links to attribute groups.
> > > 
> > > For this reason, add sysfs helper functions for adding/removing
> > > symbolic links to/from attribute groups, sysfs_add_link_to_group()
> > > and sysfs_remove_link_from_group(), respectively.
> > 
> > Those functions are fine, but why sysfs_add_link()?
> 
> Do you mean the helper?  I couldn't invent a better name. :-)
> 
> Would sysfs_create_link_sd() be better?

That's a bit more descriptive, yes, and don't export it and I'll have no
objections.

thanks,

greg k-h
