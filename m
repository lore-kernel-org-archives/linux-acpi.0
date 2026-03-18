Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44A36CE16
	for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821083; cv=none; b=VVXUh8q0QSyjG3swDrOYkKZydZj8gqArCFGIOwze69hCnoUwhcJjwFZzrMNgc583H/Nf8DaBU8NVmHvVV2zV8ucNv1IEuyujUWC976j10z7zxhj+7QZER44QGIbI26RKLT8zcn9QhnCHYkBci9HEDJRr6UfQfI/IZhekfw9lPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821083; c=relaxed/simple;
	bh=vO1KfHU6udCVhdGolP+Vsucc5fEMPxLUN7KgAjXoeyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og59a0/0eOBXOslH2RV09NqJIuR1dXii5ljUQ/74oVwbeO3esEQPdquMSbMTzZhG5vdrHfCKmmA/Tv8sPkNQO8ihzzY+T94OMBapbBuEyymQDb3h8aSRLIf5yZ/PFoPyaVueirHo4llT5LzcljAILOrhpykTkZ1upxjXzB8+uEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56b679e72d9so1971485e0c.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 01:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773821078; x=1774425878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htBo4xRilBo5yz/WWU6Hy0WaZEltY58p9V1wJQpVl2w=;
        b=Y+oaP4Z9hJ0VV/JSf9hxef/fAlHvEhR9Wq6Gr/jWAOP8kiIhtIkeH/Rk+kfKqrjVLn
         fl1jUf2iUgeinjrBUgAm0snVkla9oPUKGIdz3HnjaP5RsMJWg+PAleaImbocOJg3naiO
         Aax1iOWsTS7AWGikQuDsyr7ROJDESOoWvSf/YVXhwxL47dQytolK2iC3034j3AlPcl+w
         uGBkn5jdB61W0sI0mvPKCl+NUv6YM305LXn6c4zRfWCSrdknh4pucbYHhGdTf7RsjfpL
         m2n9UxQjGXConaK0UAVgjnPjYuRK0sT8xvNMXmS9JUlm7wUoDSMEpmVAu897WWWQmIVG
         ihvg==
X-Gm-Message-State: AOJu0Yw25KMNWScxRA3UVce5c4xZA4aw4znOzgFeROjbVrrjqRaI2SMX
	gnU/ywmlNSWrEpUnSUxNWv0R/xz9ni6z011bz7jUPgbj6pa4XAfI+4d62aS18V+1o0c=
X-Gm-Gg: ATEYQzzx1NVHh+hXZgi0220Ga9RGmqbRC4FvxFkFm8ZJmJJNr5oTpFv+36UJbDvlE8q
	yqiIplc0hj9B6wUmxB2GVaQN8cfXY7UPwqlXz8JMm1AM6WpBazgOWWsYNUAHRyHua/DGYvXERlT
	NjKgPy3BbbxWzXvnR9gOg+tTTjk84U16KqOI5Iut+PYmy1JH60xBi4QXA6HK+TzWU8cI0zFgNc2
	dLKsWfcnltzlpBQ9UwhMdt3oQuHVX6ukfE+2xDlPSt1NhB9Ej2IyH1LdEo10B2NvAXyUb4767Hi
	NV6b0lm69IF58+rdqmR2/jt5BgyPyttG/S/4Zf01E2u7FEg2EDL2DKTCFDNVHsu4sNL8I9QpDC9
	/TnORiKfug+81OA9/1UhiY8ShUIg43yKHD7KpaiXIjPqxKEZXBYKEyLYBjMqh+41OkLZYqpjwr6
	TAmRslOgoorwhOiCVl/QgambWeN3VY9MH3tFgjXo2I/+6adzbHco0KGVDtin053kHa
X-Received: by 2002:a05:6122:428a:b0:56b:8103:79f6 with SMTP id 71dfb90a1353d-56ba6fe5d50mr1230038e0c.4.1773821077728;
        Wed, 18 Mar 2026 01:04:37 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ba705cb2asm1380800e0c.14.2026.03.18.01.04.37
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 01:04:37 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso2624962e0c.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2026 01:04:37 -0700 (PDT)
X-Received: by 2002:a05:6102:3593:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-6027d0a6617mr1172832137.3.1773821077123; Wed, 18 Mar 2026
 01:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260317210828.2117631-1-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 09:04:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOj=C36-iWsRzY6Cr2eFLvpqi7cA_ebziKKdVCo+125A@mail.gmail.com>
X-Gm-Features: AaiRm52fFj4ja3SGclYxUj6sdp11dKwy3IN0zm7jJH3ap-zU4mNmHSvyveljUE0
Message-ID: <CAMuHMdVOj=C36-iWsRzY6Cr2eFLvpqi7cA_ebziKKdVCo+125A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Document how to check for the
 property presence
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

CC devicetree

On Tue, 17 Mar 2026 at 22:08, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Currently it's unclear if one may or may not rely on the error codes
> returned from the property getters to check for the property presence.
> Clarify this by mass updating kernel-doc for fwnode_property_*() and
> device_property_*() where it's applicable.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: 4b24f1f4-b395-467a-81b7-1334a2d48845@roeck-us.net

Missing "https://lore.kernel.org/" prefix.

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
>                              const char *propname)
> @@ -121,6 +129,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_bool);
>   * It's recommended to call device_property_count_u8() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -149,6 +159,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u8_array);
>   * It's recommended to call device_property_count_u16() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -177,6 +189,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u16_array);
>   * It's recommended to call device_property_count_u32() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -205,6 +219,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u32_array);
>   * It's recommended to call device_property_count_u64() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -233,6 +249,8 @@ EXPORT_SYMBOL_GPL(device_property_read_u64_array);
>   * It's recommended to call device_property_string_array_count() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *        number of values available on success if @val is NULL,
>   *        %-EINVAL if given arguments are not valid,
> @@ -257,6 +275,8 @@ EXPORT_SYMBOL_GPL(device_property_read_string_array);
>   * Function reads property @propname from the device firmware description and
>   * stores the value into @val if found. The value is checked to be a string.
>   *
> + * In order to check for the property presence, use device_property_present().
> + *
>   * Return: %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
>   *        %-ENODATA if the property does not have a value,
> @@ -324,6 +344,8 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
>   * It's recommended to call fwnode_property_count_u8() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -353,6 +375,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u8_array);
>   * It's recommended to call fwnode_property_count_u16() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -382,6 +406,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u16_array);
>   * It's recommended to call fwnode_property_count_u32() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -411,6 +437,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u32_array);
>   * It's recommended to call fwnode_property_count_u64() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values if @val was %NULL,
>   *         %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
> @@ -440,6 +468,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_u64_array);
>   * It's recommended to call fwnode_property_string_array_count() instead of calling
>   * this function with @val equals %NULL and @nval equals 0.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: number of values read on success if @val is non-NULL,
>   *        number of values available on success if @val is NULL,
>   *        %-EINVAL if given arguments are not valid,
> @@ -476,6 +506,8 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
>   * Read property @propname from the given firmware node and store the value into
>   * @val if found.  The value is checked to be a string.
>   *
> + * In order to check for the property presence, use fwnode_property_present().
> + *
>   * Return: %0 if the property was found (success),
>   *        %-EINVAL if given arguments are not valid,
>   *        %-ENODATA if the property does not have a value,
> --
> 2.50.1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
