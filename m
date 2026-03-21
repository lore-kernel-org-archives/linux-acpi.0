Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB84A23
	for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774076497; cv=none; b=faiF20rI9LDHvAvzLSwKvt5DhdIK3SjmJGYuTxLue2ZmscCAiiO6QEG9op0IMKd3WAmhHURlQwGWh9iDUsvOI5JAcC3JAhV0T69mmJGCcf/YldwiaiMRV6lyBAPUgpncB75U6kGJGPQDTGKBiwd2OkoHzyXOsgu4ETiWmJMAIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774076497; c=relaxed/simple;
	bh=nccF5SellD3jrgeb45QpRhAPgHb/WG7fl3nuIZoLBwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck2NbOzkRJwTIxQhQ25eWz4eZUdujJBZExQ/iTKgdCV68JIBN2U8hyVogcIodDhSmocH4KIrEqvXCAG0/3LxRSbf92+mMihQGGpD0pIn08C9anNPS4h4sU7prEscBctQyJoOEnxjYsmOXoXaNlL/TBl8cxrl5PRIa5wLXEUS83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb+hvH1z; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb+hvH1z"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3077077eec.0
        for <linux-acpi@vger.kernel.org>; Sat, 21 Mar 2026 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774076495; x=1774681295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WW/Es4BMtk/hQWwGJpeAz0GKoIYwIQk7tyAslfgFI7Y=;
        b=nb+hvH1z+loBpRELxR3QnRNNyIn3En4Fu+am1fbhQufTGE5L5nN6Aodb1pDlZpRjKH
         fAKL7RNz1wLlDHzpm9sEw02mMceIm5WUp7ZT5fvRjK6H4BYkx2tT3Krt4lJYdgHYCez2
         8VgJQFibribjs9pO5Rf7pp/lmWlLkzd+WDNhus5Y38C6TND1C9VIvoEnX7k5a5xCM8UF
         EBzhTGeG5+bDZ2EZB62GG+HiciZvqCBbmiM+OdLGK9w/4CcXo+ZlqGMB3i4xrirNreYP
         BE575F8aWLN2fgN3sdyNJG0FuUpPfKSI2OalhWLgx+BZWskxIlIN/lQQUnpKqYIwjd2R
         fLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774076495; x=1774681295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW/Es4BMtk/hQWwGJpeAz0GKoIYwIQk7tyAslfgFI7Y=;
        b=P97DnuUCFM5YaSRmt87++dJUCNAoA2b+fmLGUEMHr5gyxRbGG7U/s8Zw4ljVhAlZH/
         LBmP7t34AqcZjHXyWNYv0FrxDXpOG564g+OM8ICDoSQz+MJ8b694ekLrRJ/4UBPmJqp+
         5nv7o8LRYUfOKCfJWmQjioxJ7xoJhyAMtmV6UcrPOzjeKEA6rQIvPYhLzHpEKqChE6dk
         oZJloHP2Rc/aUQoWekngEwinz6ilhy4sHmc1Wfu7ZpPAlpFx6269iK2qwFUacWIJLU3Z
         0Us2o/u9OJVVUa2LWPVC/pFaudK69oFwc8EKxsk7DpYPvk8RsZNHfi/vy+QjXwVxz60E
         OTLg==
X-Forwarded-Encrypted: i=1; AJvYcCWYyuVQwUif3d4QNPmTpEBtVXzhQuy1jsgwldeQfbOydPY+8T/CXSQeAR/lFpP4olaTVxVoRovNCI8r@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI/+VGnzLXfMtb0hAcMIZgdeGuqRYsPN3gxwZKNm33xV7SP3R
	WWjVbNhD5qRc596Uoczr29dnkswXPpRsquO7zDzg0EZPtvFdAQcoMb3Y
