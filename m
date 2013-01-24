From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Update][PATCH 1/5] ACPI / scan: Prevent device add uevents from
 racing with user space
Date: Wed, 23 Jan 2013 16:33:19 -0800
Message-ID: <20130124003319.GA10969@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <2760421.6nE3tkh92K@vostro.rjw.lan>
 <1551140.kO91IOVbjI@vostro.rjw.lan>
 <4119653.FS5BMPMa9z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63226 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab3AXAdX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2013 19:33:23 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so3662798pbb.16
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jan 2013 16:33:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4119653.FS5BMPMa9z@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Jan 23, 2013 at 06:58:31PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> ACPI core adds sysfs device files after the given devices have been
> registered with device_register(), which is not appropriate, because
> it may lead to race conditions with user space tools using those
> files.
> 
> Fix the problem by delaying the KOBJ_ADD uevent for ACPI devices
> until after all of the devices' sysfs files have been created.
> 
> This also fixes a use-after-free in acpi_device_unregister().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice fix.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
