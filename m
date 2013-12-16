From: Carlos Garnacho <carlosg@gnome.org>
Subject: [PATCH 0/5] hooking udev to SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 00:00:09 +0100
Message-ID: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:38972 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3LPW7y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2013 17:59:54 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so2550156eak.30
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2013 14:59:53 -0800 (PST)
Received: from sacarino.redhat.com (5ED2AFE7.cm-7-3c.dynamic.ziggo.nl. [94.210.175.231])
        by mx.google.com with ESMTPSA id e3sm47458159eeg.11.2013.12.16.14.59.52
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2013 14:59:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The following patches make it possible to have udev/userspace notified when
SW_TABLET_MODE changes on the switch device, without having to resort to
poll()/select() for such sparse events. I've got udev patches locally to
complement this.

I've been just able to test on thinkpad_acpi (X220T), hp-wmi (Touchsmart
TX2) and xo15-ebook. The per-module change is straightforward enough, but
an ack would still be great on classmate and fujitsu modules.

Carlos Garnacho (5):
  thinkpad_acpi: Send uevent when SW_TABLET_MODE changes
  hp-wmi: Send uevent when SW_TABLET_MODE changes
  xo15-ebook: Send uevent when SW_TABLET_MODE changes
  classmate-laptop: Send uevent when SW_TABLET_MODE changes
  fujitsu-tablet: Send uevent when SW_TABLET_MODE changes

 drivers/platform/x86/classmate-laptop.c | 2 ++
 drivers/platform/x86/fujitsu-tablet.c   | 1 +
 drivers/platform/x86/hp-wmi.c           | 3 +++
 drivers/platform/x86/thinkpad_acpi.c    | 2 ++
 drivers/platform/x86/xo15-ebook.c       | 1 +
 5 files changed, 9 insertions(+)

-- 
1.8.5.1

