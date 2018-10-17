From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date: Wed, 17 Oct 2018 10:59:27 +0200
Message-ID: <20181017085928.13406-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael, Andy,

For the why and what of this patch see the (somewhat long) commit message.

The single patch in this set both touches drivers/acpi/scan.c and
drivers/platform/x86/intel_cht_int33fe.c, this is done this way to avoid
regressions when bisecting.

The main change here really is to ACPI change and intel_cht_int33fe.c is
modified to follow suit. Also I do not expect intel_cht_int33fe.c to see
much changes this cycle. As such I believe it would be best to merge this
patch through Rafael's tree (after review).

Andy is that ok with you and we have your ack for this?

Regards,

Hans
