Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCE3DCDB8;
	Mon, 20 Jul 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542000; cv=none; b=qx15v7gzaLsLIWiHF4JNIov4wz5vLjMOHcBOPOX6zcAvdv2BueSKGJ5cy7VzDsTUFsmtE8JsWOZclcGoqsT2Ma4TBeVNs2EdilDTS3+qZlK8pbdrPjco6jKFxCSonaW6Ghy0SLszqRm3DzO8GgdTg2DjgnNq0KjDHNlPt/8M+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542000; c=relaxed/simple;
	bh=xzsPxkVinRvTvTcSsnmAG2NMq36ZK+mBlxrrsOk7LlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1pJON+trdGPSAR3NdFoWoCn6na0eN0/A9q0n4w6qaaxGxT0zam0V3oCGpqReDM1Jks3pS4yNu14p86a/2x9MHBhhlyDxQhhOeKp+koIqsDM72jk+7Sgqopc31niraphxQe2334cPz3MxN4OOonSiXmy3KrTB6rkHrf1HtfaOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NFOWe+Rt; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NFOWe+Rt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=VrAlCPX0F1OIbDW3QqV5pnMEMC62myW987PYItxT88U=; b=NFOWe+RtK7qZJXlI70Cdw/CUpg
	WTu4wwTOIboyjm2+F5KSX4mHR+hPTnEsVxMYj91C27VjnUH4KVvOksATaG0jijbROwipaa4WYGG91
	vk6b/TZhfh6F+eDSQwk3MGN5UyqEdRGZ7awp4LBNiHoi4HNhPYZSjNwwm6QH0/URkUAyC00Y2lJVL
	nzc4kBjMiHuQBmZTlhHerLzNbp1zIXI9BQEKyQ2cSCIxWBUbieMrYMsZXCIb9HCdpNFVnMe60EsnR
	1+YVrKkhN4TMId7JcbjQEv152pPWmNc9hkY8JKpZ1m5RI6/ylsFs9fJA/B1kkd74IqBoM9B41uvc/
	1gqhxigw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlksm-001MTm-1H;
	Mon, 20 Jul 2026 10:05:56 +0000
Date: Mon, 20 Jul 2026 03:05:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 5/6] configfs: Allow the registration of const struct
 configfs_attribute
Message-ID: <al3y8c0bTJu4bq9r@gmail.com>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
 <20260716-configfs-const-base-v1-5-c545a4053cb5@weissschuh.net>
 <alnrJJNb1hwDrAxI@gmail.com>
 <91f5e9dc-1ba0-4e20-9f1f-5100aaaf0a88@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91f5e9dc-1ba0-4e20-9f1f-5100aaaf0a88@t-8ch.de>
X-Debian-User: leitao

On Fri, Jul 17, 2026 at 05:35:27PM +0200, Thomas Weißschuh wrote:
> On 2026-07-17 01:43:36-0700, Breno Leitao wrote:
> > On Thu, Jul 16, 2026 at 07:09:30PM +0200, Thomas Weißschuh wrote:
> > > The attribute structure defined in driver code never need to be
> > > modified. Allow them to be marked as const.
> > > 
> > > As there are many drivers which use these attributes, prepare for a
> > > phased transition by using a union of const and non-const attributes.
> > 
> > How many drivers need to be migrated? Isn't this a mechanism move?
> 
> The actual constification of the attribute will happen with a central
> change to the CONFIGFS_ATTR* macros. But all users of the macro
> will need to be prepared to handle the constness.
> 
> I have a branch with the full conversion here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/log/?h=b4/configfs-const
> 
>  73 files changed, 241 insertions(+), 248 deletions(-)
> 
>  Most driver changes are really trivial. But a few do more interesting
>  things. My goal is to heavily reduce the amount of patches in this
>  branch by merging patches to the same subsystem.
> 
>  The last four patches will be the finalization going again through
>  the configfs tree.

Oh, that makes total sense now.

Thanks,
--breno
