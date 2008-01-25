From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [GIT PATCH] thinkpad-acpi patches for 2.6.25
	(replaces batch 1)
Date: Fri, 25 Jan 2008 17:20:46 -0200
Message-ID: <20080125192046.GA3972@khazad-dum.debian.net>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br> <200801240055.20906.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42340 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751624AbYAYTUw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Jan 2008 14:20:52 -0500
Content-Disposition: inline
In-Reply-To: <200801240055.20906.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

Given that there are four cleanup patches in the batch, I didn't even
attempt to bother with checkpatch on anything before the "some checkpatch
fluff" patch.  There are, for example, no tab/space problems in the final
thinkpad_acpi.c file.

After the entire patchset is applied, there are still a few lines over 80
chars, but that's because they are MUCH more readable the way they are in
that particular hunk of code.

The braces checkpatch will complain about in the final thinkpad_acpi.c file
are there for good reasons.  They are in points of the code where I expect a
maintenance addition of one or two lines could happen, and that means any
such patches would be a lot cleaner.   That warning is just weird, anyway.

There will be also an error about a macro needing do - while. Well, that one
*does not* need it, and it is never used as a function.

So, please apply the entire set and check the final thinkpad_acpi.c file
with checkpatch --file...  It is in *much* better state than what you got
with that checkpatch run: 1 error and 12 warnings, which are all explained
above.

Patches after the cleanups are checkpatch-clean (except for the details
explained above).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
