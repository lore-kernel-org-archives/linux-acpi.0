From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv2 1/1] device property: fix for a case of use-after-free
Date: Thu, 10 Mar 2016 23:21:15 +0100
Message-ID: <13629430.eLIMdjdec8@vostro.rjw.lan>
References: <1457607798-62438-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60801 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932436AbcCJWTV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 17:19:21 -0500
In-Reply-To: <1457607798-62438-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Youn <John.Youn@synopsys.com>, linux-acpi@vger.kernel.org

On Thursday, March 10, 2016 01:03:18 PM Heikki Krogerus wrote:
> In device_remove_property_set(), the secondary fwnode needs
> to be cleared before the pset is freed. This fixes a
> use-after-free when a property set is providing the primary
> fwnode.
> 
> As a result of the fix, the primary fwnode may end up
> containing ERR_PTR(-ENODEV), so also adding checks for it to
> the property handling code.
> 
> Reported-by: John Youn <John.Youn@synopsys.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

OK, queued up for 4.6, thanks!

> ---
>  drivers/base/property.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index d6c8caa..9b1a65d 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -218,7 +218,8 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
>  	bool ret;
>  
>  	ret = __fwnode_property_present(fwnode, propname);
> -	if (ret == false && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> +	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
> +	    !IS_ERR_OR_NULL(fwnode->secondary))
>  		ret = __fwnode_property_present(fwnode->secondary, propname);
>  	return ret;
>  }
> @@ -423,7 +424,8 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
>  	int _ret_;									\
>  	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
>  				 _val_, _nval_);					\
> -	if (_ret_ == -EINVAL && _fwnode_ && !IS_ERR_OR_NULL(_fwnode_->secondary))	\
> +	if (_ret_ == -EINVAL && !IS_ERR_OR_NULL(_fwnode_) &&				\
> +	    !IS_ERR_OR_NULL(_fwnode_->secondary))					\
>  		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
>  				_proptype_, _val_, _nval_);				\
>  	_ret_;										\
> @@ -593,7 +595,8 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
>  	int ret;
>  
>  	ret = __fwnode_property_read_string_array(fwnode, propname, val, nval);
> -	if (ret == -EINVAL && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> +	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> +	    !IS_ERR_OR_NULL(fwnode->secondary))
>  		ret = __fwnode_property_read_string_array(fwnode->secondary,
>  							  propname, val, nval);
>  	return ret;
> @@ -621,7 +624,8 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
>  	int ret;
>  
>  	ret = __fwnode_property_read_string(fwnode, propname, val);
> -	if (ret == -EINVAL && fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
> +	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> +	    !IS_ERR_OR_NULL(fwnode->secondary))
>  		ret = __fwnode_property_read_string(fwnode->secondary,
>  						    propname, val);
>  	return ret;
> @@ -816,11 +820,16 @@ void device_remove_property_set(struct device *dev)
>  	 * the pset. If there is no real firmware node (ACPI/DT) primary
>  	 * will hold the pset.
>  	 */
> -	if (!is_pset_node(fwnode))
> -		fwnode = fwnode->secondary;
> -	if (!IS_ERR(fwnode) && is_pset_node(fwnode))
> +	if (is_pset_node(fwnode)) {
> +		set_primary_fwnode(dev, NULL);
>  		pset_free_set(to_pset_node(fwnode));
> -	set_secondary_fwnode(dev, NULL);
> +	} else {
> +		fwnode = fwnode->secondary;
> +		if (!IS_ERR(fwnode) && is_pset_node(fwnode)) {
> +			set_secondary_fwnode(dev, NULL);
> +			pset_free_set(to_pset_node(fwnode));
> +		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(device_remove_property_set);
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
