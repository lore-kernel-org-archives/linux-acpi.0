From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Tue, 19 Apr 2011 23:28:52 +0200
Message-ID: <201104192328.52652.rjw@sisk.pl>
References: <201104150053.37037.rjw@sisk.pl> <20110415145457.GA27650@eazy.amigager.de> <20110419202212.GA15438@mac.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36589 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771Ab1DSV2Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Apr 2011 17:28:25 -0400
In-Reply-To: <20110419202212.GA15438@mac.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org

On Tuesday, April 19, 2011, Tino Keitel wrote:
> Hi,
> 
> I reverted some wakeup and ACPI related commits. When I reverted commit
> 7fa69baf29de8c77a6b32c054df2abb8f11f8aa4, wakeup using the keyboard
> worked again and /proc/acpi/wakeup behaved as expected.

Oh, I doubt that this particular one is the problem.

> So check this, I reverted the following commits to avoid conflicts and
> build failures:
> 
> c19f9a84ec807da57fd75bbd9a3f2b8269611f79
> 5190726765b40774c069e187a958e10ccd970e65
> 2a5d24286e8bdafdc272b37ec5bdd9e977b3767c
> f2b56bc808addb908a5bf435d9b942c02af9a7c4
> 7fa69baf29de8c77a6b32c054df2abb8f11f8aa4

OK, thanks for narrowing this down, I'll have a look at it shortly.

Rafael
