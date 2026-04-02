Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BD3E4C8F;
	Thu,  2 Apr 2026 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775133103; cv=none; b=S2SzNQRhCsdOG/WHET0LrfZUrvkX1ThS3eJWqva65HD7xqOWI0GIEACEysvKXUGvzBgPx/J+9+/cShjTb8jIpTzR6kmUhP66Y+uS0Cbt9TYWRxWDGteV7Bl4fXgAUVBWvAOBs92InKiEtQM9OLVLOAcxuzDfslKJPpbZ/4mS9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775133103; c=relaxed/simple;
	bh=Qc7AvdCRF8eWenkxa7VusNIbMlu2Luocya14W8PJshE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae/sOtDtU0LrlDUyYqQ8YFMDF0FNWM9MXXry/fuCpNLJHiYU5sW242Pie5lIKkVB25vYpdipjZZRHLVRmzI15tiHbbe1iRscZpH0IdmwGbzdMEd98BDN3EGvkd/MLMI2hndZBiyinBYLs8uvIP0SXLAxHI1sZT8GjN/e4B8lOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CniMsvLb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CniMsvLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B162DC116C6;
	Thu,  2 Apr 2026 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775133102;
	bh=Qc7AvdCRF8eWenkxa7VusNIbMlu2Luocya14W8PJshE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CniMsvLbxtP2jWEZ4N3QIJHqYg1aZikTzfysua1X+4l1CqBrKb+ei02CTThCM5uGm
	 vtKgMgHNKSWMlSSxYm/H/ZYNPhxUWpanFIxE4TKzE8Gg+7GqIcDMbLcuzY/i1pqk8g
	 zeC9bR9MPk1hhEyjzPnVIDSAP7rpbhYVj9872mYQ=
Date: Thu, 2 Apr 2026 14:31:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Message-ID: <2026040220-voice-reps-04a9@gregkh>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>

On Thu, Apr 02, 2026 at 12:15:07AM +0200, Danilo Krummrich wrote:
> On Wed Apr 1, 2026 at 8:46 PM CEST, Markus Probst wrote:
> > On Wed, 2026-04-01 at 20:32 +0200, Greg Kroah-Hartman wrote:
> >> On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
> >> > Export `acpi_of_match_device` function and use it to match the of device
> >> > table against ACPI PRP0001 in Rust.
> >> > 
> >> > This fixes id_info being None on ACPI PRP0001 devices.
> >> > 
> >> > Using `device_get_match_data` is not possible, because Rust stores an
> >> > index in the of device id instead of a data pointer.
> >> 
> >> I'm confused, why are we open-coding this in the rust layer?  What do we
> >> need to change in the C side to make both layers be able to call the
> >> same function instead?
> > No commit message I have seen has explained why it was done this way. I
> > don't think we would need to change anything on the C side.
> 
> The Rust code stores an index into the array the contains the actual device ID
> info in the driver_data field of a device ID instead of a raw pointer to the
> device ID info.
> 
> The reason for this is that it was the only way to build this in a way that
> results in an API that is convinient and obvious to use for drivers when
> declaring the device ID table, can be evaluated in const context (i.e. at
> compile time), and does not rely on unstable language features. Fulfilling all
> three of those requirements at the same was a rather tricky one.
> 
> The unfortunate consequence is that device_get_match_data() does not give us a
> pointer to the actual device ID info, but it gives us the index of the device ID
> info in the device ID table.
> 
> The problem is that this does not really help, because now we know the index,
> but not which table it belongs to.
> 
> I.e. we wouldn't know whether to call
> 
> 	Self::acpi_id_table().info(index)
> 
> or
> 
> 	Self::of_id_table().info(index)
> 
> to obtain the actual device ID info.
> 
> So, unfortunately, I think we have to open code this for now.
> 
> But I think this is still a minor inconvinience for being able to fulfill the
> requirements mentioned above.

Ok, that makes more sense, thanks for the detail.  Perhaps some of that
could go into the changelog :)

thanks,

greg k-h
