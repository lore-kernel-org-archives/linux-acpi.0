Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF33603EB;
	Thu, 12 Mar 2026 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346432; cv=none; b=gNVxDGSIyfBTYXer1nZRIg/utJ32nj4nJ2NcKBoGGh/hGTUw8MO8fHFRGsiL8PGRLFLvXA1VYO3tx955AAOU/BuuBndXHwIgDV7egKT/FB5JQgeSI7rGJMibO++8X4QjO5t2ZV/C0ymW+5H2ES6ixgBSXXX3D6vHVaq5Ii9YhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346432; c=relaxed/simple;
	bh=TJWPSk+QNLu6FI76miSWpjS/A9VDT/ExmVfN17JNSm4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RgpQzyO78TtoQbecTBiSPYccllEG4Gt4kZCTdr+B6vGMxejv7eLzkKv6mixpF5VMfP3Q0004/DonphdKl2CtGrs5g8v0LO0/4QvYTw+joTrIbhEYDn8dqga5p0IkhFM3BDrgofYc+QcIkcjqPrQztHYUnk31ApTYR1YNyMNCPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLJRx8/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLJRx8/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718DCC19425;
	Thu, 12 Mar 2026 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773346432;
	bh=TJWPSk+QNLu6FI76miSWpjS/A9VDT/ExmVfN17JNSm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KLJRx8/S3d8ZAQVJdJeSHfEru9BbgU4ZhjzzFODvhaIZQIL3M5JAGGxqXkJXSELRr
	 cWy1j+wy55tlTc1XB9fZxlMw5tRJ0v1TGadnyOv3nV9c7IJTxTt+33M61cLuXm99ep
	 7tbxKOjK/Vq4YkS30JGnKQOVRzJs2641dHnt9rOGRvvVL/3fvyNRadeLIYjeDZ1AQX
	 kautvmktJUxRhjuKr3ZdBeQmLRymtNn4mdnyecrnVhCnS1GYua3MXSSmLVfzAs81VR
	 lAq+ut+5FRwJu1By4dQTdyWlmmRvJb/dI6hfXBDuyjG2QgYzh6ThPHQZ1NkFVpWUAp
	 i/tb2LArnqKLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E2F3808200;
	Thu, 12 Mar 2026 20:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jJzsUrrtnwh2-zya7qrEZdQx1YzNO__G_ptcv4UEiHEA@mail.gmail.com>
References: <CAJZ5v0jJzsUrrtnwh2-zya7qrEZdQx1YzNO__G_ptcv4UEiHEA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jJzsUrrtnwh2-zya7qrEZdQx1YzNO__G_ptcv4UEiHEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc4
X-PR-Tracked-Commit-Id: 97d9960f355cca99960eb44cd1bba1d7ba1073ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61c0b2ae734fc9d33ede9cbf7d3cad67a7b0ce28
Message-Id: <177334642744.540061.11960118116308486841.pr-tracker-bot@kernel.org>
Date: Thu, 12 Mar 2026 20:13:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Mar 2026 19:18:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61c0b2ae734fc9d33ede9cbf7d3cad67a7b0ce28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
