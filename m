From: Dmitry Frank <mail@dmitryfrank.com>
Subject: [PATCH v2 0/3] ACPI: video: get rid of magic numbers, do other refactoring
Date: Wed, 19 Apr 2017 12:48:06 +0300
Message-ID: <20170419094809.12895-1-mail@dmitryfrank.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward11p.cmail.yandex.net ([87.250.241.139]:38906 "EHLO
        forward11p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761860AbdDSJ5J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 05:57:09 -0400
In-Reply-To: <20170418123558.12436-1-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Frank <mail@dmitryfrank.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, linux-acpi@vger.kernel.org

Hi,

This patchset makes the code more self-documented and clean.

Initially I was chasing a bug with the backlight on my laptop. Even though it's
clear now what causes the issue, I'm not sure what's the proper way to fix it,
so for now I just wrote about my research with the hope that someone could
help: http://www.spinics.net/lists/linux-acpi/msg73638.html , comments are
appreciated!

So this patchset is a cleanup which I've done on my way.

Dmitry Frank (3):
  ACPI: video: get rid of magic numbers and use enum instead
  ACPI: video: rename the global flag device_id_scheme
  ACPI: video: add comments about subtle cases

 drivers/acpi/acpi_video.c | 169 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 117 insertions(+), 52 deletions(-)

-- 
2.11.0

