From: Andreas Noever <andreas.noever@gmail.com>
Subject: Options for handling a broken dsdt.
Date: Thu, 5 Dec 2013 22:29:14 +0100
Message-ID: <CAMxnaaX6HOtDDXTmz2wwStMDKh=7v4hUkhpw55XrQL=dFCKdmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52812 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab3LEV3g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Dec 2013 16:29:36 -0500
Received: by mail-wi0-f180.google.com with SMTP id hn9so323624wib.13
        for <linux-acpi@vger.kernel.org>; Thu, 05 Dec 2013 13:29:34 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I am working on a thunderbolt driver for Mac Books (see [1] if you are
interested). I have got basic hotplug working but I am still
struggling with suspend issues. The problem is that ACPI will cut
power to the controller during startup/suspend/resume whenever it does
not detect Darwin. Furthermore the ACPI method which could be used to
re enable power is inactive if Darwin is not detected.

I have tried to use acpi_osi to make the firmware believe that it is
running Darwin. This does work but breaks other stuff (the firmware
contains a lot of OS specific code paths, for example _OSC breaks...).

My question would then be whether there exists a more user friendly
alternative to a custom DSDT? My plan is to somehow exchange/modify a
few ACPI methods from within my driver. Would a driver which does this
be accepted or is that a complete no-go? Is there any infrastructure
in place to help me with this? Am I missing some alternatives?

Thanks,
Andreas

[1] https://lkml.org/lkml/2013/11/28/492
