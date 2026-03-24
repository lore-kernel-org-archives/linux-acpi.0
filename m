Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F803932CA;
	Tue, 24 Mar 2026 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339187; cv=none; b=l1rwouxdJuVNXBQVhupyMZ3t1EvuwEwONBZG1nB2DNoFT3Ip+ZyALk/ZS51PJDNgeVHjU0wiUdJHjrfE6ofdvarKLSNqyQ7p0vzYaHwXxdDrhOyo9KZzqm515/MR/WUx6Vxki0GZiE1LIT1q4AtXep1gPtRpAPxCEUJpH+HahXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339187; c=relaxed/simple;
	bh=RAzgL2sQteo/JNXLjPH+jvC10bnkmlfp2keY2Tg6Hu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc8+zqhWBbVuPMllzvGL2psUqZcgRGhQMNrjpgL8aXS+/nSJlLEmOZ2nzEmkGFsZHh1WqWGGqSYLzbtSInZQufG951DdH4x/KhmsWgNb5a0wbppYrie1Uadb0ZH2U+CLamH4L1ebBsuV28+d88mALJIdhGfA10wlFSOJK48TB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbTvBR8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbTvBR8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7889DC19424;
	Tue, 24 Mar 2026 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774339187;
	bh=RAzgL2sQteo/JNXLjPH+jvC10bnkmlfp2keY2Tg6Hu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbTvBR8wpERq3UbyP25P08Hpd6xRdDPXhwi8pKwNtrIsL9N6xf/jPfSgRZ//OE9q0
	 794R3mUQsZnH83+C/URcb/OigwbSF5eQs+FnpigTmx01LPEKSPjfkRngaJBFhKn/NS
	 sY50sIT6nWET4jPTQbT0WvS7IkXoZFccQzS1ouEI=
Date: Tue, 24 Mar 2026 08:59:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] software node: allow referencing software nodes by name
Message-ID: <2026032406-recycler-device-7660@gregkh>
References: <acIV6xF8mY-8wd5e@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acIV6xF8mY-8wd5e@google.com>

On Mon, Mar 23, 2026 at 09:46:50PM -0700, Dmitry Torokhov wrote:
> Currently static device properties references require either an
> instance of software node or an instance of fwnode_handle to be
> available when defining a reference property. This may not be very
> convenient when device node is instantiated from a different module
> (which is usually the case).
> 
> The original implementation for describing GPIOs using software nodes
> worked around this by creating a detached from gpiochip instances
> software nodes, and performing matching using gpiochip label and node
> name. The gpiolib maintainers rightfully questioned this approach, and
> currently recommend to attach secondary software node to gpiochip
> instance, export the symbol, and use it in board file when instantiating
> static properties. This unfortunately results in tight coupling between
> gpiochip drivers and board code, necessitates creation of header files,
> requires adding Kconfig dependencies, limits options for choosing module
> vs built-in compilation, and alters device initialization/probing order.
> 
> Solve the issue by providing an option to use software node name in
> place of the node instance when describing reference properties. When
> evaluating reference driver core will attempt to resolve the name to
> concrete node instance and, in case of GPIO references, will use
> identity match on firmware node to locate corresponding gpiochip device.
> 
> This approach has a drawback of needing to know name of the node that
> gpiochip device will be using, however benefits (minimal coupling, no
> need for adding dependencies) outweigh this drawback.
> 
> To deal cases with software nodes not being created or registered at
> time of look up, assume that the node with matching name will get
> registered eventually and return -EPROBE_DEFER in the meantime.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/swnode.c    | 25 +++++++++++++++++++------
>  include/linux/property.h |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)

Do you have a follow-on patch that uses this new api anywhere?

thanks,

greg k-h
