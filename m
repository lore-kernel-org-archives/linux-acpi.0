Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF7385D75;
	Sat, 18 Jul 2026 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366031; cv=none; b=qNuPXs3ZEjflfk+ngj/J8mvgGsBmqAVZBFRgVx4Maw17G40p5H7+D6sehSNA+IMP4bOizNETV10Mdfw7myssdQJ+dOpNgniBZCX+J1Y3saZkKGn3vNSt7aPFHIwT2R61IB8ISJX0C/3xbDsSqcvtj4DkxHcsLA2orzfi5C1IAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366031; c=relaxed/simple;
	bh=80gOuBKNoOgzU2Xs95ci5BWmUjI1YHXqpE6y0dRl1Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqJTBeXygkgueMSam+NCHLkxR+PsYTUD0Yvt35JXRQFastyNFbXpoim5oIB6ptCaPCUn73x6sg0R+KLuwncNKIoaxXBq6qYyOo5DgJLtZPkQrmp0QRUbYWE2kG6MMjsF0lZstNJ07mSsWA2pumU0CyHLUvapv7Ju9ryaroUM/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbqt6oO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbqt6oO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533BC1F000E9;
	Sat, 18 Jul 2026 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784366029;
	bh=tQdkdG8jDHs1+j1xyQoYP5Cy/XwpBIu7wdiTgEN+nac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sbqt6oO2bcUqg9xJx3imil7JNJoEq3libwDNzPT/nAcepqmrPOpdb8Tkmn6DYxZZq
	 09TqpiVNc813nRAnrY+Dk2GRQXLnB1o7u63HP6JL1fOMfanOmxYamCUg8SjoK86jAb
	 O6k6A31H87NioGXdc6UWxhTPazs6FtO3Vnl8Pv2g=
Date: Sat, 18 Jul 2026 11:12:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers/misc: add Goodix GXFP5130 eSPI fingerprint
 sensor driver
Message-ID: <2026071832-nutmeg-prototype-7f53@gregkh>
References: <20260718081431.25456-1-metehangnen@gmail.com>
 <20260718081431.25456-3-metehangnen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260718081431.25456-3-metehangnen@gmail.com>

On Sat, Jul 18, 2026 at 11:14:29AM +0300, Metehan Günen wrote:
> +	gxfp_trace.dir = debugfs_create_dir("gxfp", NULL);
> +	if (!IS_ERR_OR_NULL(gxfp_trace.dir)) {

This is not how you use debugfs.

Also, this implements a custom trace function, again, use the built-in
kernel functions for this.

This implies that the driver came from an external company that does not
have much kernel development experience, or a LLM wrote this.  As there
is no copyright information on the code, which is it?

> +void gxfp_trace_exit(void)
> +{
> +	if (!READ_ONCE(gxfp_trace.inited))

That's an abuse of READ_ONCE()  :(

thanks,

greg k-h
