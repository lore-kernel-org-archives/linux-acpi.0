From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.18-rc7
Date: Thu, 26 Jul 2018 16:13:24 +0200
Message-ID: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
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
 acpi-4.18-rc7

with top-most commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000

 ACPICA: AML Parser: ignore dispatcher error status during table load

on top of commit d72e90f33aa4709ebecc5005562f52335e106a60

 Linux 4.18-rc6

to receive an ACPI fix for 4.18-rc7.

This fixes a recent ACPICA regression causing the AML parser to get
confused and fail in some situations involving incorrect AML in an
ACPI table (Erik Schmauss).

Thanks!


---------------

Schmauss, Erik (1):
      ACPICA: AML Parser: ignore dispatcher error status during table load

---------------

 drivers/acpi/acpica/psloop.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
