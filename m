From: Javier Marcet <jmarcet@gmail.com>
Subject: IvyBridge ACPI SSDT bug
Date: Thu, 16 Aug 2012 11:45:09 +0200
Message-ID: <CAAnFQG9Wikp0jWrXmhwx1BjX2z0zC1X+z5dB2sMt_kg859dq_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45456 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2HPJpa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Aug 2012 05:45:30 -0400
Received: by ggdk6 with SMTP id k6so2701787ggd.19
        for <linux-acpi@vger.kernel.org>; Thu, 16 Aug 2012 02:45:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

Hi,

after some problems with an ASUS Sandy Bridge motherboard I had been using
for the last eight months, this week I replaced it with a GygaByte
H77M-D3H, with
the Ivy Bridge chipset.

When I first got the AUS board there was an ACPI problem which seemed to be a
bug in the bios. However the ACPI 5.0 update fixed it. Upstream it was
fixed with
commit 8931d9ea78848b073bf299594f148b83abde4a5e:

ACPICA: Fix to allow region arguments to reference other scopes

The bug broke suspension.

Now with this new board there is a problem with an ACPI method which cannot
be found, DSSP. It is referenced not on the main DSDT table but on one of the
SSDTs, the SATA table.

As far as I could gather the DSSP is not an official one and it is
affecting owners
of different brands of Ivy Bridge motherboards, Intel and ASUS among them.

Thus, even replacing the board by another brand is not warranty at all
I'll not be
affected by this bug. Furthermore, since this is for an HTPC/NAS, suspension
is mandatory.

I posted on the bug report open at
https://bugzilla.kernel.org/show_bug.cgi?id=43229
including logs. but so far no one has answered.

Is there any chance this can be fixed? I'm willing to help in any way.


-- 
Javier Marcet <jmarcet@gmail.com>
