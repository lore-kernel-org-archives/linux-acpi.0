From: Andy Lutomirski <luto@kernel.org>
Subject: 4.5 regression: ACPI hangs when backlight hotkeys are pressed
Date: Mon, 18 Jan 2016 12:52:53 -0800
Message-ID: <CALCETrXkN1=iT80Rv3J4ywJmkA8pMd7E+u1OytSZPwpPjr6y2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46898 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251AbcARUxR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jan 2016 15:53:17 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C8FCC203AC
	for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2016 20:53:16 +0000 (UTC)
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 25354203C1
	for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2016 20:53:14 +0000 (UTC)
Received: by mail-ob0-f181.google.com with SMTP id ba1so582325302obb.3
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2016 12:53:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Adrien Schildknecht <adrien+dev@schischi.me>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

I'm running 4.4 with the pm+acpi-4.5-rc1-1 merged in.  After pressing
the backlight hotkeys a couple times, things start to break.  Poking
at hung thread stacks, it appears that calls to
acpi_video_handles_brightness_key_presses never return.

It appears that the culprit is:

commit aecbd9b1bff6afbe349921b406b99d285b412820
Author: Adrien Schildknecht <adrien+dev@schischi.me>
Date:   Mon Jan 4 23:22:28 2016 +0100

    ACPI / video: driver must be registered before checking for keypresses

Reverting that patch makes my laptop work again.

I don't know what that patch is trying to do, but it looks highly
questionable to me.  Why should an accessor wait for a potential
different driver to register something?  I see no guarantee that it
will eve happen.

This is a Dell XPS 13 9350.

--Andy
