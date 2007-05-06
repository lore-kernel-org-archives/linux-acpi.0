From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
Date: Sun, 6 May 2007 13:09:23 -0300
Message-ID: <20070506160923.GB22110@khazad-dum.debian.net>
References: <11777220172751-git-send-email-hmh@hmh.eng.br> <11777220182109-git-send-email-hmh@hmh.eng.br> <200704282148.00041.lenb@kernel.org> <20070429041543.GB29832@khazad-dum.debian.net> <3877989d0705060233g44a0b461rd6d13911bb63593a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39867 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055AbXEFQJ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 May 2007 12:09:28 -0400
Content-Disposition: inline
In-Reply-To: <3877989d0705060233g44a0b461rd6d13911bb63593a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Sun, 06 May 2007, Luming Yu wrote:
> I don't like the idea of stuffing kernel space with model-specific
> knowledge (i.e. a table) even if it is in a driver. These tables
> should be in user space...

Yeah, I am reserving that option for stuff that absolutely must be in the
driver because it needs the knowledge to do something, and so far there is
nothing like that.  Maybe the LEDs will require it to be properly named, but
that is a very small table of exceptions, much like a blacklist.

> >We deliver to userspace something like "Fn+F1" pressed, instead of "blank
> >screen" pressed, because "blank screen" is in different keys depending on
> >thinkpad model.
> 
> Yes, you should generate generic key event through input layer..

It will move to the input layer eventually.  Right now, they are ACPI
events.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
