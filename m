Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231433;
	b=374BUvOPLvZCTiB3qEl2ccTiKzULyBeXEpidSWbfvG3dkAiG42e9DvdFXfeEoHwrR6Ar
	 SR8Ua/Bt96P/DriLQ9vPkulbG1Z1uoddo2861FOrjScDHdIl9Mo6dP8SSiEtNHNN+BB/q
	 hWmE7v0K+xRM9Mn51QkaCeZWTYnNuB+FI49sUZJX1AqIgKSkQYfI5zfp2GDSmntc5H3Xl
	 E9mTzD55gtz0JtgrKwZ5BmD5+/uVz6sa+L2d4LOtEnN2BbehxDUttU72avH/ZZ3GOCveZ
	 st641SQTNM0jOVZiJWD1za4f/LYymPm/YIESpPaYLIlQDSMUrHVmOSR2erhJcnMW+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231433;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1XP/xL6wprFXu/4sOwbnCPUmhNy5zoBYrEw61hir05s=;
	b=0LDczDqvvvVlUtHpOXdIwZ7MY4UufpgT68kwDyGJcdSV/J32XJfjcG17O1K+m1PJy0+r
	 ADR36Hy09Sslfj+NzGmhoFfRpOCQXDEhII9VxOUmwZ7HnEskhCb+/q5UcugLMJMoFKUN5
	 pxYQDtvuIf+Y2HakTi0ZpArpfXpN5chnYayxjlVA8E7McmmqsNyhSFTDNP7n2a+JwkDlg
	 SyyEh+qK94StmjtA+RWwzUcfSfPvKRhI4www7sWV2jQLFWCM2//ZQIPXhP1rOmYm3e8Cv
	 PYprgPc6bcgMwR62zjou3PKUrqpDaaFQTJuP0A50lWInvR3Emty5rkFbxJSncEQRyQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axu63CiT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA00606A31C;
	Mon,  9 Nov 2026 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axu63CiT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23541F0089F;
	Mon,  9 Nov 2026 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231432;
	bh=1XP/xL6wprFXu/4sOwbnCPUmhNy5zoBYrEw61hir05s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=axu63CiT2B4n+m6z3amuPyKUmACa7xNfaa5xPDenPIVyl+VAZHls09okNSdXAH5Fy
	 mDj1dtROSso9FRGkpTVbpPYiIGPg/FM05xjVbDlh4qA/wwUSKG8wV0Ni6n5oWySvrm
	 0OwQp65K9dIJND+CzHSpHZXfwmtx03vxNnjU0eI/2YhtP5oFS8hagKzd4QKlaZkSHV
	 CMwUUt6regCs5NTws5LoKY36c7uR2Ng/FP3utdLx/M3l4heeLMfc1cVQqOZxIetf2+
	 5/rwGqyQThZxYn9tNTPASoFi8oFO2UamP058RlUppNu0jLl/KpQgS6Jr3Jut+m8Twn
	 8Fqd+Y7PFxGnw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQPYc-0000000ADlk-0Hrs;
	Mon, 09 Nov 2026 14:37:10 +0100
Date: Mon, 9 Nov 2026 14:37:10 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <avHMhh8ChrFE_b_e@hovoldconsulting.com>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
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
In-Reply-To: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>

On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
> device_create_managed_software_node() creates a node whose lifetime is
> tied to the device it was created for. software_node_notify_remove() is
> called for every device that has the node as its fwnode (primary OR
> secondary) and, if the node is managed, unconditionally detaches it from
> that device and drops the creation reference.
> 
> This breaks when the node is shared with another device. Example: the
> i2c-designware copies the parent's fwnode to the adapter's struct device.
> When the adapter is deleted, it releases the reference that belongs to
> the owner and the latter ends up with a dangling pointer.
> 
> Record the device's "manager" and only perform the actual release when
> notify is called for that "owner" device.
> 
> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Hi!
> 
> This is my approach at addressing the bug reported by Vivekanandan
> directly in driver core. Please test it if you can.

This looks good to me, but I think the patch should be simplified somewhat.

> @@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
>  void software_node_notify_remove(struct device *dev)
>  {
>  	struct swnode *swnode;
> +	bool is_owner;
>  
>  	swnode = dev_to_swnode(dev);
>  	if (!swnode)
> @@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *dev)
>  	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
>  		swnode->fwnode.dev = NULL;
>  
> +	is_owner = swnode->owner && swnode->owner == dev;

The NULL check here is redundant.

> +	if (is_owner)
> +		swnode->owner = NULL;

There is no need to clear the owner field as devices are not allowed to be
re-registered.

> +
>  	swnode_put(swnode);
>  
> -	if (swnode->managed) {
> +	if (is_owner) {
>  		set_secondary_fwnode(dev, NULL);
>  		swnode_put(swnode);
>  	}

And if we drop the managed reference before the notify one, we can drop
the temporary as well and this chunk just becomes:

@@ -1206,12 +1207,12 @@ void software_node_notify_remove(struct device *dev)
        if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
                swnode->fwnode.dev = NULL;
 
-       swnode_put(swnode);
-
-       if (swnode->managed) {
+       if (swnode->owner == dev) {
                set_secondary_fwnode(dev, NULL);
                swnode_put(swnode);
        }
+
+       swnode_put(swnode);
 }

The end-result applied for 7.4 (to fix the 7.3 regression) is here:
	
	https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-linus&id=95418e71bdcbf8f2073a730365c11d22ff8473f3

Johan
