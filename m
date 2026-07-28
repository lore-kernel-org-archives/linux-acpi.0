Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87640BCB7
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227888; cv=none; b=NoF3xBIDR5oL7r9ysyRboyxJFMDmXxIe38F5/GizScsm/lkMRWL4zUNePsR+gfPkiuJI9iP274zeFAVLwovL6J7qD+MBCEJKmj8myEKjNQL+jVU8WLtu0myTA2dmwxXd/JQPfpqEdsp4ck35VV7BqvjxfcWdDC8YmTt0Cax+KpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227888; c=relaxed/simple;
	bh=oGoFlCKev//ck/cDlJvBrIE/4hPG1W4/xzC6Aug7BXw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1pvMswzgZJengtrAT2LoMcdUfZG5Py+lpX5I5eb8YrFBOAUMYvdtYY63UUJ4TjtTUx6hNDivzHot88ETrsFldADpFC26KNTEuK7ofbHXs+4kod3pGnUHg4EBs9y2tcRTl/bYh9qB5q04IbQ7VJLtArQ5MFT5dOVMXyECvIXwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU4EF1Y1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU4EF1Y1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A621F000E9
	for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785227886;
	bh=ixApoO0p0A87cDeKPtH+KfiUOtiwmHvmcBvPYKgN/Ew=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AU4EF1Y1aPiNvZdn7RQEuOZHfwgoW+vkQZMoaqwBIuLN/bJk+q/JseSW+6d+gjrns
	 /cFdpRNqnjbPB/B0ahz5n7pBWnpm6OwJ7sDEMph49YNkhC6VoOrM5CmPjBsDs/H1yX
	 FjwQrlJWpudBGn0+U8Q37D1sCxoxUr54JjaE/rYFSSqrZ8xQquo5B2BeXMOR9hYEzd
	 tDE9pzbotd1uMULrKN9XuTQLRqVU2eMcNAJyYg0Yi+lulpOmdTrJt5OipPHJj13CvJ
	 Qt/P6HKZLkd5ZOs2/1o3w9gbgPGjeR1sDMU3WKXaWID7r/VhhphjUSUWDhKsKwuk/N
	 bOpz7VS9/IcfA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3535238e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jul 2026 01:38:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YyRGF2Igyz11ZPWev1+FcXrlXY1OIdJT8Ih07QgvY4ZNDOX9ouU
	5jpEi/1Ol7buekJBQj2TltLh1QCWEwazdjdWCg6+jJvUZM8p/wI0T+ZuPRkzAvBbBU8cavB86Gw
	O0CNEXlMj7tqEd/cbD1HwyY56viyrg79LHvJxKsHYZw==
X-Received: by 2002:a05:6512:3d18:b0:5b0:e14:777c with SMTP id
 2adb3069b0e04-5b2d0226797mr291279e87.22.1785227885493; Tue, 28 Jul 2026
 01:38:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:38:03 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 01:38:03 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260727202748.2232253-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727202748.2232253-1-dakr@kernel.org>
Date: Tue, 28 Jul 2026 01:38:03 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeAWLS4tZ7NxTZX58fAL_Jh+ATj4rwumUsNOCv8_bGm1Q@mail.gmail.com>
X-Gm-Features: AUfX_mxfydpQ-ICn1dyEJbgXkqSDGdxad6RoITVNK5FFHG_uJKE4sQX9mllqd5I
Message-ID: <CAMRc=MeAWLS4tZ7NxTZX58fAL_Jh+ATj4rwumUsNOCv8_bGm1Q@mail.gmail.com>
Subject: Re: [PATCH] fwnode: add missing kernel-doc for struct
 fwnode_operations members
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, rafael@kernel.org, 
	andriy.shevchenko@linux.intel.com, djrscally@gmail.com, 
	heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com, 
	brgl@kernel.org, rdunlap@infradead.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 22:27:40 +0200, Danilo Krummrich <dakr@kernel.org> said:
> Document the four undocumented struct members in
> struct fwnode_operations: device_dma_supported, device_get_dma_attr,
> iomap, and irq_get.
>
> This avoids kernel-doc warnings once include/linux/fwnode.h is included
> in the driver-api infrastructure documentation.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  include/linux/fwnode.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 4e86e6990d28..a9dcaf7e7076 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -117,6 +117,8 @@ struct fwnode_reference_args {
>   * @put: Put a reference to an fwnode.
>   * @device_is_available: Return true if the device is available.
>   * @device_get_match_data: Return the device driver match data.
> + * @device_dma_supported: Return true if DMA is supported.
> + * @device_get_dma_attr: Return the device DMA attribute.
>   * @property_present: Return true if a property is present.
>   * @property_read_bool: Return a boolean property value.
>   * @property_read_int_array: Read an array of integer properties. Return zero on
> @@ -134,6 +136,8 @@ struct fwnode_reference_args {
>   *			       endpoint node.
>   * @graph_get_port_parent: Return the parent node of a port node.
>   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
> + * @iomap: Map the I/O memory of a given index for a fwnode.
> + * @irq_get: Get the IRQ of a given index for a fwnode.
>   * @add_links:	Create fwnode links to all the suppliers of the fwnode. Return
>   *		zero on success, a negative error code otherwise.
>   */
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
