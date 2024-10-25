Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E020D4E3;
	Fri, 25 Oct 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879822; cv=none; b=IUt9S5/92qP0TH04e+BBuC/CeCD6TTFALBFbVvmUxsv40FgZJnPO88v4R09GmoVDHRgLJkvJxXdZ0fJeyGFWc3WMJZNLJsVBztkhCN4dHGguC9hYjXKQ/QCsFczfeOBpm0HveRX6noReReBef/WCthzinV2/ySOd4t1lXAYleG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879822; c=relaxed/simple;
	bh=VvR63++gykaS4SkQ93kTPp868Yc65GvXl2Kcfe54zfk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rT9VRMM+e3iWhTxDb06Uc75nE+xAxvva930vG55mMDgA5lr4EPprYOuW5CyQtjWVcLhgzWkvKnKp/cymCqyzlM8XLIlaWZehpNlBBq8jT5EcYPaiT6hMkSX1iM0CEoJL8FiiwKhHvlO17QHlZYRfJQlOqAG7UQzCR5ZNtCKo6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhkT3MkJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhkT3MkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFE4C4CEC3;
	Fri, 25 Oct 2024 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729879821;
	bh=VvR63++gykaS4SkQ93kTPp868Yc65GvXl2Kcfe54zfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HhkT3MkJJtT2JYm4JvRKebILGF1aaC39z9p17iz++lbYEtDlBkYsHZbxk9LmJegn3
	 6c++HH5PnCi1GAQNnqPBdl6kbWTXZ0xbMrKisScwp6cxwbnfJNnaxuHCHUGMnXfuxa
	 8LRcs3ZglKnE7bL3TQb7DbsfpYgzrRSzWrj7QIMA7twkMeEKZymTh0Iwm9omq/gcsd
	 JKq8gQilgH3e79k/iCPJo62FzO3zG90mwrZe017fxhtYM9wcMi6pSUSOMzw6Vns5+u
	 CWr4xIwjpyUd8gWL9nW5UbgTmvF7cxyesvi2cTq75LLAj1S4UZI4H2euDRVFzrFjgo
	 nXf+xCpkXVAMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB68E3809A8A;
	Fri, 25 Oct 2024 18:10:29 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gqmA1PgKKhmZzBj0vBe4giC-wqxbdV-YrwOvnSELWuAw@mail.gmail.com>
References: <CAJZ5v0gqmA1PgKKhmZzBj0vBe4giC-wqxbdV-YrwOvnSELWuAw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gqmA1PgKKhmZzBj0vBe4giC-wqxbdV-YrwOvnSELWuAw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc5
X-PR-Tracked-Commit-Id: 54774abb5549c619909b5c3e2605bc643e83d9a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b423f5a9a61f360a250596d78e513761aea96b4f
Message-Id: <172987982880.2993589.14922428929539027981.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 18:10:28 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Oct 2024 17:52:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b423f5a9a61f360a250596d78e513761aea96b4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
