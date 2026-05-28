Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8A352019;
	Thu, 28 May 2026 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001919; cv=none; b=gRRBXodSbh4unwyLK47wEFoS4AJUY6KKvDWXLsFlP8WlVwMy/nfZ068zgMtjflFYN3xqvnWv9CXagZ45PDxxv/Cs6N+MjxzKRWyBRkZP38P+dEbltEsHE0ZO+LO3diNc0NKjKLBZ3deTtoQMGGtUfGjT9dHR4DWNKdYjhvoCywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001919; c=relaxed/simple;
	bh=y5Oj1kQCMI5dRB6SIfQuOP+v5g9B3ubn2etPhpiViDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eHpq7zdF2JwX1XGk2HidLWQ1R/+62KrRGc0HQtEktxZ5pRm19FFc7ZgK0CNYmXaTz4GL4A7UKHSanYJ6dYhCx3HH7/MwG1v87JBDv+Z6EFNrvN3DnqyBuBTQ6JE2Ex1xylPml3K0g+idEZrrD1Lfp/venWlxsuAyaO8wPYym+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keWSf/WN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keWSf/WN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5905A1F00A3A;
	Thu, 28 May 2026 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780001916;
	bh=02d2rqIlxeNnMn/SYEQWLwTrRkfrXSbbcr64AYUbmAU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=keWSf/WNXcsFrje22TX8wpwYj1cyThlJ/o1risxy49LlM8cqjOy4IEnbmhDcMmDzo
	 OcL+EvZST5gmV43F69tPUVTGushhFu6eDBhBpktzZRseGDT+0mv2VLfbZCYmu1hjy8
	 r+wvx08rAjRcUYHAuN6rVUgzJgKtwsIy5VGVAzTAYBQcM+dFKrR94t6muoLwTdVEcD
	 ZlDKkaZsyMzc560jKsSusxg5F9W98FLlgE3FXEEKGzyUzthxWWOFfquq4J9OilO5K8
	 dQYrfZNVYPc8/yuvm3MomhALU2T7NkO6pP2xZUb4qkfgMwyGGHTPszPuioXRxUAYoG
	 X5m6FUAOahYCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AD0381196D;
	Thu, 28 May 2026 20:58:41 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iHsq95Hn7YTaswya=XR9om4+_Chrdc35TqxrvGzHAQCw@mail.gmail.com>
References: <CAJZ5v0iHsq95Hn7YTaswya=XR9om4+_Chrdc35TqxrvGzHAQCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iHsq95Hn7YTaswya=XR9om4+_Chrdc35TqxrvGzHAQCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc6
X-PR-Tracked-Commit-Id: 3109f9f38800841e46769e95e1ba11f1f8c7b230
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fde5d1d47f69db6082dfa34500c27f8485389a5
Message-Id: <178000192039.1510087.11543478826856474406.pr-tracker-bot@kernel.org>
Date: Thu, 28 May 2026 20:58:40 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 May 2026 20:25:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fde5d1d47f69db6082dfa34500c27f8485389a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
