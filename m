Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2B37F748;
	Sun, 19 Jul 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784459533; cv=none; b=sLS7g40JSRlr4wEBjym5Aj5H14ZD5gYMa4WA6FykZDGc1cjxzRxxIMoh2SWehVOKBwZ/H0Q/BrWkUkvzIN20Q2RcAVZxF3j/z7iBV/+JKg6T9RYMtGQ6x7gkAwIjNOwx8jgjN1vVDNbi9ml3on/6zZZ8NRF10xpONz9hAarON4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784459533; c=relaxed/simple;
	bh=k6CIM3h4u3IW0sKeDMa17WuuqDBxdV965YXRTCD3yUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igjOzbYMn2uzSa6lyx5VDVz5HFV8wtciD15Fkqj/YKRzRGXg7PFPdJmXl0SmjKzU3r073cuAbdA+DKD01Fvpk8eHsWVBmXxf9G5btvBkPxyzjnDs6bm8iP+PmO7lbvdS5D5UxYLm0ZD7LFEmE0oIVYcTOPTJWj+57m0NCpTeg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whYQVlam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whYQVlam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AD91F000E9;
	Sun, 19 Jul 2026 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784459531;
	bh=Fssr1hC/wyohS7EgaFKOmAoGhQMtCZKMSS+sxtKouXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=whYQVlam7ITPJhlnKiByCJE+l/bUgSjw/Iapy4ZIHDZL3ZonzhiSTJG49fK9aJcNO
	 K4X3aAdaxcLZEZEq+3EVx7Z9IbKpTbjb3qU8BoyXqz+6sM8RnXUf4GByXystpmZBHy
	 LaWpUT3P6912LSicfT75GO/KfMPjfMmAZuKw4xUA=
Date: Sun, 19 Jul 2026 13:12:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint
 sensor driver
Message-ID: <2026071938-referable-sharpness-700a@gregkh>
References: <2026071828-blunt-survivor-834f@gregkh>
 <6a5cac9a.b39440a8.65068.2953@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a5cac9a.b39440a8.65068.2953@mx.google.com>

On Sun, Jul 19, 2026 at 03:53:14AM -0700, Metehan Günen wrote:
> On Sat, Jul 18, 2026 at 11:09:43AM +0200, Greg KH wrote:
> > Why add this extra line?
> > Same here, why the extra line?
> 
> Script artifact — the patch generation script added a spurious blank
> line before both the source and obj entries. Will fix in v2.
> 
> > Please do not roll your own tracing functions, use the in-kernel ones
> > instead.
> 
> Agreed. The entire gxfp_trace module will be removed in v2 and replaced
> with dev_dbg() calls throughout, which integrate with the kernel's
> dynamic debug infrastructure.

Or you can use the normal traceing infrastructure if you really want
trace log messages instead of dev_dbg() ones.  Your call.

