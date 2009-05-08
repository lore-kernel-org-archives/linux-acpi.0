From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
	suspend
Date: Fri, 8 May 2009 09:23:54 -0300
Message-ID: <20090508122354.GA30672@khazad-dum.debian.net>
References: <bug-13243-10286@http.bugzilla.kernel.org/> <20090505150138.92f3ecd6.akpm@linux-foundation.org> <4A02000D.9030400@gmx.net> <200905061616.36707.bjorn.helgaas@hp.com> <1241660638.3773.90.camel@localhost.localdomain> <4A0330E3.9060909@gmx.net> <alpine.LFD.2.00.0905080037240.20287@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42268 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753752AbZEHMgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 08:36:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905080037240.20287@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Witold Szczeponik <Witold.Szczeponik@gmx.net>, yakui_zhao <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, linux-acpi@vger.kernel.org

On Fri, 08 May 2009, Len Brown wrote:
> Or perhaps we should just shrug off the _PS3 failure
> and carry on with _DIS like we used to -- which is
> what this patch does.

Maybe "printk and carry on" would be better?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
