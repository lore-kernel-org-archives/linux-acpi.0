Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC07283CAF;
	Tue, 12 May 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548847; cv=none; b=NPeBrj9RbJLTlX2K7XQ2dRg9tANu5qiuxrPNnNsdWO0dma6p2CuJ8/h9HpkxoZ/Usai9zBuJ1uLa4YzbgZzDKi38L95Wno5OruFAL7LAjJq6LgufiEPvOP9nV5Ez/co5Cs/t8p1tYUwO/EOpt7zMTwfRGacfiG0284pKCM+v7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548847; c=relaxed/simple;
	bh=23HRQSeSUXXpJlupJbUpOhWdWAET4Bp+xdD9yJ1NC/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cm9Lj5XWc7yYliwXO6B9lZXCE18qG4+b1LX7rJGrx4cD8RHwXHE7ueqkDWMU4THlVQX2q0ZLF6BBdCtVGeZjm2YC1CumVQQ6XycfxDi5AmhbeLRTQXhfxMDaUJMfhaqOj0JPsg4ugQ+rmljN6AB4V6Xr4cuy4osRuWOA7jxQxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg2QvRjE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg2QvRjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D662C2BCB0;
	Tue, 12 May 2026 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778548847;
	bh=23HRQSeSUXXpJlupJbUpOhWdWAET4Bp+xdD9yJ1NC/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dg2QvRjEFhG+IgytybygKfpx1FEuN3z76nj8qSsZrD/lxle7gzfJw66sTgPoYBdPV
	 VpzUZO8rM3kXPB+3k/LD/pONdVi7xRWLNcnclxXgsZO5iY3v8AX9TuzBKtIiIM3pcg
	 PTkIGlLe7VabpO9dZRHnyHetjbllAhwACt1gonzdifA1kMAw6aCAvqOK2kHYs011Q2
	 t8QfB522eESNItcMMDmDQ+aTCfIAlhLzyuMdJXoOJGhZKWwBlWlA0Xn1cSX8caAbSM
	 92DuP0iltFDSJu4sX0eCzGX91PSx5ELABPyoXv5VxWL9X3kIgMpKA+8cfUkjgqX8WW
	 8y2YdzVM2gLyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F4A39308E4;
	Tue, 12 May 2026 01:19:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: phy: motorcomm: add ACPI _DSD
 property
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854879356.2528168.9082191580005110678.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:19:53 +0000
References: <20260507040221.3679454-1-linchunzhi0@gmail.com>
In-Reply-To: <20260507040221.3679454-1-linchunzhi0@gmail.com>
To: chunzhi.lin <linchunzhi0@gmail.com>
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 12:02:19 +0800 you wrote:
> Hi,
> 
> This series makes the Motorcomm PHY driver parse firmware properties via
> device_property_*() so the same property set can be provided by either
> Devicetree or ACPI _DSD.
> 
> Patch 1 switches drivers/net/phy/motorcomm.c from of_property_*() to
> device_property_*() on &phydev->mdio.dev.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: phy: motorcomm: use device properties for firmware tuning
    https://git.kernel.org/netdev/net-next/c/fffedfece2b4
  - [v2,2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
    https://git.kernel.org/netdev/net-next/c/28f431eac1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


