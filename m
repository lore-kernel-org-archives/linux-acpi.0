Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783217;
	b=fhb01zI/pkmMw2Hc49Ldu/oE7PdW76IUAgY6IHvPiEvS2xI23MKu2Zxp6b4xI/F+bUZa
	 1qpWqHZ8/PCTFbVg6Gjzm9EBHPxA8zlB1q9KYJ/+vQJiR05gCi7aiejz6DoKgaJ/5Vcom
	 +LE2aZy1uqhH6FgAfUimUF1A9GobUvgF4T3JOBYRsTq+w/e6B8Dk758jwAmDGL4GgkQ1T
	 06GaVHilERXLVk/XJX/bb6kx6UV7h2Hra+BxWLJUmU/FqX7rZ7AJzDA9xB+a5uAAHHfwQ
	 gRnbfA71wh6iK2KN3kbCeRl1cdFp/BAus6CbpzVbDu+npKh37F1Suo2ewrxbN2rIpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783217;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=alSw+YCq5jBCd26VFvMWxYM2tXvWXkq7k6eTa+3KF/s=;
	b=IdOvkNf5LrWknnQzHSDSA6MSdRnHx+uyWC3pnH19k7pbHNt78WBAHCzaQpCTUiEHRdtj
	 p43wXD69cSqJVg94NwOqzyLYirTfKFin74iaNPl5y9AEw9tEFrKOIXcTINorofUkOC0lT
	 WrcPmyozdolx5unhnfOuoEN+lfPwkCDX9SInYv156S485XxKiS9U8nTs4wFR9bU7uVVW4
	 69bdwkE+BpDwfwaA+0vSAvfHY5aRQWLrdYsmMAJcbiT0G+9JOzvq8TbE5zqxGVRgxdCI2
	 wZzVwn5zIkUKL/gyAfq02tq+8qOMo4Yt0Kp9mg5fSO2fXukCDRy9sZXSxD0ZzIDQ59A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VofD3o9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680FB606A31B;
	Wed,  4 Nov 2026 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VofD3o9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071981F000C1;
	Wed,  4 Nov 2026 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783217;
	bh=alSw+YCq5jBCd26VFvMWxYM2tXvWXkq7k6eTa+3KF/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VofD3o9IOxjAjvhafodNQh4sENhL2O4abQJwPECc9+bQQ4M8oLZ1lwjI8WrbfQBIq
	 huv3D0JavosznmX6RYN6Zv5chtXFDdxeJndgOaw8YXnl52TsJJ/VvTY2w5faCPy6SL
	 /Tkfnm2kMP/URFG289kgqkTbtk0BEh7mD7ZMH6dNd+wRBFQe27FFYX4Y+WoWIIcuOT
	 W1yTwnwAEiBDnWauLkBaAsXoFy3/nxnT8B1Gcn6nLzBMw3z3Mw950tUp1QHwQ6Ary3
	 aLIQ+ik+jIZs0gnTKyjHhecMSKsfOaX9tcEDiWUy8h63BYrDOJMFl9A6N3jHCuGv8u
	 3VyJOGslMFEOw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xOWxK-000000074uN-0rWu;
	Wed, 04 Nov 2026 10:06:54 +0100
Date: Wed, 4 Nov 2026 10:06:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: platform: fix sw node use-after-free on
 device release
Message-ID: <aur1rt91oE5Kcrvc@hovoldconsulting.com>
References: <20261102111420.1330760-1-johan@kernel.org>
 <aunx2B_OgODKZdVw@hovoldconsulting.com>
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
In-Reply-To: <aunx2B_OgODKZdVw@hovoldconsulting.com>

On Tue, Nov 03, 2026 at 03:38:16PM +0100, Johan Hovold wrote:
> On Mon, Nov 02, 2026 at 12:14:18PM +0100, Johan Hovold wrote:
> > Sashiko noted a new use-after-free issue when freeing platform device
> > which has a software node as its primary fw node.
> > 
> > Turns out that can cause trouble also when drivers or subsystems remove
> > software nodes themselves.
> 
> Hmm. The subtleties of the software node implementation got the better
> of both the LLM and its operator it seems.
> 
> Clearing the secondary node when the device has only a software node
> does indeed clear the fwnode pointer so there was never any UAF here.

Except when the software node is indeed primary... Then the UAF issue is
real.

I'll send a v2.

Johan
