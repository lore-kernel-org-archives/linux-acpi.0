Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234642;
	b=oNJkK9pLm+UoXA4grSzAOjf5JNrQf+ySP43RABQej8Q/2sRyApaDfQMTBIL7in8IjR0y
	 RSphpnvBMjBzOfP2s190qYVuW7U/uv1r5b+WwnIP5aO4bAFkQuqscnqWjM5IM4knxnvuA
	 mGj0M2NKo+R6hLdyONurSZLaHiRoFDpk9+2JvPvwymtpRY++e3YcXFkVxkbdhVty3sjqQ
	 BZCh3GvFcERz3XnsrKW2ODcsAKmBPfyna1qfH4cGuSqBExfLokkzbwhZs6mW2G8GWuDEk
	 UhFWZKRl5kj5YrbvUA1JuUe5+mDWQsOIu9QaiklfzeYXV6b1lq0jaOUbN1eDPjvAO6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234642;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SOKa7oEiKxu542q5m/5lCLp86l9043bl/suyY3YQPdI=;
	b=B8W616r5wW3EEX74y2CgOWyQ0gx0eA+hFNI/sO+TEswIoNZZ40nOpu+uINpmH2gbsygs
	 O21Sgk7GRfa41MWRXIr6BlQOlY9T7OQquBW8htzvtBERrsmt3x5cM77vdgaLIQEVdoTpR
	 TqHBlr4ddYTzlxGOL2HtFHbGc3V5wJXNPa360EhJ+y7drGEm/gCCYFzwbendN7mXqPARv
	 QqDvysCYUOxpHn5Zq6CJBdJOjrNtknUha5shNpm4sNjD6cJomn3vtnH3Tm5S9s1FCWYtG
	 pBQsjC16VwJWFi6mQl3ZfkDqYTIJWCaXT2ryUwumAegaYDqw55l/N/wolHn9sOu8Y/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7712O4S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6C0D8606A322;
	Mon,  9 Nov 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7712O4S
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2D9F61F0089F;
	Mon,  9 Nov 2026 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234642;
	bh=SOKa7oEiKxu542q5m/5lCLp86l9043bl/suyY3YQPdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m7712O4SyxrLKHUcY9x3mrp6AevG6T/EM5E5/gI8vKjS/Wc8mo4jt21j4n/RqMnVO
	 qb9tvtCoBB4VSSKLamNL6hX9l+4pvngGJkrIeeUaMiPIyKzDiNkXWHZJ4c5y82KP+u
	 5sEtDqUCC3DWDepmCf3n4nYOPyI1vjR7X5XSGhAznsXYbhYSek7kYBmhYyCV6p7gWF
	 7WLwUysj4c9aBBuCv5ln9d36QeCk5Af9eqEucxsNrKkTN5jwbBD3LsG+xdrjA//lEi
	 RuNnAuxdjCV8xp858stpS0UL5Lgndf8/OeRoiCHUlgNVrdPrth2ogGKMikKDtDYlZg
	 iVO19co4PV/SQ==
Date: Mon, 9 Nov 2026 15:30:37 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <zuxfprej3cu63f5a4ljjori2ni5q4onl3qxpweygsyw5lqbdcn@wt2j2n627bop>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <avHMhh8ChrFE_b_e@hovoldconsulting.com>
 <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>

On Mon, Nov 09, 2026 at 03:10:31PM +0100, Danilo Krummrich wrote:
> On Mon Nov 9, 2026 at 2:37 PM CET, Johan Hovold wrote:
> > On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
> >> device_create_managed_software_node() creates a node whose lifetime is
> >> tied to the device it was created for. software_node_notify_remove() is
> >> called for every device that has the node as its fwnode (primary OR
> >> secondary) and, if the node is managed, unconditionally detaches it from
> >> that device and drops the creation reference.
> >> 
> >> This breaks when the node is shared with another device. Example: the
> >> i2c-designware copies the parent's fwnode to the adapter's struct device.
> >> When the adapter is deleted, it releases the reference that belongs to
> >> the owner and the latter ends up with a dangling pointer.
> >> 
> >> Record the device's "manager" and only perform the actual release when
> >> notify is called for that "owner" device.
> >> 
> >> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> >> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> >> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")
> 
> Hm...the documentation of device_create_managed_software_node() does point out
> the limitation that it shouldn't be shared with other devices.
> 
> Now, that's rather fragile and the reason I pointed out [1] it should be
> changed, but it's technically not a fix?
> 
> [1] https://lore.kernel.org/all/DM1FMM3KEYU9.1D26IINII93FO@kernel.org/
>

I don't mind dropping the tag.

> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> >> ---
> >> Hi!
> >> 
> >> This is my approach at addressing the bug reported by Vivekanandan
> >> directly in driver core. Please test it if you can.
> >
> > This looks good to me, but I think the patch should be simplified somewhat.
> >
> >> @@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
> >>  void software_node_notify_remove(struct device *dev)
> >>  {
> >>  	struct swnode *swnode;
> >> +	bool is_owner;
> >>  
> >>  	swnode = dev_to_swnode(dev);
> >>  	if (!swnode)
> >> @@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *dev)
> >>  	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
> >>  		swnode->fwnode.dev = NULL;
> >>  
> >> +	is_owner = swnode->owner && swnode->owner == dev;
> >
> > The NULL check here is redundant.
> >
> >> +	if (is_owner)
> >> +		swnode->owner = NULL;
> >
> > There is no need to clear the owner field as devices are not allowed to be
> > re-registered.
> 
> I guess that's true, but maybe leaving in a defined state is a bit more robust?
> 
> >> +
> >>  	swnode_put(swnode);
> >>  
> >> -	if (swnode->managed) {
> >> +	if (is_owner) {
> >>  		set_secondary_fwnode(dev, NULL);
> >>  		swnode_put(swnode);
> >>  	}
> >
> > And if we drop the managed reference before the notify one, we can drop
> > the temporary as well and this chunk just becomes:
> >
> > @@ -1206,12 +1207,12 @@ void software_node_notify_remove(struct device *dev)
> >         if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
> >                 swnode->fwnode.dev = NULL;
> >  
> > -       swnode_put(swnode);
> > -
> > -       if (swnode->managed) {
> > +       if (swnode->owner == dev) {
> >                 set_secondary_fwnode(dev, NULL);
> >                 swnode_put(swnode);
> >         }
> > +
> > +       swnode_put(swnode);
> >  }
> >
> > The end-result applied for 7.4 (to fix the 7.3 regression) is here:
> 
> A previous reply from Balasubramani suggested to adjust the doc-comment of
> device_create_managed_software_node(), so I thought Bartosz will send a new
> version.
> 

I will, I was just giving it some time on the list.

> Also, are we sure this is -rc material? I think the original commit wasn't
> technically broken and the bug in Xe was fixed otherwise.

We can queue it for v7.5 alright.

Bart
