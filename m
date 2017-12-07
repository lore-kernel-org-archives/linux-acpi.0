From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH V6 4/7] OF: properties: Implement get_match_data()
 callback
Date: Thu, 7 Dec 2017 14:38:45 +0200
Message-ID: <20171207123845.m7n4wxzn2u5sqtkj@valkosipuli.retiisi.org.uk>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:57740 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753245AbdLGMis (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Dec 2017 07:38:48 -0500
Content-Disposition: inline
In-Reply-To: <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, open list <linux-kernel@vger.kernel.org>

Hi Sinan,

On Tue, Dec 05, 2017 at 12:04:49PM -0500, Sinan Kaya wrote:
> Now that we have a get_match_data() callback as part of the firmware node,
> implement the OF specific piece for it.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/of/property.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 264c355..9964169 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -981,6 +981,12 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	return 0;
>  }
>  
> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> +			       struct device *dev)

static, as Rob mentioned.

> +{
> +	return (void *)of_device_get_match_data(dev);
> +}
> +
>  const struct fwnode_operations of_fwnode_ops = {
>  	.get = of_fwnode_get,
>  	.put = of_fwnode_put,
> @@ -996,5 +1002,6 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	.graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
>  	.graph_get_port_parent = of_fwnode_graph_get_port_parent,
>  	.graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
> +	.get_match_data = of_fwnode_get_match_data,

Please arrange right after device_is_available, the same applies to the
ACPI equivalent (5th patch).

>  };
>  EXPORT_SYMBOL_GPL(of_fwnode_ops);

With the above changes plus the ones in my comments on 3rd patch, on
patches 3--5:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
