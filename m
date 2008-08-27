From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 8/11]introduce .uevent for devices in dock
Date: Thu, 28 Aug 2008 01:37:06 +0200
Message-ID: <87wsi2owrh.fsf@basil.nowhere.org>
References: <1219806893.32665.64.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34749 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbYH0XhM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:37:12 -0400
In-Reply-To: <1219806893.32665.64.camel@sli10-desk.sh.intel.com> (Shaohua Li's message of "Wed, 27 Aug 2008 11:14:53 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Shaohua Li <shaohua.li@intel.com> writes:

> +static void ata_acpi_uevent(struct ata_port *ap, struct ata_device *dev,
> +	u32 event)
> +{
> +	struct kobject *kobj = NULL;
> +	char event_string[12];
> +	char *envp[] = { event_string, NULL };
> +
> +	if (dev) {
> +		if (dev->sdev)
> +			kobj = &dev->sdev->sdev_gendev.kobj;
> +	} else
> +		kobj = &ap->dev->kobj;
> +
> +	if (kobj) {
> +		sprintf(event_string, "BAY_EVENT=%d", event);

That will overflow when event is more than one digit. Is that
enforced? Should be buffer be larger? snprintf is safer

-Andi
-- 
ak@linux.intel.com
