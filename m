From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] device property: of_property_read_string_array() returns number of strings
Date: Mon, 13 Mar 2017 23:24:01 +0100
Message-ID: <1840694.EMHZKJ1jEg@aspire.rjw.lan>
References: <1488806791-25488-1-git-send-email-sakari.ailus@linux.intel.com> <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65535 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751150AbdCMW31 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 18:29:27 -0400
In-Reply-To: <1488806791-25488-4-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 03:26:31 PM Sakari Ailus wrote:
> of_property_read_string_array() returns number of strings read if the
> target array of pointers is non-NULL. fwnode_property_read_string_array()
> is documented to return 0 in that case. Fix this.

Well, if we want people to use fwnode_property_read_string_array() instead of
of_property_read_string_array(), it should better behave analogously, shouldn't it?

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 9224541a..e67ec24 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -544,12 +544,24 @@ static int __fwnode_property_read_string_array(struct fwnode_handle *fwnode,
>  					       const char *propname,
>  					       const char **val, size_t nval)
>  {
> -	if (is_of_node(fwnode))
> -		return val ?
> -			of_property_read_string_array(to_of_node(fwnode),
> -						      propname, val, nval) :
> -			of_property_count_strings(to_of_node(fwnode), propname);
> -	else if (is_acpi_node(fwnode))
> +	if (is_of_node(fwnode)) {
> +		int rval;
> +
> +		if (!val)
> +			return of_property_count_strings(to_of_node(fwnode),
> +							 propname);
> +
> +		rval = of_property_read_string_array(to_of_node(fwnode),
> +						     propname, val, nval);
> +
> +		if (rval < 0)
> +			return rval;
> +
> +		if (rval == nval)
> +			return 0;
> +
> +		return -EOVERFLOW;
> +	} else if (is_acpi_node(fwnode))
>  		return acpi_node_prop_read(fwnode, propname, DEV_PROP_STRING,
>  					   val, nval);
>  	else if (is_pset_node(fwnode)) {
> 

Thanks,
Rafael

