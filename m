From: Kieran Bingham <kieran.bingham+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v5.1 3/3] of: Support const and non-const use for
 to_of_node()
Date: Wed, 24 May 2017 11:48:40 +0100
Message-ID: <d9eee496-2ac9-5035-e1b9-552d6f99065b@ideasonboard.com>
References: <1495440698-22260-4-git-send-email-sakari.ailus@linux.intel.com>
 <1495521543-31570-1-git-send-email-sakari.ailus@linux.intel.com>
Reply-To: kieran.bingham-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1495521543-31570-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Sakari,

Thankyou for the patch,

On 23/05/17 07:39, Sakari Ailus wrote:
> Turn to_of_node() into a macro in order to support both const and
> non-const use. Additionally make the fwnode argument to is_of_node() const
> as well.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> since v5:
> 
> - Put const to the argument, not the type returned.
> 
>  include/linux/of.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index a7ccf34..aaf9c18 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -148,16 +148,20 @@ extern raw_spinlock_t devtree_lock;
>  #ifdef CONFIG_OF
>  void of_core_init(void);
>  
> -static inline bool is_of_node(struct fwnode_handle *fwnode)
> +static inline bool is_of_node(const struct fwnode_handle *fwnode)
>  {
>  	return !IS_ERR_OR_NULL(fwnode) && fwnode->type == FWNODE_OF;
>  }
>  
> -static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
> -{
> -	return is_of_node(fwnode) ?
> -		container_of(fwnode, struct device_node, fwnode) : NULL;
> -}
> +#define to_of_node(__fwnode)						\
> +	({								\
> +		typeof(__fwnode) __to_of_node_fwnode = __fwnode;	\

Again here, I think it might need /= __fwnode/= (__fwnode)/

Other than that - this looks good to me.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> +									\
> +		is_of_node(__to_of_node_fwnode) ?			\
> +			container_of(__to_of_node_fwnode,		\
> +				     struct device_node, fwnode) :	\
> +			NULL;						\
> +	})
>  
>  #define of_fwnode_handle(node)						\
>  	({								\
> @@ -539,12 +543,12 @@ static inline void of_core_init(void)
>  {
>  }
>  
> -static inline bool is_of_node(struct fwnode_handle *fwnode)
> +static inline bool is_of_node(const struct fwnode_handle *fwnode)
>  {
>  	return false;
>  }
>  
> -static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
> +static inline struct device_node *to_of_node(const struct fwnode_handle *fwnode)
>  {
>  	return NULL;
>  }
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
