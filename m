From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Mon, 22 Oct 2007 15:00:21 -0200
Message-ID: <20071022170021.GA30584@khazad-dum.debian.net>
References: <87lka1ffwc.fsf@gismo.pca.it> <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it> <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it> <20071020002720.GA21173@khazad-dum.debian.net> <87myuccqen.fsf@gismo.pca.it> <20071022013204.GA13019@khazad-dum.debian.net> <87prz7myq9.fsf@gismo.pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33919 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102AbXJVRA0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 13:00:26 -0400
Content-Disposition: inline
In-Reply-To: <87prz7myq9.fsf@gismo.pca.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Capello <luca@pca.it>
Cc: ML Linux-ACPI <linux-acpi@vger.kernel.org>

On Mon, 22 Oct 2007, Luca Capello wrote:
> Sorry, my fault.  It should be OK now.

I was afraid of that, the OOPs happens entirely after the thinkpad-acpi
module unloaded.

And we *did* unregister all notification functions in thinkpad-acpi, so it
might well be a problem in the ACPI core, and not thinkpad-acpi.

Please try again, this time do this beforehand (warning: will generate a lot
of debug output):

echo 0x4 > /proc/acpi/debug_layer
echo 0xfffffff > /proc/acpi/debug_level

Maybe we will be lucky and give us more info on what the ACPI layer is
calling that causes the oops.

You could also try adding a sleep() call of a second or so in
thinkpad-acpi's thinkpad_acpi_module_exit function, after the loop that
calls ibm_exit.  It is one of those ibm_exit calls that unregister the
notify handler for hotkey (the only one active in your thinkpad-acpi
install).  If it is a race, that might eliminate it and give us further
information.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
