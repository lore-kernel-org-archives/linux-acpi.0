From: Chase Douglas <chase.douglas@ubuntu.com>
Subject: Re: [PATCH] Reduce ACPI resource conflict message to KERN_INFO,
	printf cleanup
Date: Wed, 17 Mar 2010 10:15:20 -0400
Message-ID: <40ec3ea41003170715o250e6457hbc0a0025ea6da3bc@mail.gmail.com>
References: <1267633294-21815-1-git-send-email-chase.douglas@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f198.google.com ([209.85.216.198]:51183 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab0CQOPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Mar 2010 10:15:21 -0400
Received: by pxi36 with SMTP id 36so544769pxi.21
        for <linux-acpi@vger.kernel.org>; Wed, 17 Mar 2010 07:15:21 -0700 (PDT)
In-Reply-To: <1267633294-21815-1-git-send-email-chase.douglas@ubuntu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Wed, Mar 3, 2010 at 12:21 PM, Chase Douglas <chase.douglas@ubuntu.com> wrote:
> From: Chase Douglas <chase.douglas@canonical.com>
>
> By default, ACPI resource conflict messages are logged at level
> KERN_ERR. This is a rather high level for a message that is more a
> warning than an indication of a real kernel error. Also, KERN_ERR level
> messages can appear over some boot splash screens, and this message is
> not serious enough to warrant such treatment. Thus, the log level has
> been reduced to KERN_INFO.
>
> Also, cleanup message to use %pR resource printing format.

I saw a bunch of patches get rolled into the acpi tree and pulled into
Linus' tree two days ago. I'm not familiar with the process for how
patches are handled in the acpi tree, so when should I expect to see
this patch get pulled in (or NAK'd)?

Thanks,
Chase
