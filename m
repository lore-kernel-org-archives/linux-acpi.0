From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.25-rc2 Regression Thinkpad acpi
Date: Mon, 25 Feb 2008 18:01:13 -0300
Message-ID: <20080225210113.GF16513@khazad-dum.debian.net>
References: <20080225093914.GB4375@ics.muni.cz> <200802251247.30605.rjw@sisk.pl> <20080225200354.GE16513@khazad-dum.debian.net> <20080225204951.GB4432@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40190 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052AbYBYVBS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 16:01:18 -0500
Content-Disposition: inline
In-Reply-To: <20080225204951.GB4432@ics.muni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 25 Feb 2008, Lukas Hejtmanek wrote:
> On Mon, Feb 25, 2008 at 05:03:54PM -0300, Henrique de Moraes Holschuh wrote:
> > This commit is indeed broken, and I have a tentative fix for it.  But I'd
> > like to have a better description of just "how" the thinkpad keys do not
> > work anymore, to make sure I fix the entire breakage in one go.  I will
> > stare at the code and the fix a bit more before sending in any patches,
> > though.
> 
> Well, keys generate ACPI interrupt but acpid never receives any event.

Not even over the new netlink socket?  Or the thinkpad-acpi input device?
Please send me the debug output of thinkpad-acpi loading, just in case.

> I would be happy to test fixes to see whether things go well.

Sure, try this one:

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7500c44..0f74351 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1078,7 +1078,8 @@ static int hotkey_get_tablet_mode(int *status)
 	if (!acpi_evalf(hkey_handle, &s, "MHKG", "d"))
 		return -EIO;
 
-	return ((s & TP_HOTKEY_TABLET_MASK) != 0);
+	*status = ((s & TP_HOTKEY_TABLET_MASK) != 0);
+	return 0;
 }
 
 /*

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
