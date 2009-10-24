From: =?ISO-8859-1?Q?andreas_p=E5lsson?= <andreas.palsson+acpi@gmail.com>
Subject: ACPI events for laptop special buttons
Date: Sun, 25 Oct 2009 00:12:20 +0200
Message-ID: <477df590910241512v3ecc3b0dj7d0d115cdaea7f7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:56424 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbZJXWMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2009 18:12:16 -0400
Received: by ewy4 with SMTP id 4so2623590ewy.37
        for <linux-acpi@vger.kernel.org>; Sat, 24 Oct 2009 15:12:20 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

I recently bought a cute little Eee PC and of course I decided to run
Linux on it.
But some special buttons/keys doesn't work, like the "special FN key +
=463" which disables touchpad.

I did some research and if I understand it correctly, pressing those
buttons generate "ACPI events" which could (until it was recently
deprecated) be read from "/proc/acpi/events".


So now to my question, how do I catch those events?

Is it possible to read them from user-mode (like to have a nice graph
showing if touchpad/wifi is online or offline)?


I've not been digging around in the kernel before so I don't have yet
much understanding how things work, but one has to start somewhere and
a simple task like "is button pressed?" seems like the right thing. :)

Thank you.

PS. Apologies if this is the wrong list for questions like this.
--=20
andreas p=E5lsson
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
