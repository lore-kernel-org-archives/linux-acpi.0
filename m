Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA43314B7;
	Fri, 13 Mar 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410573; cv=none; b=HWnmy0X+5BmthVpXDYsB9CQ2h1OEpAgJynXOH0ihSrkmyqYvy0HonFsvfKaQN15ZCy6d1EfAwL+sP+UV3Rai//WOC6f2eJu6XBb6ox4Ej9ufbeeHMCKUi/MPjCTiZp7InCBYqWUqiX3S1+ecAZV4ZTZF5+Qe6YCmDx1xWczBasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410573; c=relaxed/simple;
	bh=qHNTut/1HlRxTQCFm86fEioGRvBfCHG3sJxX1T53Eak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbxa/aHKRFdyhm2+Dnt1ycAA3IPIEELA8PesRZZtgR73e1kVpJ/weXVIF9f46ewmyX4FHwZVzTN3vn8IGzs4N+habTKeyS480EdL8+Gxf6+S0jrNfE/U9tiJ6nCt3Wzpn8v+fpIRW6KhXMaAurwwaogf+ZxJOsMNgOKHKB8AJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r0TMczbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r0TMczbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83E7C2BC87;
	Fri, 13 Mar 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773410573;
	bh=qHNTut/1HlRxTQCFm86fEioGRvBfCHG3sJxX1T53Eak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0TMczbj86T0lXg1fIQQQZu9XFui3gzdmO8Xx7XGdSMgJbVhtseCwOJ6m7HvAxgJX
	 SsGVhrKu5SbcqzbWNQDdfHUXVPQib7c1KZ7pBl0PAQd00W1wbYDStwzGR083bHw5Sa
	 svBHaH1YRJCsE+pWCc9waOVpX+hnii6DPx7+HusU=
Date: Fri, 13 Mar 2026 15:02:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v2 1/8] driver core: auxiliary bus: Introduce
 dev_is_auxiliary()
Message-ID: <2026031341-harmless-excuse-6407@gregkh>
References: <6271415.lOV4Wx5bFT@rafael.j.wysocki>
 <5079467.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5079467.GXAFRqVoOG@rafael.j.wysocki>

On Fri, Mar 13, 2026 at 01:53:03PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce dev_is_auxiliary() in analogy with dev_is_platform() to
> facilitate subsequent changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Danilo, Greg, please let me know if you have objections or concerns
> regarding this one.
> 
> The new function is used in the next patch to limit the scope of the
> search when looking for duplicates of the device being probed.
> 
> ---
>  drivers/base/auxiliary.c      |   10 ++++++++++
>  include/linux/auxiliary_bus.h |    2 ++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
