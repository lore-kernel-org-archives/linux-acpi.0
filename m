From: Daniel Toussaint <daniel@dmhome.net>
Subject: Driver for handling SCI interrupt.
Date: Mon, 6 Feb 2012 11:25:20 +0800
Message-ID: <CADVYk4RTY3=Xiw5JsiDssN9i3yo+jQw1p_i42tKrMDVH5=_ykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:56145 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab2BFDZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2012 22:25:21 -0500
Received: by qafk1 with SMTP id k1so3415819qaf.19
        for <linux-acpi@vger.kernel.org>; Sun, 05 Feb 2012 19:25:20 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Dear list,

I am working on an Intel (ICH8) based system. A custom device on the system
emits interrupts to a GPI on the ICH8 chip. Currently, as a test, I have
from userspace configured the GPI we use to send a SCI. This seems to work,
because I get a "IRQ9 , nobody cared" message from the kernel.
My questions now are :
How do I go about and create an ACPI based driver to catch this event ? Or am
I searching in the wrong direction.
If I am right, and the driver has to go through ACPI, are changes to the
ACPI tables in BIOS required ?

Greetings,

Daniel

--
Gtalk: daniel.toussaint@gmail.com
Skype: supertoussi
Cell: +886-915-680-291
