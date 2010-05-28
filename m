From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Preserve ACPI NVS region over S3
Date: Fri, 28 May 2010 23:19:31 +0300
Message-ID: <1275077971.20606.20.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:56765 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881Ab0E1UTj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 May 2010 16:19:39 -0400
Received: by fg-out-1718.google.com with SMTP id l26so753871fgb.1
        for <linux-acpi@vger.kernel.org>; Fri, 28 May 2010 13:19:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi,

I finally managed, to make S3 work.
The short story is that BIOS contains a bug, but it doesn't trip over it
due to windows non-conformance to ACPI.

The long story is that ACPI spec allows BIOS to declare a memory region
as a NVS (non volatile storage), and spec expects us to preserve it over
S4.

Linux does that, but now we know that windows does restore this region
over S3 too.

On my system BIOS changes this region slightly after a resume from S3,
and if S3 is attempted again, it hangs early before passing control to
linux.

The first patch (written by Matthew Garrett) makes this change.

I also add a patch that needs quite a lot of massage to apply after this
one, and somehow fell through the cracks. This patch fixes rare hang of
resume from disk. I rebased it on top of first patch.

Now, finally, after 2 years, both suspend & hibernate work reliably on
my laptop.

And thanks again for Matthew Garrett for verifying that indeed Windows
saves/restores the NVS region over S3.

Please let me know what you think.

Best regards,
Maxim Levitsky

