Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122F3E3C56
	for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 22:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786747; cv=none; b=tXy3pCsI6uKmIqiVJMovEyub9hjhJNV2YIm8nC8PEOnXD1gkyU2OzLLU99OzqsSuXuHBCUMgl5TcRLgVQ7uejksGsVMT8mUr5PLcqEfFGSU3htzfZpP29HdvH4dtkm+aLNh8AowOgQrU/s5uHgw340BikAb4RrbD6+XOy/GJYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786747; c=relaxed/simple;
	bh=bG+hTNWMzGrg079BXBRYNEblNYWj1cltTajIQ+7v8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl/YBY7azSVsKOMGOM5Ioa/bzRj4f1YsTxLgkjXM3tpVCuwk/OgCIB2sOQMN1XlB4hh0cekyCEA1fw9T7i7HJY7AcvvTu0jR4X6H8Vxlif4AfZ853PRPw+rfhHIRn5U/yl76pyaOQT2tI/tRQoMFX6jHE8zOxfV3E+/dE07JXJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxymD4Qg; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxymD4Qg"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso336312eec.0
        for <linux-acpi@vger.kernel.org>; Tue, 17 Mar 2026 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773786744; x=1774391544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymK/WXrvnQRQNcjkDZqhK3+1bVgaaqfQJXaBMmzV9+M=;
        b=ZxymD4QgHsB5S7HcM458tIhhV53tpCHjpOkmtQM6uM1x904VlvVv/xHQm6VrJO0Qgl
         0SsaiPoLvd/slLr/ui3k4x/aCX76dcePGbDFA3XS8MPdipeIU830Kw/HFZfTWSNwFunx
         NzF06u/HhErfVnbqyNkYO7xxbCK6NQNyaFBPH6phcX9Gg+TAQyJVN801U58UDEX2fyT+
         Gz9d360McqzIqfR+Xf3QTCrPLjAGrXsisZLUOIngAyPxdMIMwjPciMMTydLDYy7R1G2s
         0k/mzlgaRMdEkreXsrdjbmM/RPUJP+osxMauY4BOPKSTNNvjN38YCosuofuZFzmwGIUr
         J17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773786744; x=1774391544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ymK/WXrvnQRQNcjkDZqhK3+1bVgaaqfQJXaBMmzV9+M=;
        b=qAvW66gEKFS5itXApxZZ+hG7Yi5nVsTyyiixQfkDwNSXW8dCK4g60p+zH890VEA6lj
         fBkaL90vQ0qNPW2SYIxkkpiVvQzwrKszECzbJKPs4+gnZwYeNxn3iBpKZY5h5xEUs60W
         Qfg0h7osUEGAOOJX3J6Y8Ddpe0Py3pkzujv7MKb0rqWd3UxrhvaDXcnscx4V9/Viovza
         dIugujikke0YVT9YlUNsYMjJYsmhnWvEE0ZMyIpd6dIo0K+Iwq/hYgffF+sNrAkdhDHJ
         YQ7l5L6tH+LN7xPpv+2hDk/5z2HL72owP6k7nDQb/RVOLgA20d1/yb7I5YeQwUuJJ/dB
         OCPA==
X-Forwarded-Encrypted: i=1; AJvYcCUKkiPZib2A4rhxXsL8xGEDnedN4+xnfkRkYIRHSWROB7xqyRxuRfo1y+5Ws7PrV8xGLp6F8B6s0Wg+@vger.kernel.org
X-Gm-Message-State: AOJu0YwfRfWBP4gLjHzD9yOgdUNVFtkNHid4dbxgBTq1s5/dQZxkyk8l
	hTFNmsvKiIW8PwjCFoFaCfbvWAm6iD+42KqYnwcp8Okdd1Tw9wZhMTS+
X-Gm-Gg: ATEYQzwTQRzstPVmXwLUYUuTVHiN7krCoMjCuaKOuPnsM9J8fO6VkOPQQGgjeNfTjnN
	O3MZwnuh8pN+gybQw7E2pUbeTT9b6YDtxZ6NqMoHB7lulph46jR19MEVkWxnN3i2umLb/Qu6zYP
	stZ+lKgyx9fMFH4ia2R+q2EO78uDGyMEZWt94WhveJxxQOg+h1mPex+HM5xuAd8/PrxA2XfPAl3
	YXGlVRJaRF8YGCPXB6ud+XVPj4PLHjuBlcYzOAilVUW9LzIgRC13BjpyKrYwRKxLVxJcmflXp40
	uFZHyBBBrcvCyJuY8bRCEivC2kngL5d5Jdq1XNkouO9/BfQ3Znv2j26c1aaqQbHSJHWDzXMQrLC
	ygTk6m8PROxIL7TrERaPRfee/mCbOLPZNMwWJxx3G7Cr2a7C7sfwotCIUzmPiNygwBQ6hqD4UH5
	Q+IhZg6XAOrWXcqk1ThxqEI4Jt9pJV5yYP8l9K
X-Received: by 2002:a05:7300:80c4:b0:2c0:e2e3:491 with SMTP id 5a478bee46e88-2c0e2e306a7mr791236eec.10.1773786744282;
        Tue, 17 Mar 2026 15:32:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53bc9dbsm1232352eec.11.2026.03.17.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:32:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 15:32:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/1] device property: Document how to check for the
 property presence
