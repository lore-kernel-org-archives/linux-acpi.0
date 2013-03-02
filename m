From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / LPSS: Clocks handling rework and LTR support
Date: Sat, 02 Mar 2013 23:26:49 +0100
Message-ID: <1878438.IOSu0hheXQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mike Turquette <mturquette@linaro.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following two patches rework the initialization of Intel Lynxpoint LPSS
device clocks and add support for reading LTR (Latency Tolerance Reporting)
registers of those devices.

[1/2] Add special ACPI scan handler for Intel Lynxpoint LPSS devices.
[2/2] Add support for exposing the LTR registers of LPSS devices to user space.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
