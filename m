From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 2/2] ACPI,acpi_memhotplug: Remove acpi_memory_info->failed bit
Date: Tue, 26 Mar 2013 14:41:27 +0100
Message-ID: <4310971.etCm8Nd6PX@vostro.rjw.lan>
References: <514022BF.3080303@jp.fujitsu.com> <1363983884.11659.14.camel@misato.fc.hp.com> <5150E451.3010100@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43123 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934013Ab3CZNeB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:01 -0400
In-Reply-To: <5150E451.3010100@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: Toshi Kani <toshi.kani@hp.com>, linux-acpi@vger.kernel.org, tangchen@cn.fujitsu.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org

On Tuesday, March 26, 2013 08:57:05 AM Yasuaki Ishimatsu wrote:
> 2013/03/23 5:24, Toshi Kani wrote:
> > On Fri, 2013-03-22 at 10:53 +0900, Yasuaki Ishimatsu wrote:
> >> acpi_memory_info has enabled bit and failed bit for controlling memory
> >> hotplug. But we don't need to keep both bits.
> >>
> >> The patch removes acpi_memory_info->failed bit.
> >>
> >> Signed-off-by: yasuaki ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> >
> > Thanks for the update.  It looks good.  For the series:
> >
> > Acked-by: Toshi Kani <toshi.kani@hp.com>
> 
> Thanks!

Both patches applied to linux-pm.git/linux-next.

Thanks,
Rafael


> >> ---
> >>
> >> v3 : Continue to memory hot remove when (!info->enabled) case.
> >> v2 : Changed a based kernel from linux-3.9-rc2 to linux-pm.git/bleeding-edge.
> >>
> >> ---
> >>    drivers/acpi/acpi_memhotplug.c |   15 ++-------------
> >>    1 files changed, 2 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> >> index ea78988..5e6301e 100644
> >> --- a/drivers/acpi/acpi_memhotplug.c
> >> +++ b/drivers/acpi/acpi_memhotplug.c
> >> @@ -73,7 +73,6 @@ struct acpi_memory_info {
> >>    	unsigned short caching;	/* memory cache attribute */
> >>    	unsigned short write_protect;	/* memory read/write attribute */
> >>    	unsigned int enabled:1;
> >> -	unsigned int failed:1;
> >>    };
> >>
> >>    struct acpi_memory_device {
> >> @@ -201,10 +200,8 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
> >>    		 * returns -EEXIST. If add_memory() returns the other error, it
> >>    		 * means that this memory block is not used by the kernel.
> >>    		 */
> >> -		if (result && result != -EEXIST) {
> >> -			info->failed = 1;
> >> +		if (result && result != -EEXIST)
> >>    			continue;
> >> -		}
> >>
> >>    		info->enabled = 1;
> >>
> >> @@ -238,16 +235,8 @@ static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
> >>    	nid = acpi_get_node(mem_device->device->handle);
> >>
> >>    	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
> >> -		if (info->failed)
> >> -			/* The kernel does not use this memory block */
> >> -			continue;
> >> -
> >>    		if (!info->enabled)
> >> -			/*
> >> -			 * The kernel uses this memory block, but it may be not
> >> -			 * managed by us.
> >> -			 */
> >> -			return -EBUSY;
> >> +			continue;
> >>
> >>    		if (nid < 0)
> >>    			nid = memory_add_physaddr_to_nid(info->start_addr);
> >>
> >
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
