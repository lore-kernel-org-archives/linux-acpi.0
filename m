Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F371445AE7;
	Thu,  3 Sep 2026 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468451; cv=none; b=r1HY431yQk4Czpy7EfPRPbQgRCdh+6brXIA7x3XF8ByNFWV3nBh0y796or/dzPZIXZUnesqMH7PEd/X6SNvSnq2mn2pAC65BRLGzV9S70OOZLNaLi3RIx91UyXthnyZQWgRZdPAQ3bRskI9WUjAShm0LsFuTj1a8U9jjQbXh7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468451; c=relaxed/simple;
	bh=9UK/Qc3HT6+tPijasXvYK5PuUPqKvCT9BYMwnr3XaKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NCNkuTneFwtLLQIV3Zv6BAibRUayuVG0MMYMDBDx9q9YcLsOGnBXU4WkOLcueEZSl4aNXMRJvQ744hMVIrhAySjfrST0CgjA94VokUmZ/nOJHPcmKwlI1oglIrLWsvP4XzYB8KqnT+Cf+jAbgOaY1RImpqJdqLz1ZwQuYd0uo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSj8eOad; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSj8eOad"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2855E1F000E9;
	Thu,  3 Sep 2026 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788468436;
	bh=Rt7sTUiIt6c/tlE3cgPzfzrpoohLbm1VDoBhJ4eKXcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lSj8eOadDr5P8lQ+G1OHhVEp5oeRkvIRiLaS9lz3Qe9DA/8S4fw/DOD3kBlKtTtE1
	 DRHY12UtdxzPslS9f1gzy1I2oopwxA69GfSe6DRUs4WuwE1bbuwZ+MB0Ff8DKu6mkn
	 RbV3t6P682WM1kga9kc3Dx1+zUW5ER4hMhfNctcqNLNhVzAPgu/BXeRoH5dD49iH+2
	 MC5T0a90H0xxMOFj6wKCxlyTjSdmy9/IHeSjHAPMg28qr5Au592oeXrL9sb4I+ZxZm
	 AZkchYlUrqOEjflWkhI4BxUpbgsrMwzb+rdqcYc+AcuEy7Mkv/2UAX3ED7WqI8KGsN
	 64CaVJcU2NerQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4B38119DE;
	Thu,  3 Sep 2026 20:46:18 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support update for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j1-NvoTJsKoZ0DONSe+7YzEVde4RUn9V3HsXqAikNQcQ@mail.gmail.com>
References: <CAJZ5v0j1-NvoTJsKoZ0DONSe+7YzEVde4RUn9V3HsXqAikNQcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j1-NvoTJsKoZ0DONSe+7YzEVde4RUn9V3HsXqAikNQcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc2
X-PR-Tracked-Commit-Id: 4a819ee5f2834330656d6ac168c4c8cf27fdeec2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36b03c3e270a2a4cf73202e07a93bd3a9ebd86c7
Message-Id: <178846837725.4014495.5060229820127257094.pr-tracker-bot@kernel.org>
Date: Thu, 03 Sep 2026 20:46:17 +0000
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 3 Sep 2026 21:12:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36b03c3e270a2a4cf73202e07a93bd3a9ebd86c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
