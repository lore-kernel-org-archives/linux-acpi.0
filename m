From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] [GIT PULL] thinkpad-acpi queue for 2.6.23 (v3)
Date: Mon, 23 Jul 2007 05:10:23 -0300
Message-ID: <20070723081023.GA9752@khazad-dum.debian.net>
References: <11848131483573-git-send-email-hmh@hmh.eng.br> <20070719135736.GG28872@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44039 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765606AbXGWIK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 04:10:29 -0400
Content-Disposition: inline
In-Reply-To: <20070719135736.GG28872@thunk.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 19 Jul 2007, Theodore Tso wrote:
> Henrique, just as a suggestion, but now that thinkpad-acpi isn't part
> of the ACPI subdirectories in the kernel source, I'm wondering whether
> it might not be better for you to just submit directly to Linus.

I'd rather my patches went through a subsystem maintainer, for now.
Besides, thinkpad-acpi *really* does almost all of its work through the ACPI
subsystem, so there is a benefit from it going through Len...  it helps to
spot any internal API changes in ACPI that I missed, for example.

> Given that your changes are largely localized to the ACPI subtree, it
> might make it easier to get fixes in post -rc2 or so.

Maybe, but so far that has not been a problem at all...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
