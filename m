From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.1-rc5
Date: Fri, 12 Apr 2019 10:11:27 +0200
Message-ID: <CAJZ5v0jfyUSTRs909hsPhDSEt__MGPKC+1UBsG8oieWE07nn5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc5

with top-most commit c5781ffbbd4f742a58263458145fe7f0ac01d9e0

 ACPICA: Namespace: remove address node from global list after method
termination

on top of commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d

 Linux 5.1-rc4

to receive an ACPI fix for 5.1-rc5.

This fixes an ACPICA issue introduced during the 4.20 development cycle
and causing some systems to crash because of leftover operation region
data still maintained after the operation region in question has gone
away (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPICA: Namespace: remove address node from global list after
method termination

---------------

 drivers/acpi/acpica/nsobject.c | 4 ++++
 1 file changed, 4 insertions(+)
