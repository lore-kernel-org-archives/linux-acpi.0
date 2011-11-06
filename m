From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI ALS Status ?
Date: Sun, 6 Nov 2011 17:16:03 -0500
Message-ID: <CAJvTdKnW9VESyiF7Rden698EvRgT=805hyKXtXhFpKkTxLv64w@mail.gmail.com>
References: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50481 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab1KFWQF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Nov 2011 17:16:05 -0500
Received: by bke11 with SMTP id 11so3183404bke.19
        for <linux-acpi@vger.kernel.org>; Sun, 06 Nov 2011 14:16:03 -0800 (PST)
In-Reply-To: <CAHR064iRm37Wf4QrYEOvsxT0=wZZbY1XQiZfmrJdqyTj1h8sPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Pavel Machek <pavel@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

> I was looking at the DSDT of a new samsung laptop (I can send you the
> output of acpidump if interested), and it export a standard ACPI ALS
> device. So, it's actually great to see vendor using that, but it seems
> that the series adding support for that and sent back in 2009 is not
> available in the kernel. I'd really like to use my the ALS, what's the
> current status of the driver ? Still blocked because we don't have a
> generic sysfs class ? If yes, can't we just use a non-standard
> interface ? It would still be better than no driver at all.

Yes, I think ACPI ALS support has been waiting for hardware to justify
its existence.

When it first entered the spec, we were excited to see it was present
in some high-end laptops, but IIR on closer examination the AML turned
out to be dummy code.

If you can verify that your Samsung really does implement ACPI ALS,
then that is all we need to stumble forward.

thanks,
-Len Brown, Intel Open Source Technology Center
