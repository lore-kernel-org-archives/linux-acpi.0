From: fanderay <fanderay4@gmail.com>
Subject: Backlight regression on Sony laptop: 3.2.x -> 3.4.2
Date: Sun, 10 Jun 2012 12:51:17 +0100
Message-ID: <CAE9NR2NDrtJzrdBYdHWuWMRgEuqdxT8D8cys7ivUVSSYaDd8Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51304 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2FJLvS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jun 2012 07:51:18 -0400
Received: by obbtb18 with SMTP id tb18so5121495obb.19
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jun 2012 04:51:18 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

For many kernel releases the ACPI backlight support has worked fine on
this Sony SR19VN laptop by default.  Yesterday, though, I moved from
3.2.9 to 3.4.2 and found that /sys/class/backlight was empty, so that
backlight control wasn't possible.  I can work around this with
acpi_backlight=vendor.

(Details of this laptop can be found at
https://bugzilla.kernel.org/show_bug.cgi?id=13148)
