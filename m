From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] firmware: dmi_scan: add DMI_OEM_STRING support to
 dmi_matches
Date: Mon, 5 Feb 2018 11:26:25 +0100
Message-ID: <20180205112625.2e451bce@endymion>
References: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43935 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752498AbeBEK0a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 05:26:30 -0500
In-Reply-To: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org, Mario.Limonciello@dell.com

Hi Alex,

On Wed, 31 Jan 2018 00:40:04 -0800, Alex Hung wrote:
> OEM strings are defined by each OEM and they contain customized and
> useful OEM information. Supporting it provides more flexible uses of
> the dmi_matches function.
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/firmware/dmi_scan.c     | 8 ++++++++
>  include/linux/mod_devicetable.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 7830419..e534d1b 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -797,11 +797,19 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>  			else if (dmi->matches[i].exact_match &&
>  				 !strcmp(dmi_ident[s], dmi->matches[i].substr))
>  				continue;
> +		} else if (s == DMI_OEM_STRING) {
> +			const struct dmi_device *valid;
> +
> +			valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
> +						dmi->matches[i].substr, NULL);
> +			if (valid)
> +				continue;
>  		}
>  
>  		/* No match */
>  		return false;
>  	}
> +
>  	return true;
>  }
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index abb6dc2..5739c4c 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -482,6 +482,7 @@ enum dmi_field {
>  	DMI_CHASSIS_VERSION,
>  	DMI_CHASSIS_SERIAL,
>  	DMI_CHASSIS_ASSET_TAG,
> +	DMI_OEM_STRING,
>  	DMI_STRING_MAX,
>  };
>  

This is kind of a hack, because there are more than one OEM string, so
they don't fit in dmi_ident[], but I see the value. However, reserving
one entry for them in dmi_ident[], which you will never use, is
potentially confusing, so it would have to be documented.

Did you consider adding DMI_OEM_STRING after DMI_STRING_MAX? It would
avoid the memory waste (small but still) and shouldn't be a problem if
you test this specific case early enough in dmi_matches()?

It should also be documented that only exact matches are supported for
DMI_OEM_STRING (dmi_strmatch.exact_match is ignored and considered true
always.)

Lastly you will have to rebase your patch on top of Linus' latest tree
and in particular:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8cf4e6a04f734e831c2ac7f405071d1cde690ba8

Thanks,
-- 
Jean Delvare
SUSE L3 Support