X-Gm-Gg: ATEYQzzLC7ebR1vngSBLY3Jusun+Jm37jz9eJJ2voODYb3Ml8cQwvCb3arOvzFfgUhx
	CcmG9nb3664rdAf0wlG8Q9d8oYVLGu+noxF5YOElHNw8aZOeB1ucQsAFywKEWf1I0x1VCQvrxzU
	HXi6dWUm6NqZVTuqSMZwn2Y2b0W5P8FUFuj0FuuSnXlIyn6ib2UjsuVHVK2AERagrX62BRsoNT1
	xQVQIKFRsIY/mZAjv6yypGFBWA1U9ExVESBUKVc/8jfwBrM2FhwdDN8SeVTCIKQvKYO4ZRYCCYQ
	oAjvP1Sm9NTr0dls1KuFo6pW+WbZee0ZRexj0dPbNDb5H1k2yXec8ew4L69nSnCXF3zSiebVY8F
	SoWoqjd1D/XZc2JispF2SGSc07n2+K5Rzx2vLsxeeW92/SQZjk+KWnHuGDJmeTVo1l1fjuG4/qy
	r2xSYOJIjwDqEpHjA307h0C6WgcpF1Cj+cOnWA66l3Ia9OG8ngZZLGaifeae9rNNIR
X-Received: by 2002:a05:7300:4342:b0:2ae:5e93:b69 with SMTP id 5a478bee46e88-2c1097a59f3mr3100399eec.29.1774076495235;
        Sat, 21 Mar 2026 00:01:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:9f7e:6d98:a88f:a990])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2ce04asm6376554eec.21.2026.03.21.00.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:01:34 -0700 (PDT)
Date: Sat, 21 Mar 2026 00:01:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 0/4] platform/x86: x86-android-tablets: use real firmware
 node references with intel drivers
Message-ID: <ab47QXIYCo3vNI8J@google.com>
References: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>
 <abyje0mhIOtDZbxO@google.com>
 <CAMRc=McPQq6QxJ48zk7kxA+kwc=Em8dsFfyECJXg0asY-+pRiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McPQq6QxJ48zk7kxA+kwc=Em8dsFfyECJXg0asY-+pRiw@mail.gmail.com>

