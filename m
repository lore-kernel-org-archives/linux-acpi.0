From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Mon, 25 Feb 2008 17:03:54 -0300
Message-ID: <20080225200354.GE16513@khazad-dum.debian.net>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44370 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758122AbYBYUEA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 15:04:00 -0500
Content-Disposition: inline
In-Reply-To: <200802251247.30605.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lukas Hejtmanek <xhejtman@ics.muni.cz>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 25 Feb 2008, Rafael J. Wysocki wrote:
> > 2.6.25-rc2-git7 has regression, thinkpad keys do not work any more.
> > 
> > Probably this commit broke things 6c231bd5eb07ce546517019f334652b9ecfc329a

This commit is indeed broken, and I have a tentative fix for it.  But I'd
like to have a better description of just "how" the thinkpad keys do not
work anymore, to make sure I fix the entire breakage in one go.  I will
stare at the code and the fix a bit more before sending in any patches,
though.

> Also, CCing the author and the relevant list on a report usually is a good
> idea. :-)

Make it "mandatory" if you want a fast reply :^)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
