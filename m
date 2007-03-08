From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] ibm-acpi 2.6.21-rc3 regression fixes
Date: Thu, 8 Mar 2007 04:43:26 -0300
Message-ID: <20070308074326.GA13601@khazad-dum.debian.net>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015039.GI3441@stusta.de> <1173097274.5842.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57971 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932961AbXCHHnc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Mar 2007 02:43:32 -0500
Content-Disposition: inline
In-Reply-To: <1173097274.5842.25.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Mon, 05 Mar 2007, Richard Purdie wrote:
> On Mon, 2007-03-05 at 02:50 +0100, Adrian Bunk wrote:
> > Subject    : LCD is dimmed  (ibm-acpi related)
> > References : http://lkml.org/lkml/2007/2/25/206
> > Submitter  : Jiri Kosina <jikos@jikos.cz>
> > Caused-By  : Richard Purdie <rpurdie@rpsys.net>
> >              commit 994efacdf9a087b52f71e620b58dfa526b0cf928
> > Handled-By : Jiri Kosina <jikos@jikos.cz>
> >              Richard Purdie <rpurdie@rpsys.net>
> >              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > Status     : patches are being discussed
> 
> The confirmed fix is in the ACPI test branch for this.

Len, since this is being tracked as a regression, please pull from
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
branch acpi-release

to receive the following patches:
      ACPI: ibm-acpi: fix initial status of backlight device
      ACPI: ibm-acpi: improve backlight power handling

against v2.6.21-rc3.

They are obvious bug-fixes, and address the above regression plus a related
problem in ibm-acpi backlight handling.

If we get these two patches into mainline, I will proceed to rediff the
pending 2.6.22 ibm-acpi stuff for acpi-test, so that you don't have any
extra work when the time comes to merge the ibm-acpi queue into acpi-test.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
