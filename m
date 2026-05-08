Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8B173;
	Fri,  8 May 2026 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198629; cv=none; b=jCdbff4o8q7/qG1Hfqs9zyXrTRligxh80pZ2Lr8g6cpmWuNtmg19YrsFoOWSXHgLEGSeE2TnzchY2jRYXgHu6tFU2O5ClFQKZuC79Hn9qpBFiQf8KJFNzJCIlYG0oAEMr6pD23Rowknl+CuO60fH7Ap+HwRBGw6sxAVmTLxkciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198629; c=relaxed/simple;
	bh=PQ/CjSNfKThx0jJpJYBOpfZhBNCuFDHJdVA6QN4JGQg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=m8g3gIAR6NkspVNTWz4Hwb9ARWG3O1n7YIkFiHTG/XPZsEsU//K/RKLinP8jizaIu0wVXHDiJ0jlSCSVPdRrSZJapWX41INA7aKWZrA8ve+yLHR3eXSpAX+N9XLjWn8q+0uOfjoYOBiDthlI9kNIzruKyj8CJELewBMgk07+g1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of0KgTSl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of0KgTSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621D7C2BCB2;
	Fri,  8 May 2026 00:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778198629;
	bh=PQ/CjSNfKThx0jJpJYBOpfZhBNCuFDHJdVA6QN4JGQg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Of0KgTSlKFQnhkeY9ZH7WcwRUWsoOuYBFMv/H6dU8Wvz5QuUidkhWKSGKPIXH468P
	 B3/ExeH02wVX+dyyiIbP3ZZdHAb5ffBR5PRT/0k0qr0RdiAkSsQe2yoC7a5G7XIeTP
	 8jtAl6VrAl5xmek5wzlc5ENo9f+YnxhOe9KHFZuU0+lglBAhBhXJPBVhc3pdWXj4bN
	 J+mnFjJ0M+neYK1vbhTFSAoCiq6W8aJN6GfUeEFzVG696hwk0qgfKosyD8Uor/KUZC
	 BzGwGBHaNhBT40ikOyitY1wpE5dQSV48iY8Zpj4oyriHqozyvQ+N/AY4FIC5CPZG5b
	 7TvuPyfr5Uqzw==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 02:03:44 +0200
Message-Id: <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Len Brown" <lenb@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <brgl@kernel.org>, <stable@vger.kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>

On Wed May 6, 2026 at 1:57 PM CEST, Bartosz Golaszewski wrote:
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR().

I see why secondary is generally more prone to this, but if the justificati=
on of
this change is to not rely on the caller to zero out the memory, then we mi=
ght
just want to initialize all fields.

For instance, if the caller is allowed to not zero-initialize the memory th=
en
having flags with a random value isn't correct either; all accessors are at=
omic
bitwise operations that never zero the whole field.