On Fri, Mar 20, 2026 at 01:33:06PM -0700, Bartosz Golaszewski wrote:
> On Fri, 20 Mar 2026 02:49:02 +0100, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> said:
> > Hi Bartosz,
> >
> > On Thu, Mar 19, 2026 at 05:10:53PM +0100, Bartosz Golaszewski wrote:
> >>
> >> This series proposes a solution in the form of automatic secondary
> >> software node assignment (I'm open to better naming ideas). We extend
> >> the swnode API with functions allowing to set up a behind-the-scenes bus
> >> notifier for a group of named software nodes. It will wait for bus
> >> events and when a device is added, it will check its name against the
> >> software node's name and - on match - assign the software node as the
> >> secondary firmware node of the device's *real* firmware node.
> >
> > The more I think about the current approaches with strict identity
> > matching the less I like them, and the reason is that strict identity
> > matching establishes rigid links between consumers and producers of
> > GPIOS/swnodes, and puts us into link order hell. For example, I believe
> > if andoird tablets drivers were in drivers/android vs
> > drivers/platform/... the current scheme would break since the nodes
> > would not be registered and GPIO lookups would fail with -ENOENT vs
> > -EPROBE_DEFER.
> >
> 
> Why would they not get registered? They get attached when the target devices
> are added in modules this module depends on. They are exported symbols so the
> prerequisite modules will get loaded before and the module's init function
> will have run by the time the software nodes are referred to by the fwnode
> interface at which point they will have been registered with the swnode
> framework.

I mentioned link order, which implies no modules are involved. When code
is built into the kernel initialization follows link order, which is
typically alphabetical. To ensure the order you require you either need
to move targets inside makefiles or change some drivers from
module_init() to <some other>_initcall(). This is known as "link order
hell" that was very common before deferred probing was introduced.

> 
> > Given that this series somewhat re-introduces the name matching, I
> > wonder if we can not do something like the following (the rough draft):
> >
> 
> I'm open to better ideas and possibly multiple matching mechanisms but this
> just fit in this particular case. I'm not overly attached to name matching. We
> may as well use whatever properties ACPI provides to identify the devices and
> assign them their swnodes.

What ACPI has to do with this? Oftentimes we are dealing with non x86
systems.

> 
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 51320837f3a9..b0e8923a092c 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -509,6 +509,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
> >  	struct swnode *swnode = to_swnode(fwnode);
> >  	const struct software_node_ref_args *ref_array;
> >  	const struct software_node_ref_args *ref;
> > +	const struct software_node *ref_swnode;
> >  	const struct property_entry *prop;
> >  	struct fwnode_handle *refnode;
> >  	u32 nargs_prop_val;
> > @@ -550,7 +551,10 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
> >  		refnode = software_node_fwnode(ref->swnode);
> >  	else if (ref->fwnode)
> >  		refnode = ref->fwnode;
> > -	else
> > +	else if (ref->swnode_name) {
> > +		ref_swnode = software_node_find_by_name(NULL, ref->swnode_name);
> > +		refnode = ref_swnode ? software_node_fwnode(ref_swnode) : NULL;
> > +	} else
> >  		return -EINVAL;
> >
> >  	if (!refnode)
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index e30ef23a9af3..44e96ee47272 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -363,6 +363,7 @@ struct software_node;
> >  struct software_node_ref_args {
> >  	const struct software_node *swnode;
> >  	struct fwnode_handle *fwnode;
> > +	const char *swnode_name;
> >  	unsigned int nargs;
> >  	u64 args[NR_FWNODE_REFERENCE_ARGS];
> >  };
> > @@ -373,6 +374,9 @@ struct software_node_ref_args {
> >  			   const struct software_node *: _ref_,	\
> >  			   struct software_node *: _ref_,	\
> >  			   default: NULL),			\
> > +	.swnode_name = _Generic(_ref_,				\
> > +				const char *: _ref_,		\
> > +				default: NULL),			\
> >  	.fwnode = _Generic(_ref_,				\
> >  			   struct fwnode_handle *: _ref_,	\
> >  			   default: NULL),			\
> >
> > This will allow consumers specify top-level software node name instead
> > of software node structure, and it will get resolved to concrete
> > firmware node. GPIOLIB can continue matching on node identity.
> >
> > WDYT?
> >
> 
> I think it's bad design and even bigger abuse of the software node concept.
> What you're proposing is effectively allowing to use struct software_node as
> a misleading string wrapper. You wouldn't use it to pass any properties to
> the device you're pointing to - because how if there's no link between them -
> you would just store an arbitrary string in a structure that serves
> a completely different purpose.

I think you completely misunderstood the proposal. We are not using
software node as a string wrapper, we give an opportunity to use
software node name to resolve to the real software node at the time we
try to resolve the reference. The software node is still expected to be
bound to the target device (unlike the original approach that has a
dangling software node which name expected to match gpiochip label).

I think this actually a very good approach: it severs the tight coupling
while still maintains the spirit of firmware nodes being attached to
devices. The only difference we are using object's name and not its
address as starting point. Similarly how you use name derived from
device name to locate and assign secondary node in this patch series.

> 
> Which is BTW exactly what was done in GPIO and - while there's no denying that
> I signed-off on these patches - it goes to show just how misleading this design
> is - I was aware of this development and queued the patches but only really
> understood what was going on when it was too late and this pattern was
> copy-pasted all over the kernel.
> 
> Software nodes are just an implementation of firmware nodes and as such should
> follow the same principles. If a software node describes a device, it should be
> attached to it

Yes, and the patch above solves this.

> so that references can be resolved by checking the address of
> the underlying firmware node handle and not by string matching. I will die on
> that hill. :)

I would like to understand why. I outlined the problems with this
approach (too tight coupling, needing to export nodes, include
additional headers, and deal with the link order issues, along with
potential changes to the system initialization/probe order). What are
the drawbacks of name matching as long as we do not create
dangling/shadow nodes?

You are saying that you want resolve strictly by address, but have you
looked at how OF references are resolved? Hint: phandle is not a raw
address. It's actually a 32 bit integer! Look at ACPI. It also does not
simply have a pointer to another ACPI node there, the data structure is
much more complex.

So why are you trying to make software nodes different from all the
other firmware nodes?

> 
> If you want to match string, use GPIO lookup tables. I remember your point about
> wanting to use PROPERTY_ENTRY_REF() for consistency and fully support it, but
> please do use *references* because otherwise it's just a lookup table with extra
> steps.
> 
> Just think about it: what if we try to generalize fw_devlink to software nodes?
> It would be completely broken for the offending GPIO users because there's no
> real link between the software nodes supposedly pointing to the GPIO
> controllers and the controllers themselves.

There is, you just misunderstood the proposal I'm afraid.

Thanks.

-- 
Dmitry
