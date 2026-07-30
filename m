Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A343932B;
	Thu, 30 Jul 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420404; cv=none; b=McqRuVXL9Vu8Tkv3ODThG1r76wGc6k7J8gUrnUB6lXTGx/qhUZWwrqxuo2+/cNTy9WFNe6fy9ZycQW7/o4EOZMxUyI6O29bcfEqt1C8/BptaZCN+z0bnWnnSdvXYsqomvHzDK+n/iVAOMrzcf9K6/39jRvnZOjRAK1UBXdDB16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420404; c=relaxed/simple;
	bh=iC/skEahk3coK29MlnHREp4XcnpCcfHGuzw8zGm7XhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiT/+RKQoqD8XSjPuJOqfjlJUZz70fyrNTwpv6AKTOfxXG0suxQSXuemSuzOmPRQO6I1+TYEIq2bvc1QiXGSPTnoLj8lRt1kTGG4lgSlh1zY8r0eE6JxxvXhgJmpKUkMa///usAAK+2naArn7HvxuiPR1PBGWJOjV613qd5SKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yh4Bixly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yh4Bixly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8301F000E9;
	Thu, 30 Jul 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785420402;
	bh=aloKIwt1Hxt7kQLPWqlAKkte3J1coh0svB3wsBBX6pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yh4Bixlyfo15FP5MmJ4GGHcDP2KEo418MZ3nVX2tmztwMh2xX01FoyO7XGY92Q1r+
	 P/q3nLJAg8+scZYBmYLn33M8jCGKK0vMTSXebR07esh0TkBYqLAwAD/ZjLUK1hQUkS
	 9Izzxj2oYqYx/XGYsVFMy6MMhsbap5m4DBlf6ZO4=
Date: Thu, 30 Jul 2026 16:06:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Silver <mendaxca@gmail.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
Message-ID: <2026073005-rarity-devouring-721a@gregkh>
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>

On Thu, Jul 30, 2026 at 09:25:33PM +0800, Julian Silver wrote:
> #regzbot introduced: c0f691388992c708436ab5f6e810865be6ddf5c6
> 
> Hello,
> 
> After commit c0f69138, all usb ports on the rear panel stop working. The kernel logs show: "probe with driver ehci-pci failed with error -110". Specifying "intel_idle.max_cstate=0" can work around this issue.

Does that option work around the issue?

> Please let me know if you need any additional info or trying patches.

And that's a very old commit, odd that this just shows up now?

thanks,

greg k-h
