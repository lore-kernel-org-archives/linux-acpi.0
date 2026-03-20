Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA42359A6B
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038789; cv=none; b=bKcLJQxgtcS1Kn53PrM/othTZbr1hc4cM6FYl1XpfD0HvJ/CjzEKL0Tyo2xH/pa/vsI66SKZrIFP+oXOiAsN4Nnbun8IDB6zg5FTFZR4go+8SRv5nqkX9VMxIcmZmtTkqGfJC2k0d46+BB9pgz9HZk9o28LTJdSHCTkxul07ChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038789; c=relaxed/simple;
	bh=qs4GngI9e5bYN0yw24bfxUbRtUOKCgcW/sntol8xNSQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Heh6Fsa56Yqcd/Mq3VQI6ME/ofEQMElg7lJL11rdYPJQNbrH6UjPQfOnDVMM9xcu+xw9JyYUUirp1nm7XJB41lhHS+NfK4XA/6uKCcBgFRSMsW1NIAHLjA68yhiWVhKbrfEj4IkBSTqFvN2iqRGVtmXYhpKJS/43w70KGuMxsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH5EP67U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH5EP67U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387C5C2BC9E
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774038789;
	bh=qs4GngI9e5bYN0yw24bfxUbRtUOKCgcW/sntol8xNSQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=KH5EP67UY79Oj08pJ/NSsWWv2GlpNqo8bbgbIWxE+gFAmo75UsCFFpRySbcrG0hfX
	 HMp5DQ1oSgdD1bWDVmW/6qQD6v7OVTetypNNVewb6hYvR84jydKw3fojXHEvQ0RZKV
	 nGx1tUIFrndw741C8w7yd2MJVQx1thwng6GGMOCwnxHnzk6ukHTKad3STSOJ2KRGJy
	 NbTzOaQsJWcfzGeOaO+yzidCV5VIaNTueH6Yn1YSpVQi37A/LrSqLvU7WoP4Kvd3U/
	 ktSQYxqXomYR0O2nu+073bisDCqk0Cjsx+KCIWSgqh+DE7Co4oqGZaQ1H9G75wCN8f
	 OQ0/bMNiVGmjQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27c021b58so2525718e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 13:33:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUFKZXKETDGar8Zksua5ueuX7cF0IORan9WCiLacdE5pjgnVYt64DKHy3aMBgumdAHQ4Hln5bObQ2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzCz3fmReArjzjdu9WHfV7rJhyuW514ApWgugGCkHhH5Onj0KEV
	Pr1Ynm2HTLacb1p5i4cYTO0plorca1qfi2t5jlUpug3V/NLDXn8Ns9u3Bl0Os7/pbu+Xj+CgrJL
	yvOvlBQVZAreh6fxYG0olcmeL/Gw/sOvOJ09fDpQRLQ==
X-Received: by 2002:a05:6512:138f:b0:5a2:7ba1:493e with SMTP id
 2adb3069b0e04-5a285af3c08mr1422126e87.13.1774038787586; Fri, 20 Mar 2026
 13:33:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 13:33:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 13:33:06 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <abyje0mhIOtDZbxO@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com> <abyje0mhIOtDZbxO@google.com>
