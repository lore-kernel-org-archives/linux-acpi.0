Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97560823DD;
	Tue, 10 Mar 2026 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103073; cv=none; b=YmPRIukp2exNfR4wBV4huni/RrVWl6UUBQgFCE+0g3KdLryX3/sA2S9Qb5MZ00Kiyx5ZD3tC56jx1qv4Z7ZoX2/2QG4vR9rfexF04YxwJALd5dQAa+9nJIq3xlzERoWnU9E/FgJ2JeXqnnSu3scsG2C9soXFYxt3vT/kzll+dok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103073; c=relaxed/simple;
	bh=hEwrviE+38fHkBJtxMnZaB2MbZ42ANfev3w6wnH7XKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbV3J+zmKrPUDBmpZ0KQczc0oLRbZrqt8jOv39QJgX5ZeisQVx/LcAq5p4VZWp2LeG8ztld6LGYr3Yto9dqtwMcff0aqSIfiLoTyYG1D5EkDvIKznvqzJQMkYffG/iYhKX7iBpTAIarJYjqNg7OFZ9ag9YV8GzdJu9IB7ASUgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 62A0axiH014418
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 10 Mar 2026 11:07:00 +1030
Date: Tue, 10 Mar 2026 11:06:59 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/5] platform/x86: fujitsu: Bind drivers to platform
 devices instead of ACPI ones
Message-ID: <aa9nq0JjDVxja74d@marvin.atrad.com.au>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12863082.O9o76ZdvQC@rafael.j.wysocki>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

Hi all

On Mon, Mar 09, 2026 at 06:03:02PM +0100, Rafael J. Wysocki wrote:
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/1968442.tdWV9SEqCh@rafael.j.wysocki/
> 
> that fixes an error code path issue in patch [3/5].  That change also
> requires patch [5/5] to be modified, but the other patches are the same
> as in v1.
> 
> The patch series summary below still applies.
> :

I'm not sure if I need to explicitly ack v2 or if my earlier ack for v1
suffices.  If not:

Acked-by: Jonathan Woithe <jwoithe@just42.net>

This is for the entire series.

Regards
  jonathan
