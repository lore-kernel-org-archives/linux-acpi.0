From: Carlos Garnacho <carlosg@gnome.org>
Subject: Re: [PATCH 0/5] hooking udev to SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 13:06:44 +0100
Message-ID: <1387282004.15078.59.camel@sacarino>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
	 <20131217000332.GA10466@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:40393 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3LQMFg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 07:05:36 -0500
Received: by mail-ea0-f172.google.com with SMTP id q10so2429561ead.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2013 04:05:35 -0800 (PST)
In-Reply-To: <20131217000332.GA10466@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org

Hey Henrique,

On lun, 2013-12-16 at 22:03 -0200, Henrique de Moraes Holschuh wrote:
> On Tue, 17 Dec 2013, Carlos Garnacho wrote:
> > The following patches make it possible to have udev/userspace notified when
> > SW_TABLET_MODE changes on the switch device, without having to resort to
> > poll()/select() for such sparse events. I've got udev patches locally to
> > complement this.
> 
> I don't like this.  We moved away from uevents for this kind of stuff (in
> the general sense) because they, to put it lightly, are NOT appropriate for
> input-event-like events.

I would like to know... not appropriate how? I can understand this rule
applies for too often events, as some input devices can get quite
chatty, but the frequency of these uevents is tremendously low. FWIW,
there is precedence of uevents on input devices in the asus-laptop
module [1], where the accelerometer reports uevents on "coarse
orientation changes".

> 
> Moving any sort of input event back to uevents is something I do NOT want to
> support, ever.  Any userspace that wants it for backwards compatibility can,
> and DOES synthesize uevents from input events.

I'm not proposing "moving back", but "complementing", the device still
has to be poked. The problem I see with awaiting for input events in
userspace in this case is that there is no good place to have this done.
My first attempt time ago was doing this in UPower, because it is
already in the business of reading input events, but it was deemed too
unrelated [2]. The next option is having a dedicated daemon, listening
for an event that's very probably not doing to happen at all during
uptime... sounds pretty wasteful to me.

> 
> So, can you make a very strong case for this uevent?
> 

Well, the above. I could add that the accelerometer uevent I pointed out
is put in use in udev and the GNOME stack, I think it makes sense to
give tablet-mode changes a similar treatment, so establishing policies
and whatnot is saner. And I think most of the userspace that's
interested in these events would want that too, with maybe exotic
exceptions.

  Carlos


[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/asus-laptop.c#n1564
[2] https://bugs.freedesktop.org/show_bug.cgi?id=43935

