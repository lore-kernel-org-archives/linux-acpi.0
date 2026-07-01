Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F152C234E
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895049; cv=none; b=AYD4g17XW6VEuQraL6OdiUzurvkrDUNzuvopNZEIpC8Puwi9T5hv4fsYiqJFuUZDmyxTksatiSpQSYIaPmrQhQZTu6Zcwf8M3WpNHfCdE6mKJ9YIzmzG16/hRsJ8d/O0sUIGqVn4CeABwxDCOLo+1XCmRqFaAtrIRH0qNIjV12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895049; c=relaxed/simple;
	bh=ByJ5/y4qkFKKI7iccEBdvZEPCxX8+EHKNVx9SBE1CIg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiGUTYokr8UJuLxRVyFQMaAhnFtO282DzTZXNE0q5EPOKdvQJ1dB74u+8s1fQ8lF4sf3yGLkHRO72SI99PgBbr2ysFGuow9DT1GRkWtxcznKuEtmGOQVSmNlPyA+r/AILKsg/kxi7bmOpRW9h5MGQoM6wCQWBfy+RPS0FuIt/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJo5/fxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJo5/fxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D31F000E9
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782895047;
	bh=Gs3R9+ND2ZDaNduvAqcfQmykzsFEh229fLs4IinEL+A=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=GJo5/fxK40RfgzQ7oeXKfg83dEamMpIDKTp2+xae2wbxYWB+cgfU2Y+Qhu3hkSE7l
	 d4wwbKKnRcQ9anAC2EInGnhnI5qR5pEYDGKyBPemVhNVC+8kvNNmfm12DrvT7bqPLR
	 v8OU6nKchge2Pq0acRroSpqaB9ipFWcncTI9wOpqEXZ1y8/lIXICTjBaSBJXJPzoR5
	 dF0eQWhTJj9ZUeZw8XcG1Bm/3H9mE5UIeCcUZTvHFU3MdaHCi9eWzIc+mWG40UTMFL
	 x9jDR675sd788grZdMdPZZvwZz3MAw9e48MLKSH9bnkdcG+2H1ffUtmaOdgLzHbJ4G
	 HV4wQmOt7wATQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aebf162770so1227574e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2026 01:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpfLQHJYm+ivxGi1iadXEBiii31aiMKLX91H/+C3URl8U/OI2arcm1U/SkfsFaxbTZTQis73csZ+u/M@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPDsu2tFNrTyOrnngetNLP8jSSleOaU7SUpgBO0FgBYZutVCD
	Qq2z9TRLj7TcXD29PcQByYMF2a29RAL6izzGK9UyHEU1AL7ddLgsj3l4kOjMDZjz/cloLA8nWRE
	xc9Z9BlSKoW/sjR8oGnHsRhlY2WOzCeKoyNxwO/BfYg==
X-Received: by 2002:a05:6512:3051:b0:5ad:5ba7:5c2d with SMTP id
 2adb3069b0e04-5aebf97f9cbmr1228469e87.25.1782895045885; Wed, 01 Jul 2026
 01:37:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:37:24 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:37:24 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Date: Wed, 1 Jul 2026 04:37:24 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdjuQf1s7UVPfK+08ongd1VebQ6dTNQrBbxKi_GybM+xg@mail.gmail.com>
X-Gm-Features: AVVi8CeRIdl01nZmyb1PTcHikGLOiBPDRdSk3BMv1GnmOTwYm6bwLxNk87w4dSc
Message-ID: <CAMRc=MdjuQf1s7UVPfK+08ongd1VebQ6dTNQrBbxKi_GybM+xg@mail.gmail.com>
Subject: Re: [PATCH v2] software node: Only the managing device can
 unreference managed software node
