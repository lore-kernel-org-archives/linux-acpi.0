Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF612749DC;
	Fri, 24 Jul 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897383; cv=none; b=Dsil2ZBmekpR1C+pNzsUM7KxKhtefGRclZN/P7R7QrFI90ksa5lFO9CyATd+eS+7Cn1C9ej9sACB9ARH5M7FN2O8QFd/zoU9Bsc769pmu48h2FlVTPD2T0eaROQU33tyXFtOpmGzU8E4nggB1I4KrLQtO/ohEOQVFe3zyshAmCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897383; c=relaxed/simple;
	bh=67w3P+tboch9Yh9HSh0i6ZLF4g8TOmJTI4UUqgcnmKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMbtnlujTp6TfkOBTQ7/4xXujWRYEXSBBFdFZ5KubBB5Vx+4kXsAZwPFKKfn7N1RpYQBRPy24/tPRwB1GNlJvCqDmmY2SnzrnZMi310W8LRNKLA7x8+bdHC96Qh1t5EEJ2DOxYqtrjKJ3mgcTMhjKwdFRVbxSyGSqAd9VoZoxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWnzlZEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWnzlZEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EF41F000E9;
	Fri, 24 Jul 2026 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784897381;
	bh=67w3P+tboch9Yh9HSh0i6ZLF4g8TOmJTI4UUqgcnmKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kWnzlZErcPwgcPYWNhB7kLIeYWgBnLYV5bQwHoleuL48JSqYJYPEus3NuSt5Eh3uK
	 RnV9IUWdbIZo3XJZxCpSsoCHikZ0TwlCw/6X51STWwpIQj3N0mHkxn3JrKWcxcQqrW
	 Zga1fSI3woHWPFiuRrln4OHREQ3TwsA5mn6y63W9mHbQ+T1CH5Yq3dS0sMJowP4x0U
	 VrKYuV7rGSwK3WIOG9I1NNdnNX39ofLVONX2dkLHY0ZJIuhEkZUyBS6kYfNE8/SagV
	 G88WfnyV7QKgEBQAMULdu2znpQRavu+G2+p3e+xLN5vDLKS9VHVw4i9ezGaFmPhpdA
	 WpL4l6yA395Fg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 8802E1AC5AC8; Fri, 24 Jul 2026 13:49:08 +0100 (BST)
Date: Fri, 24 Jul 2026 13:49:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marco Giunta <marco_giunta@outlook.it>, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, imitoy@imitoy.top, lenb@kernel.org,
	lgirdwood@gmail.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	munzirtaha@gmail.com, nadim@symbolic.software, perex@perex.cz,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org,
	tiwai@suse.com, wangweidong.a@awinic.com, yakov.till@gmail.com
Subject: Re: [PATCH 0/8] ALSA: hda: Add AW88399 HDA side codec driver for
 Lenovo Legion
Message-ID: <amNfREFfIkZIsnB_@sirena.co.uk>
References: <87h5lsinn2.wl-tiwai@suse.de>
 <DS7PR19MB7724E1F838E331DDE7A99E5CFCC02@DS7PR19MB7724.namprd19.prod.outlook.com>
 <87o6fxeukj.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6fxeukj.wl-tiwai@suse.de>
X-Cookie: Take an astronaut to launch.

On Thu, Jul 23, 2026 at 02:53:16PM +0200, Takashi Iwai wrote:

> Mark, could you send a pull request including your merged stuff, so
> that I can apply on the top?

I'll send this on Sunday, I can't generate a PR until then unfortunately.
