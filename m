Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE6347BD4;
	Thu, 26 Mar 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554529; cv=none; b=glZzvS7hVnAQR64fa/A+PrtB9gvEkYNOINlFxpSOWIs0nZ4DStN+Z2dQQhwI08UDn5ddmq21Xz+BogCuAPsd+eQxagcNQOkcFKxcQtfHPHrHzU48VjDAVCSdSwc7QadnX92CV5eGCa7G5jrkTGkj4u9aiMIrFNu8zIDPpHgIK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554529; c=relaxed/simple;
	bh=FxZElLwuuWRgkEmxeqz6puQ5BrGz0msmlhnnIYpkvFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fjMn/AUR8kHIh/CTAnXPRRFqMLfrhbWufZadFKErADU6NE2leroMVbRNuIOoNqncIwcHiONx/bl/0u6GXP6yTZZEjPrkrUHWxUjQoyPjZONMs4nkIW03jIMlgCNwvIyLG3QsXqNRuKEfAeM9UQvBBqVzoxyhkmmEziF2kz0B38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcrYYEjR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcrYYEjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55F8C116C6;
	Thu, 26 Mar 2026 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554528;
	bh=FxZElLwuuWRgkEmxeqz6puQ5BrGz0msmlhnnIYpkvFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IcrYYEjRD0geDKAzwhDla7jrZ84/ZlYpmcJc9mmNBxlxfqqll+n2QBfB/1OdyEfkG
	 tm4sKXfCktW8p611t7keIvsJk2nti4Aa4W3z8n0+FwdWu5EIC27zpFVU3VIVJZoZO1
	 XwchhRW44+JHKezuDSNzgZnNsPWWtEZuzLkThJ2eMdKhx2u4HBjIbD/8noKPSAb0K1
	 pU5XUYZlCR/+QDiXUQZoS2W0KBw87/yc6QUwgPYyXegQXi6uqsNCOPCMLed7oain/A
	 xa2WY/tBoDF7y2zY8tfJpjKDAH+AcqlZkvGuCzI1tJ+A8ilCcV6r92vCLvLmtgcoj9
	 g6e9jK2ou75Mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDE939F2038;
	Thu, 26 Mar 2026 19:48:36 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fix for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hMiiJojiagbnUPMW4w_6EsP7P0GqVTGWJm51-Ha71PHQ@mail.gmail.com>
References: <CAJZ5v0hMiiJojiagbnUPMW4w_6EsP7P0GqVTGWJm51-Ha71PHQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hMiiJojiagbnUPMW4w_6EsP7P0GqVTGWJm51-Ha71PHQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc6
X-PR-Tracked-Commit-Id: f6484cadbcaf26b5844b51bd7307a663dda48ef6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d74bd3c58abc557d6ebb61e366fab4c5c501b80
Message-Id: <177455451499.3152977.9262512396487945928.pr-tracker-bot@kernel.org>
Date: Thu, 26 Mar 2026 19:48:34 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Mar 2026 19:09:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d74bd3c58abc557d6ebb61e366fab4c5c501b80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
