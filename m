Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101229;
	b=hjld1hN8VarX+hkUNEb1JZb5hDa7kSa69PgWEI1ISxZjMeH4/zlwN+xJ4m70uQPB1/L2
	 th3IdTKDk18XxZXgY0CqbkhcscjENer8oSias3Mnz4udEEY29iMLyJVbgr2B58aXEGL/b
	 aopGtjdOIygoBZp/WeRoFRodHQMMd6ny3zqKCpyDxPxx6JJOUD/hM8wrScbQcaBLkFRkR
	 hAmRmAZ/yJimAOCLc4pdnTICB+QY3qoHhLRDUlTH64INdx7I20pMLRcxISLIemicTHFin
	 gtLkO1Ow+T0jfBzxu1o3G8VuZMKqBUvoY9R/t5xGBLDFbaWnIv3wo7KrAZ05+NYh8RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101229;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ul0Z0NBE1PNtXbpR4W6Ujw9FfbyLS0mDLINySiV4rbE=;
	b=jWTbDZCclUyGpRWy72izovloIkhwLjDxSz61YSWxz4mcbkBijbqalpjcIUCstswHqmgB
	 mzesbjxFrEj9CCNIPzBKPsLdO5YrFjpm4Kh8kOdThyrJkcnUu/VM4YTP6IBjpthQ82dE7
	 1wmQYH45P3g2NItpgaP8/p+HaA+CzI7Hz1WHro/cfTeunMgjQe3QqjXOqlulaQHcM99Rp
	 lcggVgikAuw0/G2WIaqdOBhLDb438arAjDUD4i5TmiM0xCdQEjNeKvrj+s+tMtDIXS2B2
	 m1G+kBIRKpIlXmoieLSfU/+/G7t353nQUahjh9+giApKSCSmqA4otrm69wvvx814oLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yE2yNDE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009C606A324;
	Thu, 19 Nov 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yE2yNDE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E401F000C4;
	Thu, 19 Nov 2026 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795101229;
	bh=ul0Z0NBE1PNtXbpR4W6Ujw9FfbyLS0mDLINySiV4rbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=yE2yNDE1atXI73xM+dliSEHsu7UwLQaIyOe43E2PAQXZOFJPT7oFhO8XbT1TonAIN
	 p9A7+hwWzx5oyHMaq+aptYfXt/sYC0cizZy93NswpzuA3Vws3ymCmb/3SAYjlltZoK
	 kQzL8ONuAx2CY4bwxtJJYCt8GjDS80GXD871E+i0=
Date: Thu, 19 Nov 2026 16:10:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: Re: [PATCH v3] USB: hub: call ACPI _PRR reset during port
 power-cycle on enumeration failure
Message-ID: <2026111902-caterer-pamphlet-6a80@gregkh>
References: <20260706080117.3754550-1-v3-1-0e3069228fe9@kernel.org>
 <4cc3a198-fe54-4970-b21d-9cc11480fe39@kernel.org>
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
In-Reply-To: <4cc3a198-fe54-4970-b21d-9cc11480fe39@kernel.org>

On Thu, Nov 19, 2026 at 08:58:32AM -0600, Mario Limonciello wrote:
> Ping on this patch please from a few weeks ago.

Sorry, due to a lot of flight delays (i.e. days) due to the mess in the
US last week, I've been on the road for an extra unexpected week.
Should hopefully catch up on pending patches "soon"...

thanks,

greg "what continent is this?" k-h
