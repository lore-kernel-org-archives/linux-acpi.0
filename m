From: Richard Hughes <hughsient@gmail.com>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Sat, 02 Jun 2007 13:50:52 +0100
Message-ID: <1180788652.2355.27.camel@localhost.localdomain>
References: <1180614979.2693.26.camel@localhost.localdomain>
	 <1180615994.3030.166.camel@cookie.hadess.net>
	 <1180619002.2693.35.camel@localhost.localdomain>
	 <1180626416.3469.7.camel@localhost.localdomain>
	 <d120d5000706010945w4de3e8d9i4d43d2ae686e4d0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:52464 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbXFBMu5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Jun 2007 08:50:57 -0400
Received: by wx-out-0506.google.com with SMTP id t15so752866wxc
        for <linux-acpi@vger.kernel.org>; Sat, 02 Jun 2007 05:50:57 -0700 (PDT)
In-Reply-To: <d120d5000706010945w4de3e8d9i4d43d2ae686e4d0a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Fri, 2007-06-01 at 12:45 -0400, Dmitry Torokhov wrote:
> The patch was pretty good, I did not quite like the driver
> registration code so I tried to clean it up.

Cool, cheers.

> What do you think about
> the attached patch (not tested due to the lack of hardware). If you
> are OK with it please add your signed-off-by because version of the
> patch I grabbed did not have it.

Attached patch looks good - I can't test it until next week, but looks
logically correct to me. I would also like to add the oddball proc event
notification system to the removal-schedule document, but this can be a
fight for another day.

> > > Also I don't think you want to use
> > > KEY_BREAK. What is the expected function of that key?

To lock the screen. We probably want to replace HCI_HKEY_BREAK with
HCI_HKEY_LOCK, as the picture on the keys is a little padlock.

> > It's a "lock" key, I really want KEY_LOCK added to input.h, but that
> > might prove difficult. For now I've used KEY_CLEAR, yell if you think
> > there's a better one to substitute or if you guys want me to add get a
> > constant added to input.h.
> 
> Iam still struggling with the purpose of the key. What would you
> extect to happen when youser presses this key? Screen gets locked?
> KEY_SCREENLOCK? KEY_SCREENSAVER?

Either of these keys would be good to add.

So yes, patch looks good, cheers for the improvements.

Signed-off-by: Richard Hughes <richard@hughsie.com>

Thanks again,

Richard.


