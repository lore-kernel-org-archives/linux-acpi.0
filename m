Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FB1E3DF2;
	Tue, 24 Feb 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893153; cv=none; b=lLWRYYRP7N2sKAcs+OL4dt/nFO7L6TXwNTAXPI2eaNiu3X34UVcMdkHeV00jbvSvwE/podgNuCS+PonANilRGFXPn2N8BRG0QiNONogNpWwGb+b4kY6ND9k1HSTK0DDcCDzbhLL1WnPumvkG//7suTYYjQ+oqNKakSt7YNQV9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893153; c=relaxed/simple;
	bh=WPV27f6zWwgmBksfTKUa9fysHcW/fB7o4a02PvXBJ+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSyKkq70n/gN6YghRxiA5v5dN7P24fd0T/sln75yEwXaZ9nvRgHk+lXltXBg97I4Od/EwxZjzx4D3NbpCZY8+CLrUiWZGLgIMDfNRGxKmqJZtI0HBviQshTxdQSXwWyr9unpMdew7SGJQ/XgAmVsJbAgMR2AbPtwI91kzwerdAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LjhdR7+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LjhdR7+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B516BC116C6;
	Tue, 24 Feb 2026 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771893152;
	bh=WPV27f6zWwgmBksfTKUa9fysHcW/fB7o4a02PvXBJ+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjhdR7+G7okl9AIhjTsEDMPVjisKFocjoSPKP1i4Bq4hHWrcA04xhKozVynTy4Zty
	 c8s43u8BWzriyoiV1ldMYjNAy35quxiikzhIhd1u/rz65ez/XyjuDnSGOu7P8Ldlqq
	 nsX3mTs8jGFLixAnZun4NsRGPWlDGNTuQ9D2x/gE=
Date: Tue, 24 Feb 2026 01:32:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v1 0/3] driver core: Split device.h even more
Message-ID: <2026022432-tree-footsore-32c0@gregkh>
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com>

On Mon, Feb 23, 2026 at 09:30:29PM +0100, Andy Shevchenko wrote:
> In many drivers the whole bunch of what device.h provides is not
> being used. Currently we already have device/devres.h which helps
> a lot, but splitting more, will do even better. Hence this mini-series.

What is "better"?  Faster builds?  Smaller builds?  Something else?  Why
do this?  A big .h file might not be "nice", but it's usually faster
than having multiple .h files that are always included from that
original .h file

thanks,

greg k-h