Message-ID: <bd1eee84-6e5f-48c0-89a0-6f022dfbfb51@roeck-us.net>
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
 <abnVTODs9fOqF9eV@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abnVTODs9fOqF9eV@kekkonen.localdomain>

On Wed, Mar 18, 2026 at 12:27:24AM +0200, Sakari Ailus wrote:
> Hi Andy,
> 
> Thanks for the patch.
> 
> On Tue, Mar 17, 2026 at 10:08:28PM +0100, Andy Shevchenko wrote:
> > Currently it's unclear if one may or may not rely on the error codes
> > returned from the property getters to check for the property presence.
> > Clarify this by mass updating kernel-doc for fwnode_property_*() and
> > device_property_*() where it's applicable.
> > 
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: 4b24f1f4-b395-467a-81b7-1334a2d48845@roeck-us.net
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/base/property.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 8d9a34be57fb..bffa0070ab13 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(__dev_fwnode_const);
> >   * @propname: Name of the property
> >   *
> >   * Check if property @propname is present in the device firmware description.
> > + * This function is the correct way to check that given property is present
> > + * in the device firmware description.
> >   *
> >   * Return: true if property @propname is present. Otherwise, returns false.
> >   */
> > @@ -52,6 +54,10 @@ EXPORT_SYMBOL_GPL(device_property_present);
> >   * @fwnode: Firmware node whose property to check
> >   * @propname: Name of the property
> >   *
> > + * Check if property @propname is present in the firmware node description.
> > + * This function is the correct way to check that given property is present
> > + * in the firmware node description.
> > + *
> >   * Return: true if property @propname is present. Otherwise, returns false.
> >   */
> >  bool fwnode_property_present(const struct fwnode_handle *fwnode,
> > @@ -75,9 +81,9 @@ EXPORT_SYMBOL_GPL(fwnode_property_present);
> >   * @dev: Device whose property is being checked
> >   * @propname: Name of the property
> >   *
> > - * Return if property @propname is true or false in the device firmware description.
> > + * Use device_property_present() to check for the property presence.
> >   *
> > - * Return: true if property @propname is present. Otherwise, returns false.
> > + * Return: if property @propname is true or false in the device firmware description.
> >   */
> >  bool device_property_read_bool(const struct device *dev, const char *propname)
> >  {
> > @@ -90,7 +96,9 @@ EXPORT_SYMBOL_GPL(device_property_read_bool);
> >   * @fwnode: Firmware node whose property to check
> >   * @propname: Name of the property
> >   *
> > - * Return if property @propname is true or false in the firmware description.
> > + * Use fwnode_property_present() to check for the property presence.
> > + *
> > + * Return: if property @propname is true or false in the firmware node description.
> >   */
> >  bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
> >  			     const char *propname)
> > @@ -121,6 +129,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
> >   * It's recommended to call device_property_count_u8() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> 
> Do you really think we should add this clause for each of these functions?
> I don't think it belongs here.
> 
> The error code list doesn't document what is returned if a property doesn't
> exist (-EINVAL) and it'd be helpful to add this. It would have been best to
> have a separate error code for this albeit changing this now might not be
> that troublesome either: very, very few callers depend on receiving such an
> error code but there are still many callers.
> 

I also find it a bit confusing since the _bool functions are defined to return
false if the property is not present, and true if it is.

Guenter

> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -149,6 +159,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
> >   * It's recommended to call device_property_count_u16() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -177,6 +189,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
> >   * It's recommended to call device_property_count_u32() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -205,6 +219,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
> >   * It's recommended to call device_property_count_u64() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -233,6 +249,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
> >   * It's recommended to call device_property_string_array_count() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> > + *
> >   * Return: number of values read on success if @val is non-NULL,
> >   *	   number of values available on success if @val is NULL,
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -257,6 +275,8 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
> >   * Function reads property @propname from the device firmware description and
> >   * stores the value into @val if found. The value is checked to be a string.
> >   *
> > + * In order to check for the property presence, use device_property_present().
> > + *
> >   * Return: %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> >   *	   %-ENODATA if the property does not have a value,
> > @@ -324,6 +344,8 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
> >   * It's recommended to call fwnode_property_count_u8() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -353,6 +375,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
> >   * It's recommended to call fwnode_property_count_u16() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -382,6 +406,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
> >   * It's recommended to call fwnode_property_count_u32() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -411,6 +437,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
> >   * It's recommended to call fwnode_property_count_u64() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: number of values if @val was %NULL,
> >   *         %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -440,6 +468,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
> >   * It's recommended to call fwnode_property_string_array_count() instead of calling
> >   * this function with @val equals %NULL and @nval equals 0.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: number of values read on success if @val is non-NULL,
> >   *	   number of values available on success if @val is NULL,
> >   *	   %-EINVAL if given arguments are not valid,
> > @@ -476,6 +506,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
> >   * Read property @propname from the given firmware node and store the value into
> >   * @val if found.  The value is checked to be a string.
> >   *
> > + * In order to check for the property presence, use fwnode_property_present().
> > + *
> >   * Return: %0 if the property was found (success),
> >   *	   %-EINVAL if given arguments are not valid,
> >   *	   %-ENODATA if the property does not have a value,
> 
> -- 
> Kind regards,
> 
> Sakari Ailus
