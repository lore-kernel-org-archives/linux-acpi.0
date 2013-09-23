From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: thinkpad x60: critical thermal shutdown does not work (and
 ethernet overheats)
Date: Mon, 23 Sep 2013 09:02:56 -0300
Message-ID: <20130923120256.GB29847@khazad-dum.debian.net>
References: <20120515181004.GA2499@elf.ucw.cz>
 <20130923095814.GA2052@Nokia-N900>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39577 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab3IWMC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Sep 2013 08:02:59 -0400
Content-Disposition: inline
In-Reply-To: <20130923095814.GA2052@Nokia-N900>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Mon, 23 Sep 2013, Pavel Machek wrote:
> > I have rather old thinkpad x60 here. Long time ago, I noticed that on
> > high continuous ethernet load, it shuts itself down in regular
> > way. I traced it down to overheat, followed by ACPI signaling system
> > to go down.
> 
> just to wrap the story up... after fixing pcie aspm problems,
> ethernet apparently stopped overheating.

And that means a new kernel with fixed ASPM handling, or disabling ASPM
entirely, or what?

Good to know it can be handled by a software fix, though!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
