From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3 RFC] Driver core: Use generic offline/online for CPU
 offline/online
Date: Mon, 29 Apr 2013 16:11:06 -0700
Message-ID: <20130429231106.GC1333@kroah.com>
References: <1576321.HU0tZ4cGWk@vostro.rjw.lan>
 <5608485.T3GFgtNYov@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:61150 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759230Ab3D2XLI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2013 19:11:08 -0400
Received: by mail-pa0-f41.google.com with SMTP id kq12so6094pab.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2013 16:11:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5608485.T3GFgtNYov@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Toshi Kani <toshi.kani@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, isimatu.yasuaki@jp.fujitsu.com, vasilis.liaskovitis@profitbricks.com

On Mon, Apr 29, 2013 at 02:28:02PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rework the CPU hotplug code in drivers/base/cpu.c to use the
> generic offline/online support introduced previously instead of
> its own CPU-specific code.
> 
> For this purpose, modify cpu_subsys to provide offline and online
> callbacks for CONFIG_HOTPLUG_CPU set and remove the code handling
> the CPU-specific 'online' sysfs attribute.
> 
> This modification is not supposed to change the user-observable
> behavior of the kernel (i.e. the 'online' attribute will be present
> in exactly the same place in sysfs and should trigger exactly the
> same actions as before).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/cpu.c |   62 ++++++++++++-----------------------------------------
>  1 file changed, 15 insertions(+), 47 deletions(-)

Very nice, I like reductions like this :)

greg k-h
