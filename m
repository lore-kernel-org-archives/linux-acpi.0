Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237457;
	b=OCo1ng85VJiVwSsamnfheBhHc4arZ5kztHYrfcZQpzbW51kpyfq1WifAnfxB6ync2+ow
	 zDNs6f8SjZbP/N6s+My/RW8nAWLVJeuTtRJJgft60dHnXjxfimN8NT83uRqXFFLsu4x4m
	 y5ANtdFi90ec+uDgS1EZiiUJ9dDPietztR0B97FEpOJscSx23esazNitpYUY8+DGKvMsE
	 d/o8lVjctjijtrE+qc9OgR59mWkFBBw2eU86LvVG87xVK3Y7ECnhYQp7kxqkOANKBL5/W
	 tAHEIZdPWmzjt4whduunXAAiWU4SB7IstaIsNcld5ffd+MFfEn52V6XAEdpvw/QmaVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237457;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=CfHap0q6P6c91MZbBlQG5hfjcm9Nfhv5PV47PljtmhY=;
	b=b3lxSPMMBcLboSEJR+qsqvYlUrRmkNpxKGhgGsi1+xuR+PqoQvulFidk4OMyJxowJg6d
	 nVFlfTPou0qtd9SqHkW5VVP1wHxvoBZyI3hUxOT0tOIjT9tqd5rvNyu7tKAvRMniWz7fv
	 eUM4ek3c8nOW/wSwODEi+dBVlZwqUG5VjkSgjKR01R71IW7+YMpwe4FgJkmCdhsq+OUb5
	 33nFC1AnyGJXPazR19DqdR/HZ9VYMpM1tytcP2HTQ9nsLWTcvH1aBAbpmgEXYc6F3ZuMX
	 Ha8gBXxJC+yrNAMQAmKL5rcwyuSg9pWL2EVkfx06woJI9VjI5TOCozL2uztP0j/sxug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbK5tj5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BC606A331;
	Mon,  9 Nov 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbK5tj5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DB61F008BD;
	Mon,  9 Nov 2026 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237456;
	bh=CfHap0q6P6c91MZbBlQG5hfjcm9Nfhv5PV47PljtmhY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=mbK5tj5BA19WbMwGdas1Q1+I1CSPXuGwsyEa+SrzP7WhvMEjXBtaWSSHD9wyGS9Jf
	 CccTFcfNpk1W281ZQvRy+OrA6VcmLCMCtkaH1y6DocwctAdvSg2JqJiDu7s6Yf1oh7
	 Uw7jbjtmjzbgLZLSapVuDcG8TCgBRd+oIy8EnQCJ5v+5L08oX22PmoWJXVbiOIAn77
	 ecEK85TtVu109xYYkQijVHJ2wSiVvdGC5slKD7Rq7LU92z4XXJXeMgIUGIJ9o9OQmE
	 COW/iHr8/t8gpqYJDS5EaBd2WOsicAID2zZT5PGEdpk2hxAw85Ju7HQtJdYAyTsqXk
	 XkK+CwX4vzy2g==
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
Date: Mon, 09 Nov 2026 16:17:33 +0100
Message-Id: <DMQS3EURP5MB.2DY989AOI0CSD@kernel.org>
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
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com> <avHMhh8ChrFE_b_e@hovoldconsulting.com> <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org> <avHZ5U_YR9QSqd0G@hovoldconsulting.com> <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org> <avHfx80pHRPwtqRt@hovoldconsulting.com>
In-Reply-To: <avHfx80pHRPwtqRt@hovoldconsulting.com>

On Mon Nov 9, 2026 at 3:59 PM CET, Johan Hovold wrote:
> Yeah, I skimmed the thread now. I think the last thing he said was:
>
> 	The patch looks fine to me but I still see that there are some
> 	concerns. Like Danilo's points are valid, can those be addressed
> 	later?
>
> 	...
>
> 	Let's wait a little and if nothing arises I can apply this for
> 	XE.
>
> and in the reply they say would go back to managed nodes "once the
> limitation is addressed".

Oh, I missed that part, that's good then.

> The proposed xe fix is still not in linux-next however, and this patch
> carries a Closes: tag for the regression.
>
> So I think we can just go ahead and fix this in driver core directly.

Ok, then I agree it is fine as is. :)

Thanks,
Danilo
