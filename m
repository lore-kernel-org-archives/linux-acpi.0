From: "Yang, Hyungwoo" <hyungwoo.yang@intel.com>
Subject: RE: [PATCH 1/1] ACPI: device property: Fix node lookup in
 acpi_graph_get_child_prop_value
Date: Tue, 22 Aug 2017 17:47:55 +0000
Message-ID: <7A4F467111FEF64486F40DFE7DF3500A03EE9959@ORSMSX111.amr.corp.intel.com>
References: <1503385277-1944-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51722 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdHVRr5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Aug 2017 13:47:57 -0400
In-Reply-To: <1503385277-1944-1-git-send-email-sakari.ailus@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Westerberg, Mika" <mika.westerberg@intel.com>, "rafael@kernel.org" <rafael@kernel.org>


Hi Sakari,

You forgot "fwnode" => "child".

if (fwnode_property_read_u32(fwnode, prop_name, &nr))
=> if (fwnode_property_read_u32(child, prop_name, &nr))

-Hyungwoo

-----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com] 
> Sent: Tuesday, August 22, 2017 12:01 AM
> To: linux-acpi@vger.kernel.org
> Cc: Yang, Hyungwoo <hyungwoo.yang@intel.com>; Westerberg, Mika <mika.westerberg@intel.com>; rafael@kernel.org
> Subject: [PATCH 1/1] ACPI: device property: Fix node lookup in acpi_graph_get_child_prop_value
> 
> acpi_graph_get_child_prop_value() is intended to find a child node with a certain property value pair. The check
> 
> 	if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
> 		continue;
> 
> is faulty: fwnode_property_read_u32() returns zero on success, not on failure, leading to comparing values only if the searched property was not found.
> 
> Fixes: 79389a83bc38 ("ACPI / property: Add support for remote endpoints")
> Reported-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c index a65c09c..3963098 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1052,7 +1052,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
>  	fwnode_for_each_child_node(fwnode, child) {
>  		u32 nr;
>  
> -		if (!fwnode_property_read_u32(fwnode, prop_name, &nr))
> +		if (fwnode_property_read_u32(fwnode, prop_name, &nr))
>  			continue;
>  
>  		if (val == nr)
> --
> 2.7.4
