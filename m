From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/4] Driver core: Add offline/online device operations
Date: Thu, 2 May 2013 06:57:28 -0700
Message-ID: <20130502135728.GA24095@kroah.com>
References: <1576321.HU0tZ4cGWk@vostro.rjw.lan>
 <3166726.elbgrUIZ0L@vostro.rjw.lan>
 <1647668.odH0HuOGZ9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:56510 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3EBN5h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 May 2013 09:57:37 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so362582pbb.13
        for <linux-acpi@vger.kernel.org>; Thu, 02 May 2013 06:57:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1647668.odH0HuOGZ9@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, isimatu.yasuaki@jp.fujitsu.com, vasilis.liaskovitis@profitbricks.com, Len Brown <lenb@kernel.org>

On Thu, May 02, 2013 at 02:27:30PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In some cases, graceful hot-removal of devices is not possible,
> although in principle the devices in question support hotplug.
> For example, that may happen for the last CPU in the system or
> for memory modules holding kernel memory.
> 
> In those cases it is nice to be able to check if the given device
> can be gracefully hot-removed before triggering a removal procedure
> that cannot be aborted or reversed.  Unfortunately, however, the
> kernel currently doesn't provide any support for that.
> 
> To address that deficiency, introduce support for offline and
> online operations that can be performed on devices, respectively,
> before a hot-removal and in case when it is necessary (or convenient)
> to put a device back online after a successful offline (that has not
> been followed by removal).  The idea is that the offline will fail
> whenever the given device cannot be gracefully removed from the
> system and it will not be allowed to use the device after a
> successful offline (until a subsequent online) in analogy with the
> existing CPU offline/online mechanism.
> 
> For now, the offline and online operations are introduced at the
> bus type level, as that should be sufficient for the most urgent use
> cases (CPUs and memory modules).  In the future, however, the
> approach may be extended to cover some more complicated device
> offline/online scenarios involving device drivers etc.
> 
> The lock_device_hotplug() and unlock_device_hotplug() functions are
> introduced because subsequent patches need to put larger pieces of
> code under device_hotplug_lock to prevent race conditions between
> device offline and removal from happening.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
