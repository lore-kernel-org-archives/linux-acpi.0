From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][Update 2][PATCH 3/4] sysfs: Functions for adding/removing
 symlinks to/from attribute groups
Date: Mon, 21 Jan 2013 12:58:20 -0800
Message-ID: <20130121205820.GC17006@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <2096792.ELJ8WGVaaz@vostro.rjw.lan>
 <4247313.2G7Z3nCgM0@vostro.rjw.lan>
 <7521411.VG2IjTvoWi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:52710 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab3AUU6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2013 15:58:24 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so3595133pad.2
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jan 2013 12:58:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7521411.VG2IjTvoWi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Mon, Jan 21, 2013 at 02:06:27PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The most convenient way to expose ACPI power resources lists of a
> device is to put symbolic links to sysfs directories representing
> those resources into special attribute groups in the device's sysfs
> directory.  For this purpose, it is necessary to be able to add
> symbolic links to attribute groups.
> 
> For this reason, add sysfs helper functions for adding/removing
> symbolic links to/from attribute groups, sysfs_add_link_to_group()
> and sysfs_remove_link_from_group(), respectively.

Those functions are fine, but why sysfs_add_link()?  It looks identical
to sysfs_create_link(), why would you call one and not the other?  Why
would anything outside of the sysfs core code ever have a pointer to a
sysfs_dirent?

thanks,

greg k-h
