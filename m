From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PNP fix for v4.8-rc1
Date: Fri, 5 Aug 2016 16:51:26 +0200
Message-ID: <CAJZ5v0hNT0wpfhZoNxjs1PQ7sevpupaAKnZzzgahRwHhCsFx5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pnp-extra-4.8-rc1

with top-most commit 61a67a366d5b5f9e3c8f27d056a3a67ede2a0026

 PNP: pnpbios: add header file to fix build errors

on top of commit 59ebc44e8dac359812f317473c4f05cd1432f5d2

 Merge tag 'pnp-4.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an additional PNP update for v4.8-rc1.

This fixes build errors due to a missing header file inclusion in
drivers/pnp/pnpbios/core.c (Randy Dunlap).

Thanks!

---------------

Randy Dunlap (1):
      PNP: pnpbios: add header file to fix build errors

---------------

 drivers/pnp/pnpbios/core.c | 1 +
 1 file changed, 1 insertion(+)
