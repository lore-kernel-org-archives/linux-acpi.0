From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/5] hooking udev to SW_TABLET_MODE changes
Date: Mon, 16 Dec 2013 22:03:32 -0200
Message-ID: <20131217000332.GA10466@khazad-dum.debian.net>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36133 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab3LQADf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 19:03:35 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3928720E62
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 19:03:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Garnacho <carlosg@gnome.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2013, Carlos Garnacho wrote:
> The following patches make it possible to have udev/userspace notified when
> SW_TABLET_MODE changes on the switch device, without having to resort to
> poll()/select() for such sparse events. I've got udev patches locally to
> complement this.

I don't like this.  We moved away from uevents for this kind of stuff (in
the general sense) because they, to put it lightly, are NOT appropriate for
input-event-like events.

Moving any sort of input event back to uevents is something I do NOT want to
support, ever.  Any userspace that wants it for backwards compatibility can,
and DOES synthesize uevents from input events.

So, can you make a very strong case for this uevent?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
