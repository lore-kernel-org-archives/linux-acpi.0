From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 4/8] thinkpad-acpi: issue backlight class events
Date: Thu, 3 Dec 2009 09:49:24 -0200
Message-ID: <20091203114924.GA2721@khazad-dum.debian.net>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
 <1259840485-2516-5-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43501 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750974AbZLCLtV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:49:21 -0500
Content-Disposition: inline
In-Reply-To: <1259840485-2516-5-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Purdie <rpurdie@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>

On Thu, 03 Dec 2009, Henrique de Moraes Holschuh wrote:
> Take advantage of the new events capabilities of the backlight class to
> notify userspace of backlight changes.
> 
> This depends on "backlight: Allow drivers to update the core, and
> generate events on changes", by Matthew Garrett.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Matthew Garrett <mjg@redhat.com>
> Cc: Richard Purdie <rpurdie@linux.intel.com>

Richard,

This patch is also in the backlight tree (and linux-next), but since it
didn't get merged for 2.6.32, it is causing some clashes and problems with
my changes for 2.6.33.

Can you drop it from the backlight tree, please?  We will merge it through
the acpi tree, along with the rest of the thinkpad-acpi changes.

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
