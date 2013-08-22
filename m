From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 3/3] thinkpad_acpi: Wire unused micmute LED to capslock
Date: Thu, 22 Aug 2013 19:29:56 +0200
Message-ID: <CAHmME9rHX=3UrFEERkGs0AvGuvoSJYKz35qsMaith4zSDzQTxg@mail.gmail.com>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
	<1377180132-4933-3-git-send-email-Jason@zx2c4.com>
	<20130822153900.GA2878@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:59647 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab3HVRaS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Aug 2013 13:30:18 -0400
In-Reply-To: <20130822153900.GA2878@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com

On Thu, Aug 22, 2013 at 5:39 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> I think there's a risk of user confusion here, in that it's now possible
> for the mic mute light to be lit despite the internal microphone still
> being active. That seems like surprising behaviour.

Yeah, that is a legitimate concern. Patches 1/3 [1] and 2/3 [2]
clearly make sense, as they're generic and don't really suggest any
new behavior.

But setting this behavior here as the default could indeed be a bit
unexpected. I think it's fair to reject this patch (3/3), but accept
the first two. Tweakers who have the same early boot caps-lock LED
needs as me can simply put this in their initramfs after 1/3 and 2/3
are applied:

# echo caps-lock >
/sys/devices/platform/thinkpad_acpi/leds/tpacpi\:\:micmute/trigger

Jason

[1] https://lkml.org/lkml/2013/8/22/310
[2] https://lkml.org/lkml/2013/8/22/313
