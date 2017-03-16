From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/2] Only wait for INT3394 extcon to show ip if enabled
Date: Thu, 16 Mar 2017 17:17:34 +0100
Message-ID: <20170316161736.339-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752946AbdCPQRk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Mar 2017 12:17:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hi All,

As with my previous (somewhat related) series the last patch of this series
depend on the first, as such it might be better to merge both through the
acpi tree if Sebastius is ok with that.

Otherwise these patches too are pretty self-explanatory.

Regards,

Hans
