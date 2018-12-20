From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] ACPI / scan: Create platform device for BSG2150 ACPI nodes
Date: Thu, 20 Dec 2018 15:34:50 +0100
Message-ID: <20181220143451.25962-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi All,

This patch adds support for another ACPI HID which describes multiple
i2c-clients in a single node. As such this applies on top of the recent
patch from Andy making a similar change for INT3515 nodes:

Commit a3dd034a1707 ("ACPI / scan: Create platform device for INT3515
ACPI nodes"), which is in the platform-drivers-x86-v4.21-1 tag.

As such I believe it would be best to merge this tree through the
linux-platform-drivers-x86 tree, as was done for the INT3515 patch.

Rafael, may we have your ack for merging the single line drivers/acpi
change through the linux-platform-drivers-x86 tree?

Regards,

Hans
