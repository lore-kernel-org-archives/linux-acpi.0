From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH] Store BIOS NVS area over s2ram [V2]
Date: Tue, 01 Jun 2010 21:19:50 +0300
Message-ID: <1275416390.3778.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:3429 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab0FASTz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2010 14:19:55 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1308883fgb.1
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jun 2010 11:19:54 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

Hi,

This is rebased and slightly updated version of Matthew Garrett's
patches.
Tested on my system.

Note that now I got positive feedback from 2 users of this system that
this approach works, and no negative feedback.

Please review.

Best regards,
Maxim Levitsky

