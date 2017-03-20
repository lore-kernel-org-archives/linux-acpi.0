From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/3] Add Intel Cherry Trail Whiskey Cove PMIC support
Date: Mon, 20 Mar 2017 22:29:58 +0100
Message-ID: <20170320213001.11163-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755220AbdCTVaI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 17:30:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

Here is a v2 (v4 for the first 2 patches) of patches 1-3 from my
Intel Cherry Trail Whiskey Cove PMIC support series.

I believe these 3 patches are ready for merging into the mfd / acpi /
extcon subsystems now. They can be merged indepdently, so I would
like to ask the maintainers of these subsystems to merge these now.

Next up is a rework of some of the other patches I will send a v2
of those when ready, but these do not need to wait for those (and
at least the mfd + acpi patch together fix suspend/resume issues on
some devices so are useful without the rest).

Regards,

Hans
