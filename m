From: Ian Malone <ibmalone@gmail.com>
Subject: 3.4/3.5 kernels not booting in intel 945/950 chipset
Date: Wed, 11 Jul 2012 17:26:24 +0100
Message-ID: <CAL3-7MoQVLyKBxdfDFK5OT5nNR6Djmtm4S4OkJBhUZszxmH-GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33513 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab2GKQ0Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jul 2012 12:26:25 -0400
Received: by qcro28 with SMTP id o28so905300qcr.19
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jul 2012 09:26:24 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I'm using Fedora 17 and have the following bug:
https://bugzilla.redhat.com/show_bug.cgi?id=834318 where 3.4 and 3.5
series kernels run into a kernel panic during boot which appears to be
related to ACPI, on a Sony VGN-C2M/W Vaio
http://www.sony.co.uk/support/en/product/VGN-C2M_W/specifications
(Intel 945/950 chipset, core 2 duo).

acpidump is attached to the Fedora bug:
https://bugzilla.redhat.com/attachment.cgi?id=593488

As are screenshots of the startup messages:
https://bugzilla.redhat.com/attachment.cgi?id=593486
https://bugzilla.redhat.com/attachment.cgi?id=593487

Passing acpi=off allows the machine to boot. Another reporter has
found what might be the same problem on a Mac Pro. I've tried Fedora's
3.4.0 and 3.5.0-rc6 packaged kernels (as in bug entry) as well as a
number of 3.4.x updates.

Does anyone have any suggestions for things to try or any more
information I could collect?

Thanks for your time,
Ian
-- 
imalone
http://ibmalone.blogspot.co.uk
