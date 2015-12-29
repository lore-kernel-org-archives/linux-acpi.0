From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 2/3] device property: the secondary fwnode needs to
 depend on the primary
Date: Tue, 29 Dec 2015 10:40:21 +0200
Message-ID: <20151229084020.GA19870@kuha.fi.intel.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1450877684-76316-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450877684-76316-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-next-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

Found a bug from my code..

> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 0b22c8a..6c04d18 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -218,7 +218,7 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
>  	bool ret;
>  
>  	ret = __fwnode_property_present(fwnode, propname);
> -	if (ret == false && fwnode->secondary)
> +	if (ret == false && fwnode && fwnode->secondary)
>  		ret = __fwnode_property_present(fwnode->secondary, propname);
>  	return ret;
>  }
> @@ -423,7 +423,7 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
>  	int _ret_;									\
>  	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
>  				 _val_, _nval_);					\
> -	if (_ret_ == -EINVAL && _fwnode_->secondary)					\
> +	if (_ret_ == -EINVAL && fwnode && _fwnode_->secondary)				\

This should be .._fwnode_ && _fwnode_->secondary)

>  		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
>  				_proptype_, _val_, _nval_);				\
>  	_ret_;										\


Cheers,

-- 
heikki
