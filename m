From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][Update 2][PATCH 4/4] ACPI / PM: Expose lists of device
 power resources to user space
Date: Mon, 21 Jan 2013 12:58:46 -0800
Message-ID: <20130121205846.GD17006@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <2096792.ELJ8WGVaaz@vostro.rjw.lan>
 <4247313.2G7Z3nCgM0@vostro.rjw.lan>
 <75501802.qSzsX3NXGt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41740 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab3AUU6u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2013 15:58:50 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so2211397pab.5
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jan 2013 12:58:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <75501802.qSzsX3NXGt@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Mon, Jan 21, 2013 at 02:08:16PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since ACPI power resources are going to be used more extensively on
> new hardware platforms, it is necessary to allow user space (powertop
> in particular) to look at the lists of power resources corresponding
> to different power states of devices for diagnostics and control
> purposes.
> 
> For this reason, for each power state of an ACPI device node using
> power resources create a special attribute group under the device
> node's directory in sysfs containing links to sysfs directories
> representing the power resources in that list.  The names of the
> new attribute groups are "power_resources_<state>", where <state>
> is the state name i.e. "D0", "D1", "D2", or "D3hot".
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

You aren't calling sysfs_add_link() here, so why did you export it in
the previous patch?

thanks,

greg k-h
