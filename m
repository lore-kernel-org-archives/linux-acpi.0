Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235534;
	b=jckAYA6tDAjLTnw2ECxueudiA6j+KBTMrgGC/hyx8MBlhGDeSH5v88Obitc3fze/cLma
	 R3b3yfptUubUF5F6WYITR4tgmcSf4h10vwiuFJS2cL6r8QM8SidXt+S5brKO0WBqrZnnL
	 AD4Ny5xyFwaqAYr7fcdrWV/nAt/W+A8hDJso5cheoeI5AeE2thtfB6TStwLBcxnaiJC3J
	 BLJCvTGViVRybHlS4n/4bVhj6dnStDE3F3mS1MiyjlC4gaTYa0ZpqHN3WUlkLRajfR5cS
	 9XlD2kqSpkzENzqSLUK+JCiO4AxSMxJYKoi9XbA9B9x/03K20PNQFFjaw8EuPaBUDAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235534;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=/D0Fm0EfrglcvxPXBN4YDRxM7eN9aO3JwR4XYycjofw=;
	b=XzojEdwIrf/sISjiIm4WlXJ7QdXBHtPO5sMXY1eRbzbKFlqhoKeoWiwzayZ3F/G3QXxI
	 K3j4/G3UtUuUK3hlqDCgLnaWLfPrv36+vlupmkg/poNVFqRKjR49VQmfAeQLxbGseRYRk
	 2TicYY5qX3tFN2nvuUhV2U/H/jI8+r4kPerehJOzeHZw8ycHClHiReQUCvAwH26Grnm9w
	 1tCeh5yL5hMTSVAmRIkPgdqrY+k3zt2+a0iXwE6xvRiDhLmA7tdaeNGcUJQjufGbq/ckf
	 EuCAj04nBDnPkFOa2pOss0AD5j7yxdJGlCCodCm6/ijrDLnkAypIy7y1Pwid5W6GsRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duLjF8Wi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438C606A321;
	Mon,  9 Nov 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duLjF8Wi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA3F1F0089F;
	Mon,  9 Nov 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235533;
	bh=/D0Fm0EfrglcvxPXBN4YDRxM7eN9aO3JwR4XYycjofw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=duLjF8WiFcjnGjMpU7rT3PLCmzc0sHvSPEt3/z+CZqejVJd88kuOFqHIEuTe1QniY
	 QnnOKP8UMF3vEznhbtwR8x/tHUQKmMNpdLhg60PdKBHOqssHrEzELkI75nCZtKIYst
	 pJgptj/n9TIIjlBMlHI/jSI3QDOo5SyLCjVHJ8vvrE0aFpqDQ/Uog9qRXFfKWMX3JW
	 aPTrGNdS+XcKryq811guyz3h/x2Ajk/eN5sk3i9GxKlfbVE4IEACD8lczZC9MJU1UV
	 xNDHe0ni7yALGQa1DTIVNNRb85K4YaWiaLWmQMKg31FUZ5KbRzsnuNC/XZmuoU3ZTd
	 GaFgqiVQRC8LQ==
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 15:45:29 +0100
Message-Id: <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>
Subject: Re: [PATCH] software node: only let the owner release a managed
 node
Cc: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Daniel Scally"
 <djrscally@gmail.com>, "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 "Balasubramani Vivekanandan" <balasubramani.vivekanandan@intel.com>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com> <avHMhh8ChrFE_b_e@hovoldconsulting.com> <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org> <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
In-Reply-To: <avHZ5U_YR9QSqd0G@hovoldconsulting.com>

On Mon Nov 9, 2026 at 3:34 PM CET, Johan Hovold wrote:
> On Mon, Nov 09, 2026 at 03:10:31PM +0100, Danilo Krummrich wrote:
>> On Mon Nov 9, 2026 at 2:37 PM CET, Johan Hovold wrote:
>> > On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
>> >> device_create_managed_software_node() creates a node whose lifetime i=
s
>> >> tied to the device it was created for. software_node_notify_remove() =
is
>> >> called for every device that has the node as its fwnode (primary OR
>> >> secondary) and, if the node is managed, unconditionally detaches it f=
rom
>> >> that device and drops the creation reference.
>> >>=20
>> >> This breaks when the node is shared with another device. Example: the
>> >> i2c-designware copies the parent's fwnode to the adapter's struct dev=
ice.
>> >> When the adapter is deleted, it releases the reference that belongs t=
o
>> >> the owner and the latter ends up with a dangling pointer.
>> >>=20
>> >> Record the device's "manager" and only perform the actual release whe=
n
>> >> notify is called for that "owner" device.
>> >>=20
>> >> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@i=
ntel.com>
>> >> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubra=
mani.vivekanandan@intel.com/
>> >> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_a=
dd_properties()")
>>=20
>> Hm...the documentation of device_create_managed_software_node() does poi=
nt out
>> the limitation that it shouldn't be shared with other devices.
>>=20
>> Now, that's rather fragile and the reason I pointed out [1] it should be
>> changed, but it's technically not a fix?
>>=20
>> [1] https://lore.kernel.org/all/DM1FMM3KEYU9.1D26IINII93FO@kernel.org/
>
> It's hard to determine at allocation time whether a node will eventually
> end up being reused. That's why added the following clarification to the
> commit message:
>
> 	Note that it was never the intention that managed software nodes
> 	would be shared, but descendants reusing ancestor firmware nodes
> 	is not uncommon and such use is hard to predict when allocating
> 	software nodes.

Yeah, that's why I said it's fragile. :)

(Not trying to split hairs, I guess both can be argued for, whether we trea=
t
something like this as fix or not, so I'm fine with either.)

>> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.=
com>
>
>> > The end-result applied for 7.4 (to fix the 7.3 regression) is here:
>>=20
>> A previous reply from Balasubramani suggested to adjust the doc-comment =
of
>> device_create_managed_software_node(), so I thought Bartosz will send a =
new
>> version.
>
> I missed that comment (and his Reviewed-by tag, will add).
>
> The function still does not return the allocated node and managed nodes
> should generally not be shared. The exception would be descendants
> reusing ancestor nodes, and that may happen elsewhere in the stack.
>
> So I think the kernel doc is fine as-is, for now.

That's fair.

>> Also, are we sure this is -rc material? I think the original commit wasn=
't
>> technically broken and the bug in Xe was fixed otherwise.
>
> The regression was introduced by 0f485f88656a ("drm/xe/i2c: use
> device_create_managed_software_node()") in 7.3 and Bartosz framed it as
> an alternative fix for that bug.
>
> Are you saying this has since been fixed differently?
>
> If so, this can obviously wait.

There's the fix in [1] and Andy said he'll pick it up for Xe in one of the
replies.

[1] https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivek=
anandan@intel.com/
