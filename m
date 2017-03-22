From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/5] Intel PMIC: Intel PMIC mfd and OPRegion drivers must be built in
Date: Wed, 22 Mar 2017 12:29:18 +0100
Message-ID: <20170322112923.20200-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759250AbdCVL31 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 07:29:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi All,

Here is a series enforcing Intel PMIC mfd and OPRegion drivers to be built
in, this is necessary so that the OPRegion handlers are registered before
other drivers try to enter D0 which may require these OPRegion handlers.

Note patches 4 & 5 are for drivers which have been submitted but not
yet accepted in -next, so theoretically they could be squashed into
the original patches, but I believe it is good to keep them as separate
commits to have a git history which documents why these are builtin.

The patches span both the mfd and ACPI subsystems but can me merged
independently of each other I'm posting this as a single series as
both sides are part of fixing the same issue.

Regards,

Hans
