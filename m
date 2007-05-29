From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: allow hotkey to input event map to be modified
Date: Tue, 29 May 2007 09:46:39 -0300
Message-ID: <20070529124639.GA12935@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262338.19137.dtor@insightbb.com> <20070527120319.GB19562@khazad-dum.debian.net> <200705282308.45828.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56807 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752157AbXE2Mqo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 May 2007 08:46:44 -0400
Content-Disposition: inline
In-Reply-To: <200705282308.45828.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org

On Mon, 28 May 2007, Dmitry Torokhov wrote:
> Documentation/input/input-programming.txt gives some pointers.

It is outdated, and incomplete.

> > On that topic, am I to send SYNC events between key-press and key-release
> > events? 
> 
> Yes. The application is allowed to "accumulate" input events until it gets
> EV_SYN/SYN_REPORT so if you don't send sync in-between some applications
> may not see a button press.

Ok. Done that.

> > Just after a key-press+key release event?  Or not at all for a 
> > EV_KEY ? And exactly what should go in the hardware port descriptor? I used
> > module name/input device number relative to the module.
> 
> Are you talking about "phys"? Then it is supposed to have an unique path
> to the input device. For devices on BUS_HOST module name + relative input
> device numbers seems to be the best choice.

Ok. Done that.

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
