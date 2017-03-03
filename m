From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Additional ACPI update for v4.11-rc1
Date: Fri, 3 Mar 2017 02:01:22 +0100
Message-ID: <CAJZ5v0juCbUJC0GMt9nHtNCnbHkr8LMHBQ+jwEiGJftLz0u02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-extra-4.11-rc1

with top-most commit 0cb3b79efabd4174ddeee40c2c1e5499ba67e067

 Merge branch 'acpi-apei'

on top of commit 43e31e40473a00c936ffb9c2eebedc0566c92e89

 Merge tag 'acpi-4.11-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an extra ACPI update for v4.11-rc1.

This fixes an apparent, but actually artificial, resource conflict
between the ACPI NVS memory region and the ACPI BERT (Boot Error
Record Table) address range (Huang Ying).

Thanks!

---------------

Huang Ying (1):
      ACPI: APEI: Fix BERT resources conflict with ACPI NVS area

---------------

 drivers/acpi/apei/bert.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)
