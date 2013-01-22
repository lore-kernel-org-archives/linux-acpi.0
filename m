From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI / PM: Fixes related to the D3cold power state
Date: Tue, 22 Jan 2013 13:15:18 +0100
Message-ID: <4115893.XLRCUukpRD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

The following two patches fix issues related to the ACPI D3cold state:

[1/2] Use "D3cold" as the string representation of D3cold rather than "D3".
[2/2] Fix final value of power.state after device transitions to D3cold.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
