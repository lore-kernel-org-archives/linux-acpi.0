From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: fix fan sleep/resume path
Date: Mon, 17 Nov 2008 00:14:08 -0200
Message-ID: <20081117021408.GD22260@khazad-dum.debian.net>
References: <20081109113011.GB8329@khazad-dum.debian.net> <1226235242-11130-2-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35109 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752499AbYKQCOM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 21:14:12 -0500
Content-Disposition: inline
In-Reply-To: <1226235242-11130-2-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Len,

The patch needs to go to Linus...  I don't think anyone cares to have
their names as tested-by:, or they would have replied already.

I have tested the patch and it fixes things here.  It would be better with
more "works for me" replies, but it should be enough testing.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
