From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/7] power: supply: bq24190_charger: Various fixes + extcon support
Date: Wed, 22 Mar 2017 15:54:36 +0100
Message-ID: <20170322145443.29782-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Sebastian, Liam, All,

As discussed here is a v2 of my bq24190 charges. I'm not 100% sure
the last patch should go upstream as is, we do want to remove the
battery power_supply but I'm not sure about the timing of doing so.

>From my pov the other patches are ready for merging, but I guess there
may be some remarks and a v3 of this set will be necessary :)

Regards,

Hans
