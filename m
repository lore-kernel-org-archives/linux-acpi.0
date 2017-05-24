From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v5 2/3] of: Make of_fwnode_handle() safer
Date: Wed, 24 May 2017 11:31:47 +0100
Message-ID: <06c3ebeb-0690-b353-4e2b-ad085b08e36c@ideasonboard.com>
References: <1495440698-22260-1-git-send-email-sakari.ailus@linux.intel.com>
 <1495440698-22260-3-git-send-email-sakari.ailus@linux.intel.com>
Reply-To: kieran.bingham@ideasonboard.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:50622 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757464AbdEXKbx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 06:31:53 -0400
In-Reply-To: <1495440698-22260-3-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, devicetree@vger.kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, ahs3@redhat.com

Hi Sakari,

Thankyou for the patch,

On 22/05/17 09:11, Sakari Ailus wrote:
> On the expense of a little bit more complexity in the of_fwnode_handle()
> macro, make the macro result in NULL in case its argument is NULL while
> still referencing it only once.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/of.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 50fcdb5..a7ccf34 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -159,7 +159,13 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
>  		container_of(fwnode, struct device_node, fwnode) : NULL;
>  }
>  
> -#define of_fwnode_handle(node) (&(node)->fwnode)
> +#define of_fwnode_handle(node)						\
> +	({								\
> +		typeof(node) __of_fwnode_handle_node = node;		\

Should this be '/= node/= (node)/' ?

> +									\
> +		__of_fwnode_handle_node ?				\
> +			&__of_fwnode_handle_node->fwnode : NULL;	\
> +	})
>  
>  static inline bool of_have_populated_dt(void)
>  {
> 

Otherwise,

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

--
Regards

Kieran
