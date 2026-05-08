Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5344CA45
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266077; cv=none; b=j+Q/XRXXjaLOCtfXkmg5e6l+McEZape0dMgG7T/Qf4tAXaTcWeUWieQR8vDoEGpp43u7QMdHnoQ7DSZ9vLMvwNl5iohqgiz3xr+6UwL1dPhF0enaRRacoiV7EXRu8bHHLPtAbnyTepUdFFUrS1MKz8FiUh7a/sCGJk0dCE3s1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266077; c=relaxed/simple;
	bh=7jpoG7kUm+k+fpqP2bCJreu5zXQDZII0qcCjSs2ODLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEitg45oZJwyRdWsK5Xrx+WAM7k0bcw6sHiu872Yg/C1r077nLVHOC8i0Bi8pb8uc9istgKEKEHvjkzN5RkAayqqCAkPfQiPZq12xvSAPBBcQRh2aumTCqf2SYY2jqlCeuk9hubd9STbyUKL7BJcQIOJrGda4Nh9Jjmu/1ld7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2dWVDH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2dWVDH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4F0C2BCF4
	for <linux-acpi@vger.kernel.org>; Fri,  8 May 2026 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266077;
	bh=7jpoG7kUm+k+fpqP2bCJreu5zXQDZII0qcCjSs2ODLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d2dWVDH8VGMfzunN1nwLfstC7kJIIV8/giCrtjdmnNuNwYFUCqtYarUtJ/+StKtQS
	 lo0ogd5ajyiTjeh1d/bD932VSvJNsmpRPf2vgyKBN9nPPSOKaRyNrMG1+7epK1OXX3
	 5FSM9pRMf2WSMELSUgOnrQLzHBJdt/A8Sly+o9H7z45HpTaV5MVodPWZbwwG4eThS7
	 z5u10urD/8opaoVB1yUEaowna+UXEQPvr2oaSNqW9+SK1tH+BHObtXVPFFC4nGVHe3
	 E0ara+LLS/30O94IePOKt/tsaSNWDD6H5Ongr+kBqFWZOT4xhbW9Y2Zso1ZPxFzmVo
	 75llra0R6ldZw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a865d1547aso3193062e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2026 11:47:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8G49kS7xk0//8+jG81218TtTReNxL15/o1KRxne65Sy4YaQIah3I2mnaHa9oR189nzLwwddK8cj/u/@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsRxBhtKacXGDKy0qQ+7/vmfICL4g03wJjgmFbqEA5txioyN0
	jSYytdILyRToYUnR5SfvbPf9cMRJn2n7y6NJUOXQdut7pF+b3l/GtKr+9/mezJFqD48jRHJ+h42
	6jocOWZG/q9MclGKMp+AjCFyjiAXKKpc=
X-Received: by 2002:a05:6512:308e:b0:5a8:8814:5662 with SMTP id
 2adb3069b0e04-5a899b8fc0emr3746893e87.4.1778266075925; Fri, 08 May 2026
 11:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427131825.15793-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260427131825.15793-1-bartosz.golaszewski@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 8 May 2026 20:47:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAiM03j57MSgjxz-yO2_a7JngfG6F35V2Yxs0GMmq1_w@mail.gmail.com>
X-Gm-Features: AVHnY4JOQ5kSDJUQvKVr0nREtX0aKgzABMTYh_cjR2bJqKcjyBvdhQnAqI0U6tM
Message-ID: <CAJZ5v0jAiM03j57MSgjxz-yO2_a7JngfG6F35V2Yxs0GMmq1_w@mail.gmail.com>
Subject: Re: [PATCH v2] software node: provide wrappers around kobject_get/put()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 3:18=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Make the code more readable by avoid constant dereferencing of the
> swnode's kobject when managing references. Provide wrappers that take
> struct swnode * as argument and make them hide that logic.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - Make swnode_get() return the address of the swnode whose refcount it
>   bumps and use that fact in software_node_get()

No issues found, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