To: mike.isely@cobaltdigital.com
Cc: Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Mar 2026 22:13:47 +0100, mike.isely@cobaltdigital.com said:
> From: Mike Isely <mike.isely@cobaltdigital.com>
>
> Explanation here is lengthy because the problem is subtle.
>
> A scenario exists where device_create_managed_software_node() is used
> to create an swnode instance that will be implicitly shared to a child
> device despite best intentions not to permit such sharing (per the
> comment in device_create_managed_software_node()).  I encountered this
> with the sfp kernel module when it was instantiated with properties
> via a call to platform_device_register_full() - it will create hwmon
> child devices which get all property references.  Unfortunately with
> just a "managed" boolean in struct swnode handling this, then
> kobject_put() gets called for the managed aspect when the child device
> goes away instead of the parent.  This leads to premature freeing of
> the swnode structure, followed by use-after-free problems, heap
> corruption, and generally chaos / crashes / misbehavior in the kernel.
>
> This commit changes that boolean into a pointer to the actual managing
> struct device, which is then checked against the struct device
> instance that is actually going away (via the usual call back into
> software_node_notify_remove()).  Thus the child device removal is
> ignored as it should, and we only do the kobject_put() when the actual
> managing struct device instance goes away.  We effectively carry a
> little bit more information now so that we can be sure to clean up
> only when the correct struct device instance is actually going away.
>
> Note that while we are now keeping a pointer to a struct device here,
> this is safe to do because the pointer itself only stays in use while
> the pointed-to device remains valid.  (So no need to be concerned
> about additional reference counting.)
>
> Here's a succinct, generic sequence that spells out the steps which
> lead to trouble:
>
>   1. Somebody creates a struct device instance.
>
>   2. Somebody calls device_create_managed_software_node() associating
>   it with that struct device instance.  This causes two kobject
>   references to be counted against the swnode instance (one for the
>   struct device and one because the managed flag was set).  refcount=2
>
>   3. Some time later, a child struct device is created and the
>   properties of the parent are shared with the child.  This causes
>   another kobject reference to be counted against the swnode instance.
>   refcount=3
>
>   4. Some time later, that child struct device instance goes
>   away (perhaps due to a hotplug removal).  During the tear-down,
>   software_node_notify_remove() notices that the managed field of the
>   swnode instance is set, so TWO kobject references are removed
>   instead of the single reference created by the previous step.
>   refcount=1
>
>   5. Repeat step 3.  refcount=2
>
>   6. Repeat step 4.  refcount=0
>
>   7. Now the kobject reference count inside the swnode instance has
>   dropped to zero and so the swnode instance is released.  Notice that
>   the parent device is still holding a physical reference, now
>   pointing into freed memory.  Chaos likely follows.  If lucky, a NULL
>   pointer kernel oops is the result.
>
> The patch fixes this by causing step 4 to only do the second reference
> decrement if the device being torn down is the same one that
> established the managing relationship in the first place.  Then
> everything stays balanced.
>
> I confirmed this exact sequence of behavior in the context of the sfp
> kernel module with appropriate printk debug trace added, when
> instantiated with platform_device_register_full() with properties
> provided.  While that's may be hard for to reproduce without sfp
> hardware, anything else which performs those steps should produce
> similar results.
>
> Note that because platform_device_register_full() will implicitly
> employ a managed swnode instance any time it is passed properties in
> its pdevinfo argument, then by implication anyone calling
> platform_device_register_full() in that manner - which happens in
> multiple other places in the kernel - is at risk for the same issue.
>
> Signed-off-by: Mike Isely <mike.isely@cobaltdigital.com>
> Signed-off-by: Mike Isely <isely@pobox.com>
> ---
>  drivers/base/swnode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 53b3f0061ad12..18a903a35197c 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -36,8 +36,8 @@ struct swnode {
>  	struct list_head children;
>  	struct swnode *parent;
>
> +	struct device *managing_dev;
>  	unsigned int allocated:1;
> -	unsigned int managed:1;
>  };
>
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1060,7 +1060,7 @@ int device_create_managed_software_node(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>
> -	to_swnode(fwnode)->managed = true;
> +	to_swnode(fwnode)->managing_dev = dev;
>  	set_secondary_fwnode(dev, fwnode);
>
>  	if (device_is_registered(dev))
> @@ -1104,7 +1104,7 @@ void software_node_notify_remove(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "software_node");
>  	kobject_put(&swnode->kobj);
>
> -	if (swnode->managed) {
> +	if (swnode->managing_dev == dev) {
>  		set_secondary_fwnode(dev, NULL);
>  		kobject_put(&swnode->kobj);
>  	}
> --
> 2.47.3
>
> ---
>
> Correct issue in drivers/base/swnode.c that can lead to use-after-free
> due to kobject reference counting error, which itself is due to
> incorrect behavior with the "managed" struct swnode flag in
> circumstances involving child struct device instances where the parent
> struct device is managing a struct swnode.
>
> Use-after-free in this case leads to likely kernel heap corruption, so
> any manner of chaos can result, if left unaddressed.
>
>
>

Is there any way to just bump the swnode's reference count when the parent's
fwnode is assigned to the child and decrease it on child's unregister? That
would make a lot more sense IMO.

It would be awesome if you could add a kunit test case for this situation as
well.

Bart
