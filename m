From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH - 2.6.19 -0/1] Backport of psmouse suspend/shutdown cleanups
Date: Thu, 22 Feb 2007 10:02:34 -0500
Message-ID: <d120d5000702220702r44894a51lfb5499b5c59d8563@mail.gmail.com>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
	 <1172148739.10619.196.camel@d36.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:30417 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161060AbXBVPCg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Feb 2007 10:02:36 -0500
Received: by wr-out-0506.google.com with SMTP id i21so190136wra
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2007 07:02:35 -0800 (PST)
In-Reply-To: <1172148739.10619.196.camel@d36.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Stable <Stable@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

On 2/22/07, Thomas Renninger <trenn@suse.de> wrote:
>
> When adding the .shutdown workaround I went down and realized it must be
> this:
>        psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> or this:
>        psmouse_set_state(psmouse, PSMOUSE_IGNORE);
>
> as I added the stuff in serio.c, I didn't realize that your psmouse
> patch is enough...
>
> So it's the first command that is needed on shutdown(PSMOUSE_CMD_MODE)?
> Dmitry: Could you explain me in a short sentence what this is doing, so
> that I can explain HP the problem again more detailed (without reading
> specs...).
>

Actually there are 2 pieces that are needed for HP laptops:

1. They really get upset if mouse (integrated synaptics touchpad) is
disabled when they about to reboot. The original code was simply doing
psmouse_reset() which issues reset command to clear state of the
device so it will be "closer" to the boot state. Hovewer (in
accordance to the spec) after reset mice stay disabled, so we have to
issue:

      ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);

to keep HP laptops happy. Why it would make any difference is a mystery to me.

2. Synaptics touchpads do not get fully reset by 0xff, we need to
explicitely enable gestures - again, HP only (there may be other boxes
with this problem of course). So we call psmouse->cleanup(psmouse) to
activate protocol-specific cleanup.

Hope this makes sense (I must admit it makes little sense to me ;) ).

-- 
Dmitry
