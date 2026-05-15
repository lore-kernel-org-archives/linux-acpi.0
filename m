Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954E13770B;
	Fri, 15 May 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803862; cv=none; b=lncXdIlFl1NLgEasWj89zhvneZsMa7xTaOjb7itSk2LSUbJCyx9vBLW3fYM+eQUu7+3H0Ew8f21x/05k5UVnRO3EylrcfFavtd910f6oXjxmFP0ju6TmtSTEvft8j+bG4XSJRvdH6ME5ZVskWPsgn5/S9P4vAlhgZFO1lQqy7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803862; c=relaxed/simple;
	bh=Ip7ljYx9YgPDOI3JrNQQ8SuoJwuiiyRffmMllu7JeUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bFWfk0gWtrQTUGXFKOYhA726O5zqtDHeIWiM6rO1dhOgzAzYWh3oIwEeqtv3lVrx1aS2vwdnztVronUyAGNf7L8UASOS9IHfWSw1X5Bamw3f+haifFwnJ3XWw2hh/m74WShxNv43sZO4S7VZ0M90GXdB347E8a6+Jz5q4m7HMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct94l851; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct94l851"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFE0C2BCB3;
	Fri, 15 May 2026 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803862;
	bh=Ip7ljYx9YgPDOI3JrNQQ8SuoJwuiiyRffmMllu7JeUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ct94l851tjMd+713+FjAmZefB/jTCyUf7Yll+kExPgHHj55QbHwLeqI0W5YEqTs/y
	 CKKY9fEEPfgHL1WYYEskwbAvbRyj8WkYe2uix15nVPwAiA9AVZ6pz9s6CbjXwF/22g
	 UCyh9uItyMBFiz25z7zU7DVIr9jqbWpkG3DOgTL6a2tDasTojAbxEqEPcvdnU+rKBk
	 /x4jwR+ckLc2GltAz1qz/Us7+UNeeiOQxmSsHUANseM/XzUb4TEIcy9KhiHQS+UA9z
	 VBDw/xXLtoQ9VHvj6khX3nmCOct5kGYRCk2wFKtvQWVO3Ou+XZlOezwevWGzrefum2
	 IMXI8bRfhBySA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D7439E4DB3;
	Fri, 15 May 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] ptp: vmw: Drop ptp_vmw_acpi_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880380680.132344.1417648228454949113.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:10:06 +0000
References: <24384916.6Emhk5qWAg@rafael.j.wysocki>
In-Reply-To: <24384916.6Emhk5qWAg@rafael.j.wysocki>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: kuba@kernel.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 18:41:45 +0200 you wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Static variable ptp_vmw_acpi_device in the ptp_vmw driver is assigned,
> but never used, so drop it.
> 
> No functional impact.
> 
> [...]

Here is the summary with links:
  - [v1] ptp: vmw: Drop ptp_vmw_acpi_device
    https://git.kernel.org/netdev/net-next/c/f65d40643e42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


