Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2C1E7C2E;
	Sun, 19 Jul 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784459419; cv=none; b=NZavaZu6oMAi+Q97OaOYfvwucEGIKHWMkxCSgL2EAn0Qd27ZAlFC3TiGKaD8Bun6nSKWido5yj3d7VpHPWHX/74qYMCrr9hItpz5sXbdqtjVZ5JoOPTkR81kQL2vU20ANTiNtvwKhpizzusziUfBpRR8Cy1vbHJMpF0UE87piJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784459419; c=relaxed/simple;
	bh=CrC7j8O5KVRkKG7TJIFRHOxEnSbMqVQM+TT+qGUj7jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHYkHcfnvEkUoMSCwV/Xy743zjo+NyW3A3BYaBlN9FcfW5/BPbOmn5T34W9EpCfv7Xp0P69iYLu7ljCkkINt4rJs4C+ych240GjChE4V1cyqXPLOEI6FQ1BA/7oGKZI/NGtcAMzVWCNzuuRwnYoROjjMDQxkZomkDljPSTGu4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPlsD6qf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPlsD6qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB26B1F000E9;
	Sun, 19 Jul 2026 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784459418;
	bh=3w0lR1PJnZz/rtQFE5xEXZJHPr0eEJGGUGbLhUOMmw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QPlsD6qf99eOLQlUcpLPSe/fs5LuCpEeI4IA7dKs5BAw7c35yO5hhMxfJbdmN5Hxr
	 jesohQaW7sW/HuiFlYS8BSWuVpVP8+paQQemhXvLuToBRFGLkp1W4y3tl46HLlP06z
	 JaD6a/4S0gvygO4X+4z8zPGUyDelRlsnmOYpyjQA=
Date: Sun, 19 Jul 2026 13:10:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Metehan =?iso-8859-1?Q?G=FCnen?= <metehangnen@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/4] MAINTAINERS: add entry for GXFP5130 fingerprint
 sensor driver
Message-ID: <2026071947-spoils-constant-e62a@gregkh>
References: <2026071842-trillion-ogle-1f66@gregkh>
 <6a5cac94.b39440a8.65068.27ee@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a5cac94.b39440a8.65068.27ee@mx.google.com>

On Sun, Jul 19, 2026 at 03:53:08AM -0700, Metehan Günen wrote:
> On Sat, Jul 18, 2026 at 11:06:04AM +0200, Greg KH wrote:
> > I don't think this entry is doing what you think it is doing.
> >
> > Was it created by a LLM?
> 
> You are right — the patch script inserted the new block between the
> GOODIX TOUCHSCREEN header line and its own M: line, breaking that
> entry. The new GOODIX GXFP5130 block needs to appear as a standalone
> section, not mid-block. Will fix in v2.

As per our documentation you must document that you use an LLM, please
do so for your next submissions.

thanks,

greg k-h
