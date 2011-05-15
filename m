From: Ricardo Mendoza <ricmm@gentoo.org>
Subject: Toshiba R830 brightness and suspend to RAM
Date: Sun, 15 May 2011 12:42:14 +0000
Message-ID: <BANLkTi=3Nf4=C0Q5+Co5-h9AY0L3LGJXsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59819 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1EOMmQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 May 2011 08:42:16 -0400
Received: by wwk4 with SMTP id 4so1829726wwk.1
        for <linux-acpi@vger.kernel.org>; Sun, 15 May 2011 05:42:14 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've recently purchased a new laptop and I've crashed head-on with the
problem that brightness control works perfectly until suspend-to-RAM
is issued; after resuming from RAM the brightness controls are
completely unresponsive and there the brightness is locked to a random
level.

The problem however solves itself magically upon a power cycle, be
that a reboot or just a suspend-to-disk.

Let alone the obvious considerations on power consumption for a
laptop, the brightness situation is annoying too in terms of eye
strain.

This bug is not new and has been tracked in:

https://bugzilla.kernel.org/show_bug.cgi?id=21012
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=599768

and several other distro bugzillas.

I've never hacked around acpi but if anyone has any ideas of pointers
where to start then I'll be more than eager to get to work.


     Ricardo
