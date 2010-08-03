From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/8] ACPI / PCI: Introduce acpi_pci_osc_control_query()
Date: Tue, 03 Aug 2010 14:04:06 +0900
Message-ID: <4C57A346.6020003@jp.fujitsu.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022353.04353.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32873 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab0HCFEY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Aug 2010 01:04:24 -0400
In-Reply-To: <201008022353.04353.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-pm@lists.linux-foundation.org, linux-pci@vger.kernel.org, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Matthew Garrett <mjg59@srcf.ucam.org>

(2010/08/03 6:53), Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rjw@sisk.pl>

<snip.>

> +	mutex_lock(&osc_lock);
> +	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
> +	mutex_unlock(&osc_lock);
> +

One more comment here.

I think we can skip acpi_pci_query_osc() if all of queried controls are
already granted to OS. Please see below

	mutex_lock(&osc_lock);
	if ((root->osc_control_set & *ctrl_mask) == *ctrl_mask) {
		*ctrl_mask = root->osc_control_set;
		goto out;
	}
	status = acpi_pci_query_osc(root, root->osc_support_set, ctrl_mask);
	mutex_unlock(&osc_lock);
out:

Thanks,
Kenji Kaneshige

