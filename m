From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [patch 5/7] asus-acpi: remove duplicate comparison of asus_model
	strings
Date: Tue, 16 Feb 2010 10:59:46 +0100
Message-ID: <25e057c01002160159j54e0aec5mdd082e77dcc27193@mail.gmail.com>
References: <201002022237.o12MbveE018693@imap1.linux-foundation.org>
	<71cd59b01002030014y21ec9863i3f3a86c295c6078a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:42994 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851Ab0BPKAI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 05:00:08 -0500
Received: by bwz5 with SMTP id 5so1743457bwz.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2010 02:00:06 -0800 (PST)
In-Reply-To: <71cd59b01002030014y21ec9863i3f3a86c295c6078a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, sziwan@users.sourceforge.net

>> +++ a/drivers/platform/x86/asus_acpi.c

> Roel, are you still using this driver ? Have you a good reason to use
> it instead of asus-laptop ?

No, I just found the duplicate tests using grep and sed.

Thanks,

Roel
