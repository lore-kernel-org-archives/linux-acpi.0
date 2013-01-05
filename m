From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [5/6] ACPI / PM: Move device power management functions to device_pm.c
Date: Sat, 5 Jan 2013 10:43:31 +0100
Message-ID: <CA+icZUXqt1KCskvpNuGuHj84HFnnYMe-y-ceMTLwv3nxTWz4tw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:56847 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab3AEJnc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2013 04:43:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Just a small typo in the comments:
...
+#ifdef CONFIG_PM
...
+#else /* !CONFIG_PM */
...
+#endif /* !CONFIG_PM */ <--- /* CONFIG_PM (without "!") */
...

- Sedat -
