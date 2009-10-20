From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's
	already on.
Date: Tue, 20 Oct 2009 10:38:17 +0100
Message-ID: <9b2b86520910200238u66af0d34v99931cf86507d5ff@mail.gmail.com>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
	 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
	 <20091020083555.GG19095@wrars-comp.wrarsdomain>
	 <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
	 <20091020092402.GI19095@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48975 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZJTJiN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 05:38:13 -0400
Received: by fxm18 with SMTP id 18so6170363fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2009 02:38:17 -0700 (PDT)
In-Reply-To: <20091020092402.GI19095@wrars-comp.wrarsdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On 10/20/09, Andrey Rahmatullin <wrar@altlinux.org> wrote:
> On Tue, Oct 20, 2009 at 10:04:04AM +0100, Alan Jenkins wrote:
>> Yup.  The original patch from Pekka was accepted alongside a patch
>> which enabled auto-suspend for the uvcvideo driver by default.  This
>> was shown to have the same effect on CPU wakeups as measured by
>> powertop.
> When the camera is enabled, powertop says "device is active 100% of time".
> That was enough for me :)

yes but if you are missing the original "enable camera by default"
patch  *which has already been merged* then you are almost certainly
also missing the patch to enable autosuspend on uvcvideo by default.

>> Have you measured the power consumption on the current kernel using a
>> more comprehensive method than powertop?
> No.
>
>> Or perhaps you have a different camera chip?  Have you tried enabling
>> auto-suspend manually?  If it works, perhaps that driver can enable
>> auto-suspend as well.
> /sys/module/usbcore/parameters/autosuspend and
> /sys/devices/pci0000:00/0000:00:1d.7/usb5/5-8/power/autosuspend both
> contain 1, but powertop still suggests adding usbcore.autosuspend=1.
> Though nothing related to USB exists in wakeup causes list.

Yeah, powertop's autosuspend recommendation is a bit outdated.

Here's a link to the original thread.
<http://lkml.indiana.edu/hypermail/linux/kernel/0906.0/02603.html>.
The command I used to manually enable autosuspend was

echo -n auto > /sys/bus/usb/drivers/uvcvideo/*:*/../power/level

obviously this will need adjusting if the driver is different.  (This
is still the same "power" directory at the end, you're just reaching
it through a different path).

I hope this addresses your concern.
Alan
