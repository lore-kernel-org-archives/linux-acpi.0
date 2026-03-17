Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7B43A0B3D;
	Tue, 17 Mar 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786452; cv=none; b=u8dPymjaHnpCUq64gt4X4EgmhF1w2vhA8rlRil7QTe1bRGSZyCTxMYXJBMtbRm7IeFBa16PLybwmWSH3Qg8Phpnd61iapSO/OJQ2/2DrYJ/Sofjy5v4bwFBFdQ+2LApvv3x4kWl0mCJ649vEtuzeLPr/OqFfN2NJEiDpdMkNJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786452; c=relaxed/simple;
	bh=kBwgsLTRCu/nxHeEy73U+d/O2En2PS55Gn1EHEwC/vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miBsjqXpkpQPx+8k95geDEgDJSwyM7CqpGmnF9ecLEGV0xehPHQoymzauWIKv5gX+FHfzW1bbpUfhioIZnmonC9KIMo3uTRIpTl5KAmtwTDWK3WihRoRRXb5RqDF+6KgRr377e7mQ/ekRmv0hM+S8xscoQHSIIUpmVBHCQjcg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jORA+J/L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jORA+J/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773786450; x=1805322450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kBwgsLTRCu/nxHeEy73U+d/O2En2PS55Gn1EHEwC/vg=;
  b=jORA+J/Loy2W1G4bESAdpn8wC/FIttKJ8g02BjHxZISDTIITYEubeBNP
   h82/K2syLujxBbw04vEFa9BjeN5vU/buwTrD+9thBYPYcWg3y65KBvzkE
   ZM2O/wh1eaYrX8/cb+OI60gR2LUXdMMMRaHBf2J5c6K7de5Dlcyb86t/Y
   cnN48hInyv6tmGKnvjL4WBCM3jvFgd8UX+NlOA9I8saJ2Q9EXS+maGDZK
   JKtLf6k843TG5V9aoCPNL0Ww7BM9o/Y1joBlFqRwtOSbdy4AlwMatydKH
   obe+XIFIYDEjXUzfw6iSnK8H6dWp/2ZJAJUBUPz/BkSsUG5bl615COTBl
   w==;
X-CSE-ConnectionGUID: I8eqDOdCSLWd96XQpEkgXA==
X-CSE-MsgGUID: E8UhHQNKQ+aYLGEXRqIMZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="62400367"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="62400367"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 15:27:30 -0700
X-CSE-ConnectionGUID: mUmdOjq/Sua+gBk58lww+w==
X-CSE-MsgGUID: DKfZpQHdSiWQ2xcRi0RVPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="252885730"
Received: from abityuts-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 15:27:27 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 60867121D18;
	Wed, 18 Mar 2026 00:27:24 +0200 (EET)
Date: Wed, 18 Mar 2026 00:27:24 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] device property: Document how to check for the
 property presence
Message-ID: <abnVTODs9fOqF9eV@kekkonen.localdomain>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

Thanks for the patch.

On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:
> Currently it's unclear if one may or may not rely on the error codes
> returned from the property getters to check for the property presence.
> Clarify this by mass updating kernel-doc for fwnode_property_*() and
> device_property_*() where it's applicable.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: 4b24f1f4-b395-467a-81b7-1334a2d48845@roeck-us.net
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8d9a34be57fb..bffa0070ab13 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
>   * @propname: Name of the property
>   *
>   * Check if property @propname is present in the device firmware description.
> + * This function is the correct way to check that given property is present
> + * in the device firmware description.
>   *
>   * Return: true if property @propname is present. Otherwise, returns false.
>   */
> @@ -52,6 +54,10 @@ EXPORT_SYMBOL_GPL(device_property_present);
>   * @fwnode: Firmware node whose property to check
>   * @propname: Name of the property
>   *
> + * Check if property @propname is present in the firmware node description.
> + * This function is the correct way to check that given property is present
> + * in the firmware node description.
> + *
>   * Return: true if property @propname is present. Otherwise, returns false.
>   */
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
> @@ -75,9 +81,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
>   * @dev: Device whose property is being checked
>   * @propname: Name of the property
>   *
> - * Return if property @propname is true or false in the device firmware description.
> + * Use device_property_present() to check for the property presence.
>   *
> - * Return: true if property @propname is present. Otherwise, returns false.
> + * Return: if property @propname is true or false in the device firmware description.
>   */
>  bool device_property_read_bool(const struct device *dev, const char *propname)
>  {
> @@ -90,7 +96,9 @@ EXPORT_SYMBOL_GPL(device_property_read_bool);
>   * @fwnode: Firmware node whose property to check
>   * @propname: Name of the property
>   *
> - * Return if property @propname is true or false in the firmware description.
> + * Use fwnode_property_present() to check for the property presence.
> + *
> + * Return: if property @propname is true or false in the firmware node description.
>   */
>  bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
>  			     const char *propname)
> @@ -121,6 +129,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
>   * It's recommended to call device_property_count_u8() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().

Do you really think we should add this clause for each of these functions?
I don't think it belongs here.

The error code list doesn't document what is returned if a property doesn't
exist (-EINVAL) and it'd be helpful to add this. It would have been best to
have a separate error code for this albeit changing this now might not be
that troublesome either: very, very few callers depend on receiving such an
error code but there are still many callers.

> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -149,6 +159,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
>   * It's recommended to call device_property_count_u16() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -177,6 +189,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
>   * It's recommended to call device_property_count_u32() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -205,6 +219,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
>   * It's recommended to call device_property_count_u64() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -233,6 +249,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>   * It's recommended to call device_property_string_array_count() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *	   number of values available on success if @val is NULL,
>   *	   %-EINVAL if given arguments are not valid,
> @@ -257,6 +275,8 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
>   * Function reads property @propname from the device firmware description and
>   * stores the value into @val if found. The value is checked to be a string.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
>   *	   %-ENODATA if the property does not have a value,
> @@ -324,6 +344,8 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
>   * It's recommended to call fwnode_property_count_u8() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -353,6 +375,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
>   * It's recommended to call fwnode_property_count_u16() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -382,6 +406,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
>   * It's recommended to call fwnode_property_count_u32() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -411,6 +437,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
>   * It's recommended to call fwnode_property_count_u64() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
> @@ -440,6 +468,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
>   * It's recommended to call fwnode_property_string_array_count() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *	   number of values available on success if @val is NULL,
>   *	   %-EINVAL if given arguments are not valid,
> @@ -476,6 +506,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
>   * Read property @propname from the given firmware node and store the value into
>   * @val if found.  The value is checked to be a string.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: %0 if the property was found (success),
>   *	   %-EINVAL if given arguments are not valid,
>   *	   %-ENODATA if the property does not have a value,

-- 
Kind regards,

Sakari Ailus