>  drivers/base/swnode.c | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index a19f8f722bc8e..869228a65cb36 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -374,20 +374,28 @@ EXPORT_SYMBOL_GPL(property_entries_free);
>  /* ---------------------------------------------------------------------=
----- */
>  /* fwnode operations */
>
> -static struct fwnode_handle *software_node_get(struct fwnode_handle *fwn=
ode)
> +static struct swnode *swnode_get(struct swnode *swnode)
>  {
> -       struct swnode *swnode =3D to_swnode(fwnode);
> -
>         kobject_get(&swnode->kobj);
>
> +       return swnode;
> +}
> +
> +static void swnode_put(struct swnode *swnode)
> +{
> +       kobject_put(&swnode->kobj);
> +}
> +
> +static struct fwnode_handle *software_node_get(struct fwnode_handle *fwn=
ode)
> +{
> +       struct swnode *swnode =3D swnode_get(to_swnode(fwnode));
> +
>         return &swnode->fwnode;
>  }
>
>  static void software_node_put(struct fwnode_handle *fwnode)
>  {
> -       struct swnode *swnode =3D to_swnode(fwnode);
> -
> -       kobject_put(&swnode->kobj);
> +       swnode_put(to_swnode(fwnode));
>  }
>
>  static bool software_node_property_present(const struct fwnode_handle *f=
wnode,
> @@ -493,7 +501,7 @@ software_node_get_named_child_node(const struct fwnod=
e_handle *fwnode,
>
>         list_for_each_entry(child, &swnode->children, entry) {
>                 if (!strcmp(childname, kobject_name(&child->kobj))) {
> -                       kobject_get(&child->kobj);
> +                       swnode_get(child);
>                         return &child->fwnode;
>                 }
>         }
> @@ -737,7 +745,7 @@ software_node_find_by_name(const struct software_node=
 *parent, const char *name)
>                 swnode =3D kobj_to_swnode(k);
>                 if (parent =3D=3D swnode->node->parent && swnode->node->n=
ame &&
>                     !strcmp(name, swnode->node->name)) {
> -                       kobject_get(&swnode->kobj);
> +                       swnode_get(swnode);
>                         break;
>                 }
>                 swnode =3D NULL;
> @@ -835,13 +843,13 @@ swnode_register(const struct software_node *node, s=
truct swnode *parent,
>                                            parent ? &parent->kobj : NULL,
>                                            "node%d", swnode->id);
>         if (ret) {
> -               kobject_put(&swnode->kobj);
> +               swnode_put(swnode);
>                 return ERR_PTR(ret);
>         }
>
>         /*
>          * Assign the flag only in the successful case, so
> -        * the above kobject_put() won't mess up with properties.
> +        * the above swnode_put() won't mess up with properties.
>          */
>         swnode->allocated =3D allocated;
>
> @@ -978,7 +986,7 @@ void fwnode_remove_software_node(struct fwnode_handle=
 *fwnode)
>         if (!swnode)
>                 return;
>
> -       kobject_put(&swnode->kobj);
> +       swnode_put(swnode);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
>
> @@ -1002,7 +1010,7 @@ int device_add_software_node(struct device *dev, co=
nst struct software_node *nod
>
>         swnode =3D software_node_to_swnode(node);
>         if (swnode) {
> -               kobject_get(&swnode->kobj);
> +               swnode_get(swnode);
>         } else {
>                 ret =3D software_node_register(node);
>                 if (ret)
> @@ -1044,7 +1052,7 @@ void device_remove_software_node(struct device *dev=
)
>                 software_node_notify_remove(dev);
>
>         set_secondary_fwnode(dev, NULL);
> -       kobject_put(&swnode->kobj);
> +       swnode_put(swnode);
>  }
>  EXPORT_SYMBOL_GPL(device_remove_software_node);
>
> @@ -1097,7 +1105,7 @@ void software_node_notify(struct device *dev)
>         if (!swnode)
>                 return;
>
> -       kobject_get(&swnode->kobj);
> +       swnode_get(swnode);
>         ret =3D sysfs_create_link(&dev->kobj, &swnode->kobj, "software_no=
de");
>         if (ret)
>                 return;
> @@ -1119,11 +1127,11 @@ void software_node_notify_remove(struct device *d=
ev)
>
>         sysfs_remove_link(&swnode->kobj, dev_name(dev));
>         sysfs_remove_link(&dev->kobj, "software_node");
> -       kobject_put(&swnode->kobj);
> +       swnode_put(swnode);
>
>         if (swnode->managed) {
>                 set_secondary_fwnode(dev, NULL);
> -               kobject_put(&swnode->kobj);
> +               swnode_put(swnode);
>         }
>  }
>
> --
> 2.47.3
>
