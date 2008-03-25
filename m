From: "Carlos Corbacho" <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] Force acpi_new_pts_ordering for ASUS A6VC laptop
Date: Tue, 25 Mar 2008 09:24:37 -0000 (UTC)
Message-ID: <9985.194.201.210.214.1206437077.squirrel@phoenix.slamd64.com>
References: <1206434857.23794.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:37646 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbYCYJZI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 05:25:08 -0400
In-Reply-To: <1206434857.23794.8.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

> +static int __init asus_suspend_order(const struct dmi_system_id *d)
> +{
> +	printk(KERN_WARNING PREFIX "%s detected, "
> +		"acpi_new_pts_ordering is force enabled\n", d->ident);
> +	new_pts_ordering = true;
> +	return 0;

Given all you're doing here is just changing the ordering,
'asus_suspend_order' doesn't strike me as the right name for this function
since:

1) This clearly isn't the case for all Asus boards.

2) Perhaps something like 'new_suspend_order' would be a better name for
this function (e.g. if others want to use DMI to do this for non-Asus
boards).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
