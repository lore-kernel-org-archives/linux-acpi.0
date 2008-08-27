From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 3/11]add _LCK support for dock
Date: Thu, 28 Aug 2008 01:09:59 +0200
Message-ID: <8763pmqcl4.fsf@basil.nowhere.org>
References: <1219806871.32665.59.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:33018 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbYH0XKF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:10:05 -0400
In-Reply-To: <1219806871.32665.59.camel@sli10-desk.sh.intel.com> (Shaohua Li's message of "Wed, 27 Aug 2008 11:14:31 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

Shaohua Li <shaohua.li@intel.com> writes:

> +static void dock_lock(struct dock_station *ds, int lock)
> +{
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
> +	acpi_status status;
> +
> +	arg_list.count = 1;
> +	arg_list.pointer = &arg;
> +	arg.type = ACPI_TYPE_INTEGER;
> +	arg.integer.value = !!lock;
> +	status = acpi_evaluate_object(ds->handle, "_LCK", &arg_list, NULL);
> +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> +		printk(KERN_WARNING PREFIX "%s device failed\n",
> +			lock ? "Locking" : "Unlocking");

Please use two printks -- that makes the error message greppable.
Output the status and some identifier for the device? Otherwise
the user will have no clue what device failed.

-Andi

-- 
ak@linux.intel.com
