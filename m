Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF049C150
	for <linux-acpi@vger.kernel.org>; Thu, 26 Oct 2023 05:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MaKkc1JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDFC433C7;
	Thu, 26 Oct 2023 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698297938;
	bh=HDy4nPUhUEA+7ki5tSQI5vsOl44X4cw66wI/6D9BcvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaKkc1JZ0ZYD96p07p/5Ssa+dZVPhvisnyV2/NE5tPFyc1uiC4vuDJIwsP+fQZGO5
	 aaDk8bI56zM5vaPDRmWFcSAVEoUF967GD2CXTzXDi+S7eJ95m2kvuNoq4ehY7lm3Fi
	 FtmL/qrEPHWiDp8UNYI/CbsVVw13ZWr12nf83lOs=
Date: Thu, 26 Oct 2023 07:25:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023102624-moonshine-duller-3043@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>

On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> Some users want to use the struct device pointer to see if the
> device is big endian in terms of Open Firmware specifications,
> i.e. if it has a "big-endian" property, or if the kernel was
> compiled for BE *and* the device has a "native-endian" property.
> 
> Provide inline helper for the users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
