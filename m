From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 13/52] PCI, acpiphp: Add missing realloc list checking after resource allocation
Date: Tue, 25 Aug 2015 00:09:29 +0200
Message-ID: <205780224.0d92UNafyF@vostro.rjw.lan>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org> <1440138067-4314-14-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44801 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751386AbbHXVl6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2015 17:41:58 -0400
In-Reply-To: <1440138067-4314-14-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thursday, August 20, 2015 11:20:28 PM Yinghai Lu wrote:
> We check the realloc list, as list must be empty after allocation.
> 
> Add missing one acpiphp driver.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index ff53856..1c7c1d7 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -507,6 +507,7 @@ static void enable_slot(struct acpiphp_slot *slot)
>  		}
>  	}
>  	__pci_bus_assign_resources(bus, &add_list, NULL);
> +	BUG_ON(!list_empty(&add_list));

Is crashing the kernel the best we can do here?

What about bailing out with a WARN_ON() instead?  Surely, the kernel can work
without the new device?

>  
>  	acpiphp_sanitize_bus(bus);
>  	pcie_bus_configure_settings(bus);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
