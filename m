From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 12/20] ACPI: thinkpad-acpi: use bitfields for module flags
Date: Sat, 21 Apr 2007 23:52:51 -0400
Message-ID: <200704212352.51983.lenb@kernel.org>
References: <11771645253042-git-send-email-hmh@hmh.eng.br> <1177164527570-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37329 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050AbXDVEAz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2007 00:00:55 -0400
In-Reply-To: <1177164527570-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Saturday 21 April 2007 10:08, Henrique de Moraes Holschuh wrote:
> Use a bitfield to hold boolean module-wide flags, to conserve some memory.
> It is easy and it is clean, so we do it just for the heck of it even if it
> saves very little space.

I think that is an under-statement.
This plus the patch before it actually increase text size
for a static size change of 0.

-Len

before:
   text    data     bss     dec     hex filename
  24002    3286     728   28016    6d70 drivers/misc/thinkpad_acpi.o

after
   text    data     bss     dec     hex filename
  24082    3270     664   28016    6d70 drivers/misc/thinkpad_acpi.o




