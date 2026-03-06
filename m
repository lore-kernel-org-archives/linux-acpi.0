Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42F21CC7B;
	Fri,  6 Mar 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772399; cv=none; b=ZRhChClm+MoPhicqMDTUA8WZZNJ9jLy8TkGvMAn5LZpxmiWRKSAqaNcoG/3Acq9/zWnRYCs0f6A9PIjA2gy9D85dEj/x7tgjjRVyIaNko78h5CqjHNdTrbysNtFdEWfq2y27TSwb5DU5m0x+og9nluaoyi9J31+0ZYmfpGRkwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772399; c=relaxed/simple;
	bh=f79BlgSg2in5KMGVfAJr8z5EZZmUtj9u7hprpV0hlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPO1xKLwFifR0GQb+g7MFVQ1efL+nxgwOBla19jypzgNH41PC7Dipd14lqhjFDWl/HXDcS4kdc6H6bfk+nBdGzK5O6b8gICKpzN/hJWyyLEsppiQvtZG8hTNtJxSWlG/cz5UtF0MR54CI059SrSjPebdkG26/A+f1Fnp2lncurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv9bdOZL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv9bdOZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D74C19422;
	Fri,  6 Mar 2026 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772772399;
	bh=f79BlgSg2in5KMGVfAJr8z5EZZmUtj9u7hprpV0hlH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nv9bdOZLpVjJtVcYH4YKiEvY3dV9ExZsQN2de7AxOW2GHBJ6zwdKX30ZKsleR9gEz
	 ZeGbHv+AoVy3wZ3gZzq9pUl0JSgFR1RCT4BLLOApv8arvwIDq48AbhyVAtSYmlQKYg
	 wtPnK+TL4IxzjMISiKtQagsvKlkRTZH3d5xWLljTXS+CY9+70KdaktUAVp8+ZM6g5w
	 HQEWrAb1Qw+Yf06V+7B3gMBGY9x61npLZLpMfokxGZwyao++pac/iTBQlkJn0BQ0Dz
	 btyAJfPpYikc/CaT7+mRrISlCwqwfqJY7DLOAOcBDJf52cRDmAS9Jz3Y/uji2cfE9o
	 EqfFaBhtEGkxQ==
Date: Fri, 6 Mar 2026 04:46:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v2 0/6] platform/chrome: Bind drivers to platform devices
 instead of ACPI ones
Message-ID: <aapcLMIq-hk_Ze_Y@google.com>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>

On Thu, Mar 05, 2026 at 08:34:58PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a v2 of
> 
> https://lore.kernel.org/linux-acpi/2274474.Mh6RI2rZIc@rafael.j.wysocki/
> 
> addressing review comments on patches [2/6] and [4/6].
> 
> The series description below still applies.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/6] platform/chrome: Convert ChromeOS privacy-screen driver to platform
      commit: d3c2872ae323ea45cc32ea0247f26c2189a481cb
[2/6] platform/chrome: chromeos_tbmc: Drop wakeup source on remove
      commit: 5d441a4bc93642ed6f41da87327a39946b4e1455
[3/6] platform/chrome: chromeos_tbmc: Register ACPI notify handler
      commit: de1260139dbd7610a2f25343c962569b8fe23f8f
[4/6] platform/chrome: chromeos_tbmc: Convert to a platform driver
      commit: a2676ead257f6cf12e458efc786a68d6ab7c1224
[5/6] platform/chrome: wilco_ec: event: Register ACPI notify handler
      commit: 25a06b7a3224161cf4b27049bea93cac21136460
[6/6] platform/chrome: wilco_ec: event: Convert to a platform driver
      commit: 27d58498f690ab39140678df918155a597b3a17a

Thanks!
