Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DF371053;
	Wed,  1 Apr 2026 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081712; cv=none; b=MrNWESlAh4bEbZy7xsmZjee+W6kmJpwqHOZDn0Yc11l5ERsIaFzYMphoHNXWs21OusqyabCJ4IHglWXo+39M00ziebf0K48agSgDfFghqNXc3hF6PjHBYvVe0yKldtXhBVGeVDSvY3Sl3dfWPKvFyQtYmO3vrdQ10CIgB0s+jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081712; c=relaxed/simple;
	bh=34AF3ofk0Wgk4TOt5kStZHIysIdIgOjJccVuG/tlka8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TQGaEU+DveI5+2qvuOpg2x5s4LDsTSsUwJl8e3poVgGHjBaiW4m8D7rpopZZmCXpLm1y2+KlbEJoo5qdGtdPE5dVpzHpLk6/XJqj4PlvOfnzpYMp+xpMsQ5RYkOaYtBuvR6mFKI/wH7XLLH6zsMhE0WZlK2BXYGktFBSfsMx+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtkp2U6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtkp2U6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1D8C4CEF7;
	Wed,  1 Apr 2026 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775081712;
	bh=34AF3ofk0Wgk4TOt5kStZHIysIdIgOjJccVuG/tlka8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Rtkp2U6PHLgYXxrww9/MCuk8DIr+YOi58YYj/JWhgVJ0ilomZpvwqX22TNxaCBt2F
	 p1b/POayGBEW30uKlb/PGueb2BGMGud+WtkHHJK1erwrpBoojTs9uCzsi6jF1iXYZ5
	 +ZP1WEpy9UK8mtgoDJmaa95lXdvEkL9BoQcJvRal0ysVgN99AfBmP8IgKARFSHx8ae
	 Nu3re1d7hoKjaLSUHQVaa/weCNDr3D1eQGuVpcD1eBYuq8ybn6mt+/QIO73hwW4YAm
	 a53D6RQUUg06FNn1vj8uOAipFDT7BDFadAsYLVWvoi8ezRKA6ntelDl/zNUl1I3E5/
	 KONwJYSRZf7cg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 00:15:07 +0200
Message-Id: <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Markus Probst" <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
 <2026040124-unbolted-timing-ce25@gregkh>
 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
In-Reply-To: <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>

On Wed Apr 1, 2026 at 8:46 PM CEST, Markus Probst wrote:
> On Wed, 2026-04-01 at 20:32 +0200, Greg Kroah-Hartman wrote:
>> On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
>> > Export `acpi_of_match_device` function and use it to match the of devi=
ce
>> > table against ACPI PRP0001 in Rust.
>> >=20
>> > This fixes id_info being None on ACPI PRP0001 devices.
>> >=20
>> > Using `device_get_match_data` is not possible, because Rust stores an
>> > index in the of device id instead of a data pointer.
>>=20
>> I'm confused, why are we open-coding this in the rust layer?  What do we
>> need to change in the C side to make both layers be able to call the
>> same function instead?
> No commit message I have seen has explained why it was done this way. I
> don't think we would need to change anything on the C side.

The Rust code stores an index into the array the contains the actual device=
 ID
info in the driver_data field of a device ID instead of a raw pointer to th=
e
device ID info.

The reason for this is that it was the only way to build this in a way that
results in an API that is convinient and obvious to use for drivers when
declaring the device ID table, can be evaluated in const context (i.e. at
compile time), and does not rely on unstable language features. Fulfilling =
all
three of those requirements at the same was a rather tricky one.

The unfortunate consequence is that device_get_match_data() does not give u=
s a
pointer to the actual device ID info, but it gives us the index of the devi=
ce ID
info in the device ID table.

The problem is that this does not really help, because now we know the inde=
x,
but not which table it belongs to.

I.e. we wouldn't know whether to call

	Self::acpi_id_table().info(index)

or

	Self::of_id_table().info(index)

to obtain the actual device ID info.

So, unfortunately, I think we have to open code this for now.

But I think this is still a minor inconvinience for being able to fulfill t=
he
requirements mentioned above.
