Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BF820010A;
	Fri, 20 Mar 2026 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966630; cv=none; b=GRclbQ52UpwXeIzg0z7S03BhDol7QFeUqnyvMkoSdiDHM296gzmVJi8htRmjm98PWx3afsJuOmjx+nMtqsfSPSegYO34PH7tI08386pIJ3stDfK8Wca63W4k+AVELYMy5SAlVRHfHRwd2gMkHTsyYHFJW8MfCa39VLh7HOtlTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966630; c=relaxed/simple;
	bh=MXeok0SgoLg5i9psIWqgFC1Fr2n3qJgASZfMwKntDK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKom4ZeaICRE6Dv2q57ZlH9bQya8BKQHCTw27V+oZnpUETo1jd4X/cCu7/rVYEc0k4ToJoJBEDl7xwPQ3T9ohSh0BpyquiaS1FK9lSQtoR8RUgG+FVOZkAjE57o0OQI8wlic84WdqvEF69DoQSEuVmue+UQ5b63LPxdwIML5OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsYtQycc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsYtQycc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EB5C19424;
	Fri, 20 Mar 2026 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966629;
	bh=MXeok0SgoLg5i9psIWqgFC1Fr2n3qJgASZfMwKntDK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EsYtQycceyxXWqWLlwb2g54fPQRKnCS2FLzpG0o0sU/wwr/0cWSpg0WHhSNV1HVf7
	 YamBGh65+Hy3sMvf1cLLIntzwi+ApOP5sUeZzCUD27NSaHSeG4voQXnEz6UG/53Co/
	 CDYpqr/JdzoJu9wcfADqlh/F8kptX0n+AfpsB0SdD7+t7vlms9MOxFfzBV33khgeBR
	 d7KjxwBqFZnzlMGrWD9dxcqKXERvvx7okxwiVvrNvrNDY7vbfq5kZ+yHaJqx2AsIc2
	 gP+66Zv9/8hhHmWPiKwP2uHxSE1MKsDCNAthxe5e/Iyd768QpVthE971AydK78FxBd
	 DTiYkrlmVhFmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ECB39302F6;
	Fri, 20 Mar 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: fjes: Drop fjes_acpi_driver and rework
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396662028.1861152.3902963437419313881.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:20 +0000
References: <12857407.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12857407.O9o76ZdvQC@rafael.j.wysocki>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 14:43:55 +0100 you wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPI driver interface used by the Fujitsu Extended Socket (fjes)
> Network Device driver is redundant because its only role is to create
> a platform device the fjes platform driver can bind to, which can be
> done already at the module initialization time.
> 
> [...]

Here is the summary with links:
  - [v2] net: fjes: Drop fjes_acpi_driver and rework initialization
    https://git.kernel.org/netdev/net-next/c/ca7e99335aea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


