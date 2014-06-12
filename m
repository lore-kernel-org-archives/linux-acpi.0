From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] ACPI/Battery: Retry to get Battery information if failed
 during probing
Date: Thu, 12 Jun 2014 00:26:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406120025050.23724@chino.kir.corp.google.com>
References: <1402552946-14704-1-git-send-email-tianyu.lan@intel.com> <alpine.DEB.2.02.1406112354070.23724@chino.kir.corp.google.com> <53995488.20308@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45326 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbaFLH0u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 03:26:50 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so786488iec.3
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2014 00:26:49 -0700 (PDT)
In-Reply-To: <53995488.20308@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, naszar@ya.ru, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, 12 Jun 2014, Lan Tianyu wrote:

> >> Some machines'(E,G Lenovo Z480) ECs are not stable during boot up
> >> and causes battery driver fails to be probed due to failure of getting
> >> battery information from EC sometimes. After several retries, the
> >> operation will work. This patch is to retry to get battery information 5
> >> times if the first try fails.
> >>
> >> Reported-and-tested-by: naszar <naszar@ya.ru>
> >> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=75581
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> ---
> >>  drivers/acpi/battery.c | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> >> index e48fc98..485009d 100644
> >> --- a/drivers/acpi/battery.c
> >> +++ b/drivers/acpi/battery.c
> >> @@ -34,6 +34,7 @@
> >>  #include <linux/dmi.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/suspend.h>
> >> +#include <linux/delay.h>
> >>  #include <asm/unaligned.h>
> >>  
> >>  #ifdef CONFIG_ACPI_PROCFS_POWER
> >> @@ -1119,7 +1120,7 @@ static struct dmi_system_id bat_dmi_table[] = {
> >>  
> >>  static int acpi_battery_add(struct acpi_device *device)
> >>  {
> >> -	int result = 0;
> >> +	int result = 0, retry = 5;
> >>  	struct acpi_battery *battery = NULL;
> >>  
> >>  	if (!device)
> >> @@ -1135,7 +1136,16 @@ static int acpi_battery_add(struct acpi_device *device)
> >>  	mutex_init(&battery->sysfs_lock);
> >>  	if (acpi_has_method(battery->device->handle, "_BIX"))
> >>  		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
> >> +
> >> +retry_get_info:
> >>  	result = acpi_battery_update(battery, false);
> >> +
> >> +	if (result && retry) {
> >> +		msleep(20);
> > 
> 
> Hi David:
> 	Thanks for review.
> 
> > We're really going to wait up to 20 * 5 = 100ms for acpi_battery_update() 
> > to succeed?
> 
> No, this depends which retry acpi_battery_update() will succeed. For
> most machines, there will be no delay.
> 

Right, but you're willing to wait up to 100ms for it to succeed?  You're 
implementing x retries with y ms sleep in between, I'm asking how it is 
determined that the optimal values are x = 5 and y = 20.  More directly: 
is it possible to succeed at 101ms?  Is it really likely to succeed after 
the first 20ms?