Date: Fri, 20 Mar 2026 13:33:06 -0700
X-Gmail-Original-Message-ID: <CAMRc=McPQq6QxJ48zk7kxA+kwc=Em8dsFfyECJXg0asY-+pRiw@mail.gmail.com>
X-Gm-Features: AaiRm52IPGTKs4RSoWbJCBfU_yKdF9grFXKfUYFJ8mg8u_FCJ7C66rIFHPKFtww
Message-ID: <CAMRc=McPQq6QxJ48zk7kxA+kwc=Em8dsFfyECJXg0asY-+pRiw@mail.gmail.com>
Subject: Re: [PATCH 0/4] platform/x86: x86-android-tablets: use real firmware
 node references with intel drivers
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 02:49:02 +0100, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Hi Bartosz,
>
> On Thu, Mar 19, 2026 at 05:10:53PM +0100, Bartosz Golaszewski wrote:
>>
>> This series proposes a solution in the form of automatic secondary
>> software node assignment (I'm open to better naming ideas). We extend
>> the swnode API with functions allowing to set up a behind-the-scenes bus
>> notifier for a group of named software nodes. It will wait for bus
>> events and when a device is added, it will check its name against the
>> software node's name and - on match - assign the software node as the
>> secondary firmware node of the device's *real* firmware node.
>
> The more I think about the current approaches with strict identity
> matching the less I like them, and the reason is that strict identity
> matching establishes rigid links between consumers and producers of
> GPIOS/swnodes, and puts us into link order hell. For example, I believe
> if andoird tablets drivers were in drivers/android vs
> drivers/platform/... the current scheme would break since the nodes
> would not be registered and GPIO lookups would fail with -ENOENT vs
> -EPROBE_DEFER.
>

Why would they not get registered? They get attached when the target devices
are added in modules this module depends on. They are exported symbols so the
prerequisite modules will get loaded before and the module's init function
will have run by the time the software nodes are referred to by the fwnode
interface at which point they will have been registered with the swnode
framework.

> Given that this series somewhat re-introduces the name matching, I
> wonder if we can not do something like the following (the rough draft):
>

I'm open to better ideas and possibly multiple matching mechanisms but this
just fit in this particular case. I'm not overly attached to name matching. We
may as well use whatever properties ACPI provides to identify the devices and
assign them their swnodes.

> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 51320837f3a9..b0e8923a092c 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -509,6 +509,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  	struct swnode *swnode = to_swnode(fwnode);
>  	const struct software_node_ref_args *ref_array;
>  	const struct software_node_ref_args *ref;
> +	const struct software_node *ref_swnode;
>  	const struct property_entry *prop;
>  	struct fwnode_handle *refnode;
>  	u32 nargs_prop_val;
> @@ -550,7 +551,10 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
>  		refnode = software_node_fwnode(ref->swnode);
>  	else if (ref->fwnode)
>  		refnode = ref->fwnode;
> -	else
> +	else if (ref->swnode_name) {
> +		ref_swnode = software_node_find_by_name(NULL, ref->swnode_name);
> +		refnode = ref_swnode ? software_node_fwnode(ref_swnode) : NULL;
> +	} else
>  		return -EINVAL;
>
>  	if (!refnode)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e30ef23a9af3..44e96ee47272 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -363,6 +363,7 @@ struct software_node;
>  struct software_node_ref_args {
>  	const struct software_node *swnode;
>  	struct fwnode_handle *fwnode;
> +	const char *swnode_name;
>  	unsigned int nargs;
>  	u64 args[NR_FWNODE_REFERENCE_ARGS];
>  };
> @@ -373,6 +374,9 @@ struct software_node_ref_args {
>  			   const struct software_node *: _ref_,	\
>  			   struct software_node *: _ref_,	\
>  			   default: NULL),			\
> +	.swnode_name = _Generic(_ref_,				\
> +				const char *: _ref_,		\
> +				default: NULL),			\
>  	.fwnode = _Generic(_ref_,				\
>  			   struct fwnode_handle *: _ref_,	\
>  			   default: NULL),			\
>
> This will allow consumers specify top-level software node name instead
> of software node structure, and it will get resolved to concrete
> firmware node. GPIOLIB can continue matching on node identity.
>
> WDYT?
>

I think it's bad design and even bigger abuse of the software node concept.
What you're proposing is effectively allowing to use struct software_node as
a misleading string wrapper. You wouldn't use it to pass any properties to
the device you're pointing to - because how if there's no link between them -
you would just store an arbitrary string in a structure that serves
a completely different purpose.

Which is BTW exactly what was done in GPIO and - while there's no denying that
I signed-off on these patches - it goes to show just how misleading this design
is - I was aware of this development and queued the patches but only really
understood what was going on when it was too late and this pattern was
copy-pasted all over the kernel.

Software nodes are just an implementation of firmware nodes and as such should
follow the same principles. If a software node describes a device, it should be
attached to it so that references can be resolved by checking the address of
the underlying firmware node handle and not by string matching. I will die on
that hill. :)

If you want to match string, use GPIO lookup tables. I remember your point about
wanting to use PROPERTY_ENTRY_REF() for consistency and fully support it, but
please do use *references* because otherwise it's just a lookup table with extra
steps.

Just think about it: what if we try to generalize fw_devlink to software nodes?
It would be completely broken for the offending GPIO users because there's no
real link between the software nodes supposedly pointing to the GPIO
controllers and the controllers themselves.

> Also, you need to update the existing documentation in order to be able
> to call the existing documented practice an "abuse" ;)
>

Yes, I should.

Thanks,
Bartosz
