From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: Battery life difference
Date: Sat, 5 Jul 2008 17:00:26 +0300
Message-ID: <31e679430807050700q765dc45ft198fcf1c0b91a9cc@mail.gmail.com>
References: <31e679430807050617u3fc706fasee9bb43a151c501f@mail.gmail.com>
	 <20080705133601.GA20240@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:10742 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbYGEOAa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jul 2008 10:00:30 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1009185waf.23
        for <linux-acpi@vger.kernel.org>; Sat, 05 Jul 2008 07:00:27 -0700 (PDT)
In-Reply-To: <20080705133601.GA20240@mit.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>, Felipe Balbi <felipebalbi@users.sourceforge.net>, Kernel development list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi,

On Sat, Jul 5, 2008 at 4:36 PM, Theodore Tso <tytso@mit.edu> wrote:
> You didn't say which battery you are using; I'm guessing you are using
> the 4 cell slim-line battery, which is rated at 28.8 Watt-hours?

yeah, the normal slim-battery.

> How many Watts is Powertop reporting that you are using?  I'm down to

eheh, it's only 15.5w :-p

> around 8-9 watts, and around 9.5 watts in "airplane mail reading mail"
> (wireless disabled, USB modules unloaded, screen brightness turned way
> down, laptop_mode enabled, all mail messages pulled into memory, and
> reading/deleting mail using mutt, a character-mode based mail reader
> --- if you use Evolution, your energy usage will definitely be higher  :-).

no crappy evolution, I use fluxbox and mutt. This ubuntu machine is
for testing purposes only :-p

Anyways, it's bad that we have to manually unload several modules,
specially usb. I'm sure windows reaches 9 watts consumption without
breaking functionality. And that's the big thing. I think that's something
we should be aiming. Dontcha think?

> See http://thunk.org/tytso/blog/2007/10/29/tip-o-the-hat-wag-o-the-finger-linux-power-savings-for-laptop-users/

Good article, but still. On the end user point of view, it's difficult to do
rmmod/insmod operations. Recently I sent a patch to the bluez team
adding a checkbox to bluetooth-properties that would send the SetMode("off")
dbus message (which is the same as running hciconfig hci0 down).

That helps a bit, but still the driver is not been used and keeps generating
wakeup events. Why if it's not been used ?

Maybe this is something we should start thinking about, right ?

-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
