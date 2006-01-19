From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Thu, 19 Jan 2006 11:50:01 +0100
Message-ID: <20060119105001.GE2154@poupinou.org>
References: <20060113095634.GA7112@mnementh.homelinux.org> <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com> <20060117203732.GC24179@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:24081 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S1161361AbWASKuF
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2006 05:50:05 -0500
Content-Disposition: inline
In-Reply-To: <20060117203732.GC24179@message-id.gmane0305.slipkontur.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Seyfried <seife@gmane0305.slipkontur.de>
Cc: linux-acpi@vger.kernel.org

On Tue, Jan 17, 2006 at 09:37:32PM +0100, Stefan Seyfried wrote:
> > Additionally, you probably want to consider the suspend2 kernel patch
> > series from http://www.suspend2.net/ to allow for reliably shutting the
> > system off without losing state and storing memory into your swap
> > partition or a file.
> 
> Has nothing to do at all with suspend to ram and the power consumption
> when suspended.

I'm not sure you are right with that claim.  There may be some code
onto suspend2 patches that may help improve suspend/resume devices that
are not yet merged to mainline.  I don't think however this fill fix
the thinkpad problem of the OP though.

It's actually more or less a guess since I have not looked actually to
the suspend2 code.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
