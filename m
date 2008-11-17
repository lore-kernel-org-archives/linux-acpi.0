From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [ibm-acpi-devel] [PATCH] ACPI: thinkpad-acpi: fix fan
	sleep/resume path
Date: Mon, 17 Nov 2008 15:26:40 +0100
Message-ID: <20081117142639.GA2600@x61>
References: <20081109113011.GB8329@khazad-dum.debian.net> <1226235242-11130-2-git-send-email-hmh@hmh.eng.br> <20081117021408.GD22260@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:48985 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYKQPCC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 10:02:02 -0500
Content-Disposition: inline
In-Reply-To: <20081117021408.GD22260@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Nov 17, 2008 at 00:14:08 -0200, Henrique de Moraes Holschuh wrote:
> Len,
> 
> The patch needs to go to Linus...  I don't think anyone cares to have
> their names as tested-by:, or they would have replied already.
> 
> I have tested the patch and it fixes things here.  It would be better with
> more "works for me" replies, but it should be enough testing.

Hi,

sorry for the delay. I tested the above patch and the "auto" fan level
was preserved (or better: not touched) at resume, so this regression is
fixed.

Regards,
Tino
