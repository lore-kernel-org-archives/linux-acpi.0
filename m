From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: stgit (was Re: [PATCH 4/4, v4] ACPI, PCI: ACPI PCI slot detection
	driver)
Date: Tue, 20 Nov 2007 14:23:12 -0200
Message-ID: <20071120162312.GE4654@khazad-dum.debian.net>
References: <20071117182954.GA25003@ldl.fc.hp.com> <20071117183818.GD26452@ldl.fc.hp.com> <20071119220418.GE32540@ldl.fc.hp.com> <20071119142631.4aa650eb@appleyard> <20071120030738.GA15633@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757933AbXKTQXQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Nov 2007 11:23:16 -0500
Content-Disposition: inline
In-Reply-To: <20071120030738.GA15633@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 19 Nov 2007, Alex Chiang wrote:
> Ugh, seems that stacked git got very confused when I did a
> git-fetch && git-rebase origin. Also, guess it figures that I

Being a very heavy stgit user myself, I have to say you must give up git
rebase on any stgit branch, and use stg rebase instead... otherwise, bad
things can, and do happen.

Also, don't trust the stgit release schedule, it is "release eventually" and
not something more sensible, like "release often".  Instead, track the stgit
git tree.

I wish git learned to do the basic stgit's business by itself :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
