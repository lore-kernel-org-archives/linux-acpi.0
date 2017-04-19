From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 0/2] ACPI / PMIC: Intel CHT Whiskey Cove opregion driver + xpower opregion bugfix
Date: Wed, 19 Apr 2017 15:06:58 +0200
Message-ID: <20170419130700.31277-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763485AbdDSNHD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 09:07:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org

Hi All,

These 2 seem to have fallen through the cracks, hence this resend,
note the 1st patch has a minor change compared to the last time
it was send, its Kconfig option has been changed from a tristate
to a bool.

Regards,

Hans

p.s.

I'm going on vacation / offline starting tomorrow I will be back
May 1st, so if I'm responding to email that is why.
