Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236362;
	b=hEmxp9SQ0LG75mxj1ypP0bRdxIsX13Tx8+1xRbvK25Y6YbOvAnBlutK/8F/MjRKFFDdM
	 SkUI/VJPxtZ0pVkMOfUX46g6LchiFyFd1bnBuDjGfPliBySpBtgse85TZRoNJ+mjMy2X8
	 57nqQy9pachxaFpkpMhS4sCObBN3WRumnaB4mgywkpONEeoB4/3bc4AqqE/9gVX0nHfA+
	 0O3EQ1vzbOh5ogu8LLljXyDgcd6rODm+g9VI4NL8Tm5P8yDJu1EIIOyBUZuY/mqIKxYPG
	 or+CgHFCPs+jGhiQ99WlsaL/+bh24u2GG2m/AGC8GigYAQoc0CWwwBdeTknDcGwLiVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236362;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0MXD1olVR1VK2jv8CjAecVpZq6Cd7JFM5zil6KQVVHw=;
	b=eShOVi3WwrBPDZO8i7mKMQTixxlp/pnYHRKu5hmnYdLwju1rjqQjGifa6GiezFGbDN1t
	 L0wZ+thT48S7quYFIGB/2+JmyXPCGJ1fYogVpO8QFV8cQSr+mMGPr6IpSN/bNIbZmStdN
	 mn5XLTb6uJb9OmeEf54gnnRuHQSuFvidyUQbTzM7PgLwZgbd3I7mhzapk587DD51AvPVg
	 agIKIpuEeU+Ym8/JXKv1vRBKkvYDxfPL473CUBkd5IKAqhCc719pv+DCXrXxzXbBtOKT4
	 dBRyKWrfXu4G6sdwOEzCZ262PeadVHJp2BTTcnTZyltp8HOi2+quI7USFj8/0smEP+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxcGcMAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76C606A333;
	Mon,  9 Nov 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxcGcMAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0087C1F008A5;
	Mon,  9 Nov 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236362;
	bh=0MXD1olVR1VK2jv8CjAecVpZq6Cd7JFM5zil6KQVVHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GxcGcMAUxCz0SQoiXLJgG8/t6tK0uZFMbBLXWXbfeTpgnvD8OyU2vkFI+oTvLZvNl
	 ZPGeUtA3IrZ/vvuWC0/ZwAosXMmtOWMAMNumvG7ZrCH0tvqDq5fdjzMtmm5M9oUO+m
	 NPncYbsELb0l7+VaTl456F3FbwDppCxquN7a7BvC+pKOtEOqpXA2gtq+g4UihrgNVM
	 shEJUlOW1OBJyuFeTEABFNXgQfi/GZ2OEOZ1+ZjMroGh0AM1GEfhf5KcNP6FNdHVa1
	 BKvNrb+ZomYBhhPYjkBRq/Z0QLkVSI9edjSns+uUeV6xEpgw5aTxN42vvrv1HXueZn
	 AxvhOZSrjr2Rg==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQQq7-0000000AFDp-1J45;
	Mon, 09 Nov 2026 15:59:19 +0100
Date: Mon, 9 Nov 2026 15:59:19 +0100
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
Message-ID: <avHfx80pHRPwtqRt@hovoldconsulting.com>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <avHMhh8ChrFE_b_e@hovoldconsulting.com>
 <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
 <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
 <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>
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
In-Reply-To: <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>

On Mon, Nov 09, 2026 at 03:45:29PM +0100, Danilo Krummrich wrote:
> On Mon Nov 9, 2026 at 3:34 PM CET, Johan Hovold wrote:
> > On Mon, Nov 09, 2026 at 03:10:31PM +0100, Danilo Krummrich wrote:
> >> On Mon Nov 9, 2026 at 2:37 PM CET, Johan Hovold wrote:
> >> > On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
> >> >> device_create_managed_software_node() creates a node whose lifetime is
> >> >> tied to the device it was created for. software_node_notify_remove() is
> >> >> called for every device that has the node as its fwnode (primary OR
> >> >> secondary) and, if the node is managed, unconditionally detaches it from
> >> >> that device and drops the creation reference.
> >> >> 
> >> >> This breaks when the node is shared with another device. Example: the
> >> >> i2c-designware copies the parent's fwnode to the adapter's struct device.
> >> >> When the adapter is deleted, it releases the reference that belongs to
> >> >> the owner and the latter ends up with a dangling pointer.
> >> >> 
> >> >> Record the device's "manager" and only perform the actual release when
> >> >> notify is called for that "owner" device.
> >> >> 
> >> >> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> >> >> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> >> >> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")

> >> Also, are we sure this is -rc material? I think the original commit wasn't
> >> technically broken and the bug in Xe was fixed otherwise.
> >
> > The regression was introduced by 0f485f88656a ("drm/xe/i2c: use
> > device_create_managed_software_node()") in 7.3 and Bartosz framed it as
> > an alternative fix for that bug.
> >
> > Are you saying this has since been fixed differently?
> >
> > If so, this can obviously wait.
> 
> There's the fix in [1] and Andy said he'll pick it up for Xe in one of the
> replies.

Yeah, I skimmed the thread now. I think the last thing he said was:

	The patch looks fine to me but I still see that there are some
	concerns. Like Danilo's points are valid, can those be addressed
	later?

	...

	Let's wait a little and if nothing arises I can apply this for
	XE.

and in the reply they say would go back to managed nodes "once the
limitation is addressed".

The proposed xe fix is still not in linux-next however, and this patch
carries a Closes: tag for the regression.

So I think we can just go ahead and fix this in driver core directly.

Johan

> [1] https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
