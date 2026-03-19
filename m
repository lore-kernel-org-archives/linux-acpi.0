Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0693E929B;
	Thu, 19 Mar 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935567; cv=none; b=N3JcYjKow7S6A61A60MoT5mLhg2PTRl2jSxr+0IS1k5NA0dxFCVsGu+EwlmCpuHkZK34+UnsNlgezL557rZHnXYZrUuuG9MjO/WLONAcFwAHgy732pDFEPpOSRecctNj9oUpWy+Th7rG4k+kA9+0c1zNciudd7RqwIBU5GPdTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935567; c=relaxed/simple;
	bh=BvZQIE/wDg+ZajTU/09r7ZsotBTxiO+5CvLx7s4XnQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=P11dPibBLJ6Eu1SsW6/3mQygl5lK2Sd3Y4WxGkaLF+y6fIP+LW1LJ+xCJGVXOPFsLbbgU6PNBBFY9XMveoG1nRCSmJvOmIhiyiBDGHNZRoVw1tlLg95zmDi82vDmNmt4eaRhP2CaDEWjwE4xLeIU7TYyKr5Ah9g40BoeNy3+xLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu7N329x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu7N329x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC589C19424;
	Thu, 19 Mar 2026 15:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773935566;
	bh=BvZQIE/wDg+ZajTU/09r7ZsotBTxiO+5CvLx7s4XnQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cu7N329xjB2xrOY7NDlgVCqYRatPBV47Hg0EZ6WQ0IitfONF9tykuAUnQpGIrtr4s
	 T0NyBSm6Mtbx2fLmRXB98B+KTqZrGhh7T+KIuHaPosNOu/CuJ9FkhEF3S+9ehKNpB+
	 9rHtqWcxWQqRyKG21wk5Tgim/T+jJy5X/KqAYmvRTbZPunJ3BcouA8tTSJbQBTBxJ3
	 w8UJdZNGo3k+Q5Ql56q2183F6U2aTqfsjCF0kn9a70ISDaoJM+Kq/LtCDDvcT5FbyV
	 KDY5DvmO9qgqCF8pYDysiBOSSfoqGwQDy0oAZ5j2Tr2GQ1HlUivoTgn48c55BKQwfM
	 4VFTJvKL1iY+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DA5D6380692A;
	Thu, 19 Mar 2026 15:52:38 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jyDox=qX8=wYyKHJAdc5nZEmUpjAmtoqaL3k-yMc_WgA@mail.gmail.com>
References: <CAJZ5v0jyDox=qX8=wYyKHJAdc5nZEmUpjAmtoqaL3k-yMc_WgA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jyDox=qX8=wYyKHJAdc5nZEmUpjAmtoqaL3k-yMc_WgA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc5
X-PR-Tracked-Commit-Id: 5cbcd6c0742a2986782a9e2c92aa250d8f5c137d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d107dc8c9c6a9f9e4bb213f5a6398fc5c33a00a9
Message-Id: <177393555751.1677649.5836865422788634111.pr-tracker-bot@kernel.org>
Date: Thu, 19 Mar 2026 15:52:37 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Mar 2026 15:52:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d107dc8c9c6a9f9e4bb213f5a6398fc5c33a00a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
