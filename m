From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Mon, 3 Nov 2008 14:33:11 -0200
Message-ID: <20081103163311.GA2417@khazad-dum.debian.net>
References: <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org> <20081103141628.GB31078@khazad-dum.debian.net> <20081103141836.GA31894@srcf.ucam.org> <490F0ACC.4000808@tuffmail.co.uk> <20081103145145.GD31078@khazad-dum.debian.net> <20081103145543.GA496@srcf.ucam.org> <20081103150229.GF31078@khazad-dum.debian.net> <20081103150843.GA1107@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57516 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754995AbYKCQdU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 11:33:20 -0500
Content-Disposition: inline
In-Reply-To: <20081103150843.GA1107@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Mon, 03 Nov 2008, Matthew Garrett wrote:
> On Mon, Nov 03, 2008 at 01:02:29PM -0200, Henrique de Moraes Holschuh wrote:
> > Right now, you should still rfkill_force_state().  Please wait for an hour
> > or two while I clean up that broken resume handling, and I will tell you for
> > sure.
> 
> Cool. I'll hold off posting my cleanups until then in that case.

Ok, two bugs reproduced, the fixes are ready and tested, and I will be
sending it now to linux-wireless.  You're in the CC, so you will get them.

I will also need to send patches for -stable, as the ones for mainline won't
apply to -stable.

Now, for what you asked: you DO NOT HAVE to use rfkill_force_state() in your
driver's resume method, as long as you NEVER make use of
RFKILL_STATE_HARD_BLOCKED.   I have fixed the bug that was messing this up.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
