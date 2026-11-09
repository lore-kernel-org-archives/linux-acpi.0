Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234856;
	b=gyhXg5u+XnEOBdgo2qrukyhz6YHYbB46i15X5wkdzAZFFDBSmUgWNbpS/y2gUj3Y5AHK
	 48v2VJ0unSnOvl9XQ+oqWEnwzGiGWEneIQeu37jc0ZbkPLzGQ3hwQnyqFL4kp6jrNUdXE
	 oTfcMQPnRVNQeftn7S3M/Del3zQkhYmr1f6djj23M1LPQwpdw4+5VdJiEfKzdY2rNjuhh
	 SIWwXa4v/m5DaWON8NkeAJFaRI9U2OkXkdHuClgD5ve85rZz4GzJ9MzsXPt20Fs5coGkP
	 4qulAy7jOU4wWr9IR4g2gTv3tJ5eUgtZunx0KuR5N6RZjx9bDtPf7aLqIdCJc8GY1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234856;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MXUOge+AWBEFFag7YzH/pRk7KNyqCYSxRN8Wb/8+nnY=;
	b=me7EbXYu3/OqLLY5PEDHEoYtHh+m7iom4414hF9ME0ABOB2FLUrGUlciP9NQ+dyMwXg2
	 HH7TlwoKBT96rnxhOC+F06g4HjrswrZt+M84jp/JQZ34k+x/qHmvYGD8ObWdbaYs8TVWj
	 MIvQAln14y1lWnu2ECxRjnrXku0os8uWTPmgw5tpY87hAKXGMX8kQI4zLtkIFYOCQbyhv
	 n04GWclVfhoIqi8cTiimNR1Jm+o7xsLKegBFjO/7maelhbszJlQybk26l9fgcQrD14Cdc
	 FcNdA9aICTKG9cPQNFxqsbJrvn8QKNsEVgKDog2whYputl4mLrVCak+b8WK1gBMMM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivG9l3oI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B97606A322;
	Mon,  9 Nov 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivG9l3oI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFA41F008A2;
	Mon,  9 Nov 2026 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794234856;
	bh=MXUOge+AWBEFFag7YzH/pRk7KNyqCYSxRN8Wb/8+nnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ivG9l3oI+Zx1c4thuDPzbuiV4uX2nceayNude8GGm81t83wuvjO5ZKC+vEgpOszzW
	 nTe6LRUH3b/ipdU6dimc4E3TZ3PTrM95eK/6pnUV/3v9Iw/gzeAJPSO23qhICmmdxn
	 fWAg/P3XzuobrqqVjVDqc2HTmR3CKm/HUsx/ixDsB9lRuRP+B4OZ8Xy2wyhj4Fk2KQ
	 4cPVK3IJt0ujm6OVFHztICoZ0LlveObVwN7OyH75IsMROj+DFT9U30Vy737jK2XQKF
	 sgP7oOTiLJWBHF+WAYRU3ZqN4YiO4L9FxOfVfAI4IsyXew0U0wbQUBok59uIbOGVwJ
	 UkWvWGHqZIlcg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQQRp-0000000AEn1-0nug;
	Mon, 09 Nov 2026 15:34:13 +0100
Date: Mon, 9 Nov 2026 15:34:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
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

It's hard to determine at allocation time whether a node will eventually
end up being reused. That's why added the following clarification to the
commit message:

	Note that it was never the intention that managed software nodes
	would be shared, but descendants reusing ancestor firmware nodes
	is not uncommon and such use is hard to predict when allocating
	software nodes.
 
> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

> > The end-result applied for 7.4 (to fix the 7.3 regression) is here:
> 
> A previous reply from Balasubramani suggested to adjust the doc-comment of
> device_create_managed_software_node(), so I thought Bartosz will send a new
> version.

I missed that comment (and his Reviewed-by tag, will add).

The function still does not return the allocated node and managed nodes
should generally not be shared. The exception would be descendants
reusing ancestor nodes, and that may happen elsewhere in the stack.

So I think the kernel doc is fine as-is, for now.

> Also, are we sure this is -rc material? I think the original commit wasn't
> technically broken and the bug in Xe was fixed otherwise.

The regression was introduced by 0f485f88656a ("drm/xe/i2c: use
device_create_managed_software_node()") in 7.3 and Bartosz framed it as
an alternative fix for that bug.

Are you saying this has since been fixed differently?

If so, this can obviously wait.

Johan
