From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: eeepc-laptop rfkill, stupid question #4
Date: Mon, 3 Nov 2008 12:16:28 -0200
Message-ID: <20081103141628.GB31078@khazad-dum.debian.net>
References: <490B3BB5.8060801@tuffmail.co.uk> <20081031171126.GA17313@srcf.ucam.org> <490B4014.4040009@tuffmail.co.uk> <490B70A3.8010108@tuffmail.co.uk> <20081102040008.GB29606@khazad-dum.debian.net> <490D8C4E.3010201@tuffmail.co.uk> <20081102130655.GA12766@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:55711 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbYKCOQd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 09:16:33 -0500
Content-Disposition: inline
In-Reply-To: <20081102130655.GA12766@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>

On Sun, 02 Nov 2008, Matthew Garrett wrote:
> resume path. However, as you point out, right now it's possible for the 
> user to change the hardware state in the BIOS and cause the two to get 
> out of sync. That's certainly not ideal.

In fact, it is a bug.

Can you read the state?  If so, you need to unconditionally do so on resume
(from sleep or hibernation) and rfkill_force_state() it.

If you CANNOT read the state, you will have to force the radio to a known
state somehow.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
