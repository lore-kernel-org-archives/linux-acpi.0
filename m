From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI patches on test branch
Date: Sat, 28 Jun 2008 11:21:45 -0300
Message-ID: <20080628142145.GE871@khazad-dum.debian.net>
References: <1214633197-3344-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40237 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751988AbYF1OVt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Jun 2008 10:21:49 -0400
Content-Disposition: inline
In-Reply-To: <1214633197-3344-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org, Andi Kleen <ak@linux.intel.com>

On Sat, 28 Jun 2008, Len Brown wrote:
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> 
> This test branch, which is pulled into linux-next
> and -mm, is a superset of the "release-2.6.27" branch.

Len,

I just got a bunch of net/rfkill changes merged into -next through
linux-wireless.

And I have a stack of thinkpad-acpi patches that depend on those, which I'd
like to see in 2.6.27.

The thinkpad-acpi changes are being field-tested for more than a month now,
not just by me, but also by the users of my thinkpad-acpi devel backports,
and it is working fine.

So, how could we do it?  Should I send the thinkpad-acpi patches to you guys
now for review, and we merge them a bit late (after the rfkill work has
already landed on mainline)?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
