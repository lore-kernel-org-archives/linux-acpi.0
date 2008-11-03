From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Mon, 3 Nov 2008 12:51:45 -0200
Message-ID: <20081103145145.GD31078@khazad-dum.debian.net>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk> <490B70A3.8010108@tuffmail.co.uk> <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org> <20081103141628.GB31078@khazad-dum.debian.net> <20081103141836.GA31894@srcf.ucam.org> <490F0ACC.4000808@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:48277 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753668AbYKCOvw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 09:51:52 -0500
Content-Disposition: inline
In-Reply-To: <490F0ACC.4000808@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Mon, 03 Nov 2008, Alan Jenkins wrote:
> >> Can you read the state?  If so, you need to unconditionally do so on resume
> >> (from sleep or hibernation) and rfkill_force_state() it.
> >
> > The rfkill core actually forces the state on resume, so I think we're 
> > fine.

Not if you can enter or exit HARD_BLOCK, you're not.  If you cannot it is
fine.  But if you can, you really need to rfkill_force_state() on resume,
even if you have a get_state() hook.

This might be something that needs explicit documentation, or something
wanting a fix.

> I think the reason it works is because eeepc-laptop provides a
> "get_state" callback.  rfkill can call get_state on resume, and if the

It doesn't call get_state on resume right now, because rfkill_toggle_radio()
optimizes that away when called in forced mode.

I will think about removing that "optimization".

> state has changed, force it back to the old value.  So I think it's ok
> as is.

And the rfkill core seems to be buggy when you call force_state() on resume,
which you guys didn't hit because you're not doing it yet.  See my other
email...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
