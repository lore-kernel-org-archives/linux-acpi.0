From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] PM: Fix some unused function warnings for CONFIG_PM_SLEEP
Date: Wed, 8 Aug 2012 23:08:15 +0200
Message-ID: <201208082308.15466.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

The recent conversion to the PM handling based on struct dev_pm_ops
uncovered some code that is not used for CONFIG_PM_SLEEP unset, which
results in a number of new copiler warning.

Admittedly, I should have spotted those places before, but anyway
patches fixing those for ACPI, platform/x86 and tpm_tis follow.

Thanks,
Rafael
