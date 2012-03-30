From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/5] ACPI: Do cpufreq clamping for throttling per package
 v2
Date: Fri, 30 Mar 2012 06:05:29 -0400
Message-ID: <4F758569.9080608@kernel.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org> <1328545032-21373-5-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55913 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756158Ab2C3KFd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Mar 2012 06:05:33 -0400
In-Reply-To: <1328545032-21373-5-git-send-email-andi@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, Andi Kleen <ak@linux.intel.com>

Andi,
Can you re-base this on top of my release tree?

Your fix is important, but conflicted with mjg's
more invasive percentage -> frequency change.

I opted to take mjg's patch 1st b/c I think that
your fix is important enough to integrate any time
in the release cycle - so it can go on top.

thanks,
-Len Brown, Intel Open Source Technology Center

