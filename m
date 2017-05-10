From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] acpi/button: revert v4.10 behavior
Date: Wed, 10 May 2017 18:12:38 +0200
Message-ID: <20170510161240.13229-1-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52261 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752929AbdEJQMw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 May 2017 12:12:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lv Zheng <lv.zheng@intel.com>
Cc: Jiri Eischmann <jeischma@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The new default 'open' behavior for acpi_lid_initialize_state() is just
wrong. It breaks professional laptops with a docking station [1].

Booting the laptop with the LID closed is something common and now there
is no way of knowing the actual state of the LID switch at boot. Please
use a user-space solution as described in 2/2 if you really don't want to
add quirks in the kernel.

Cheers,
Benjamin

[1] https://bugzilla.gnome.org/show_bug.cgi?id=782380

Benjamin Tissoires (2):
  Revert "ACPI / button: Remove lid_init_state=method mode"
  Revert "ACPI / button: Change default behavior to lid_init_state=open"

 Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
 drivers/acpi/button.c           | 11 ++++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.9.3

