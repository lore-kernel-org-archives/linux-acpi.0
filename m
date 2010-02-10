From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] thinkpad-acpi: setup hotkey polling after changing
 hotkey_driver_mask
Date: Tue, 9 Feb 2010 23:28:22 -0200
Message-ID: <20100210012821.GA7710@khazad-dum.debian.net>
References: <1265567528-1180-1-git-send-email-cascardo@holoscopio.com>
 <20100209003706.GC21680@khazad-dum.debian.net>
 <20100209013736.GE21680@khazad-dum.debian.net>
 <20100210001651.GA1422@holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50159 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754944Ab0BJB20 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2010 20:28:26 -0500
Content-Disposition: inline
In-Reply-To: <20100210001651.GA1422@holoscopio.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tue, 09 Feb 2010, Thadeu Lima de Souza Cascardo wrote:
> Sorry for the delay. Takes a while to build a kernel in my old notebook
> with a not-so-large config.

Heh, I know how you feel.  Maybe you can use distcc to offload the worst of
the work to a more powerful box?

> It works nice for me. This was a fix that has crossed my mind, but since
> other init was doing the other way (hotkey_init), I did prefer that too.
> Anyway, your way is cleaner and the right way.  :-)

hotkey_* kinda "owns" the event interface, so it is allowed some liberties I
try to avoid in the other parts of the driver :)

> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Thank you.  I will forward it to Len.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
