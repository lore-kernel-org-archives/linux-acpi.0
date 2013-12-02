From: Thomas Mitterfellner <thomas.mitterfellner@gmail.com>
Subject: Re: How can a critical temperature be set?
Date: Mon, 2 Dec 2013 09:18:02 +0100
Message-ID: <CAKDaYSEioaSPJKsGsuBGfCLC=BE3M6bMiaSqyvSWKbhvr9FPjQ@mail.gmail.com>
References: <CAKDaYSF8+mcaFAegNQReeRXYZfM1TRXGskrAXyZHRkrVzhCsPQ@mail.gmail.com>
	<5973936.aJ38W1h68Q@vostro.rjw.lan>
	<744357E9AAD1214791ACBA4B0B909263011AE8DB@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:64353 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab3LBISD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Dec 2013 03:18:03 -0500
Received: by mail-ve0-f175.google.com with SMTP id jx11so8408691veb.20
        for <linux-acpi@vger.kernel.org>; Mon, 02 Dec 2013 00:18:02 -0800 (PST)
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263011AE8DB@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> Yes, there is a module parameter "thermal.crt=3D" for this.
> Say, you can reset the critical temperature to 110C via thermal.crt=3D=
110.

I was able to alleviate the problem with premature shutdown using this
parameter, but now I encounter the behavior that I saw described in
some documentation:

When a certain temperature is hit (I think it is ~84=B0C), the fan
switches to its maximum state, consequently, the temperature drops
rapidly (~5-7=B0C) and the fan's speed decreases immediately, causing
the temperature to rise again above that threshold etc. This cycle
repeats again and again in ~2-5 s intervals.

I also read in some documentation (of the thermal module IIRC) that
there is some mechanism to avoid just that unwanted behavior by some
hysteresis parameter which should provide that the fan does not switch
off until the processor is cooled down more thoroughly.
However, I could not find any way how to do that on my system (intel
HM65 chipset), as the virtual device does not seem to offer setting
such a parameter. I could also not find a cooling device of type 'fan'
in my /sys directory, only four virtual cooling devices of type
'processor' and one of type 'LCD' (so I do not quite understand how
the system even controls the different fan levels).

Can someone give me a hint (or reference to some documentation/how-to)
on how to achieve a sane cooling strategy for my laptop? Is it
possible anyway?

Thank you very much,

Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
