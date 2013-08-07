From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] ACPI: More acpi_bind_one() cleanups
Date: Thu, 08 Aug 2013 01:54:05 +0200
Message-ID: <5685060.iNWFUGc9at@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

Two more cleanups for acpi_bind_one() on top of linux-pm.git/linux-next
follow:

[1/2] Drop unnecessary label from acpi_bind_one().
[2/2] Print diagnostic messages if device links cannot be created.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
