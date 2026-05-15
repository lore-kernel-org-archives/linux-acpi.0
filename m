Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4B3B9923;
	Fri, 15 May 2026 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811412; cv=none; b=tshTygG6wtX2hYs/Wl+wPUKSRBm5nB6mlKbY6kxtUXkc8l2cl0iwWHWwNPpIVcpRmMNG2gfFUw/7oPkV0T2m5UYZGTl+MFr2ddUxBqssAa1FT4tnKu+vD5zu6KAxbL27FYiYWjldB/TO4hwvqiGPft/tKu5oaBpHbWAnTjLu0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811412; c=relaxed/simple;
	bh=saPWCbrwqyEuNP3eOAVPCnPRJrmMYoYD3PpTNrtVrhw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JgdR4mEwrkcpIkNAOf26EUluSAEXZ4qWS342Y/oGRjmxQM1z1mkkMvd3VrUF9ctzgATZVMbsHnN7aklgnwVCG4Dq/7FEq+bHC/RpJuH4De2IMXAfZB6Nwxw1YP2mbowGCH6KEmF88UuT0YSTMyiIa08h+tHv7dSdwGKO+RrQgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNm2IIuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNm2IIuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF64C2BCB3;
	Fri, 15 May 2026 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778811412;
	bh=saPWCbrwqyEuNP3eOAVPCnPRJrmMYoYD3PpTNrtVrhw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GNm2IIuI6NdpgmyyDSw1Jm5bHKMRXXUtMQ2vQSno7ojlam9zrTH0ajLQYW90aDe1M
	 PiBI6asVI5LUBuPi8SdLFd3oGBC8RufudB56PzKyBtQdI0qEUEac+1fihZmXUOCopx
	 UXgLfaUAbpKWNcuUZ5H4TvNRLvpg7wvzmlZ7Clid4mNbZrIWkEL8I74Vz1GBIacBUh
	 QFXJGrDP1F7Qy0moEqkV09RQrjTatLMo8/V264mITGTEiUq2KfDHj3Xi/3rC4YZYt0
	 HvIDUOpKfpe+j71gTI2Kik8K0R+8W2o06Mui+hpcc6IpmwWCxofA3JknEo3l69u9Ks
	 5ql/64ye+XSuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE7D39E8A42;
	Fri, 15 May 2026 02:15:58 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gFKtzK1iGBire4=g5rJa8Rtk1SX96dFBb1uRMFEYJwCg@mail.gmail.com>
References: <CAJZ5v0gFKtzK1iGBire4=g5rJa8Rtk1SX96dFBb1uRMFEYJwCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gFKtzK1iGBire4=g5rJa8Rtk1SX96dFBb1uRMFEYJwCg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc4
X-PR-Tracked-Commit-Id: af149b667b9472bf981591a6d27efdecd331005a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48f76a12713253f3abaa39c4ff7606d6fed05a7e
Message-Id: <177881135695.166171.1498687729819615939.pr-tracker-bot@kernel.org>
Date: Fri, 15 May 2026 02:15:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 May 2026 23:04:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48f76a12713253f3abaa39c4ff7606d6fed05a7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
