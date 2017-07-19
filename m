From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 0/1] acpi: apei: Enable APEI multiple GHES source to share an single external IRQ
Date: Wed, 19 Jul 2017 13:24:26 -0400
Message-ID: <20170719172427.5478-1-msalter@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdGSRY7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Jul 2017 13:24:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Rafael,

What do you think of this one? I was submitted a long time ago but
there was never any real resolution to it.


Loc Ho (1):
  acpi: apei: Enable APEI multiple GHES source to share an single
    external IRQ

 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.13.3

