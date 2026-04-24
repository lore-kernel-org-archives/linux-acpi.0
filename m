Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606786334;
	Fri, 24 Apr 2026 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989663; cv=none; b=QymVFVW4yhXW2RIFLqjeAxYXEzHu4wSWBdhBtK9trAYj8bPifCwpQperb8DaF9vioEREehjGfiHknOY7dLyN2fye3b68MgtZkG2/95Rqa9SBiiQ5Uk2DJfybIT2ihw0Z8acRiQRn0QpYgyuPE3O7EHPqMdw9+FQekP19TvJd0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989663; c=relaxed/simple;
	bh=r4rwxfj7KEhnkjsE71lD5DxOOZkvnzGatNANGCAL7R8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WdQ7gXhKjkDQIEtxIlqvBDoh+vO+3PNOGcWF0Csue54XZXUc771mJCbrAbNMTR4kPMxePPN2QGOBeULZ+ndTN2FOzPREHXlVRyrPSzPuGzWZAZsSmMS2HQIjCOLQIivCFubG88AmQBrcraMfNSauuduQ0nB4UpQhJLx66ZD9/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3OtBQYB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3OtBQYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B2C2BCAF;
	Fri, 24 Apr 2026 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776989663;
	bh=r4rwxfj7KEhnkjsE71lD5DxOOZkvnzGatNANGCAL7R8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d3OtBQYBF1kh7WEX5RYhNdIiKz4MVhvcOpt2clVViW3mECyEV5IhFWSKBzfs4A5DE
	 GRXa7XKj1+IGvRrdJx3e9S2Q9Ozbw68C/7bsey4M2HwWhgd3bnT/EYpVyZ3hlzfq3V
	 ZuHOnrYwYTr0QT1/lwhoiL9YyN0H+E8SB2veI8xJlnRw4YDuw6qIXTadTi1ixqtJGn
	 q54nBH8N8U6ZRyWV0QTGIzLviC9I0DtBtpfFAJbN7swfG+rfxMPW8QB+GLxjkX2wDS
	 gxaSbviwWCLZ1GRFoEN9+0IJr4KoQ278bkQ0rjW3SANd6qmobUgg2s85uOPws0Pt9X
	 pn3YuRvyWsnIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC9380A951;
	Fri, 24 Apr 2026 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hxGGpHwOMr5MX7igEUUXEUcVcmvenJCz50yhU83Ce43Q@mail.gmail.com>
References: <CAJZ5v0hxGGpHwOMr5MX7igEUUXEUcVcmvenJCz50yhU83Ce43Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hxGGpHwOMr5MX7igEUUXEUcVcmvenJCz50yhU83Ce43Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc1-2
X-PR-Tracked-Commit-Id: beca8264d502bbe8509141432c73ab7a816a4076
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c59b464517c6ef0302ffa7d993a979a4cb50bf7
Message-Id: <177698962452.818077.12370072621330437452.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 00:13:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Apr 2026 21:26:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c59b464517c6ef0302ffa7d993a979a4cb50bf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
