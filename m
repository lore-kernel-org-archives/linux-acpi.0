From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / PM: Fixes related to GPE race conditions
Date: Mon, 01 Dec 2014 02:52:16 +0100
Message-ID: <2017469.J3BZteXtBu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following two patches fix race conditions related to ACPI GPEs and PM.

The first one if for a race between wholesale disabling of GPEs (during
system suspend and shutdown) and the handling of level-triggered GPEs.  The
race is that the latter may re-enable a GPE disabled by the former under
specific conditions, which is not good.

The second one is to prevent suspend-to-idle from leaking GPE handling
into the late code (that has been sent once already).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
