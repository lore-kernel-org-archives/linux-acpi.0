From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.17-rc4
Date: Fri, 4 May 2018 12:10:46 +0200
Message-ID: <CAJZ5v0h_9dJ3Hcen7J759-=qHW-c4f9mntMMRi2pNhgK1j5ZtQ@mail.gmail.com>
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
 acpi-4.17-rc4

with top-most commit 755396163148b50fe1afb4bdd3365e47f3ff7a42

 tools: power/acpi, revert to LD = gcc

on top of commit 6da6c0db5316275015e8cc2959f12a17584aeb64

 Linux v4.17-rc3

to receive an ACPI tools fix for 4.17-rc4.

This fixes an ACPICA utilities (acpidump) build regression from the
4.16 cycle by setting LD in the CFLAGS passed to the linker to $(CC)
again (Jiri Slaby).

Thanks!


---------------

Jiri Slaby (1):
      tools: power/acpi, revert to LD = gcc

---------------

 tools/power/acpi/Makefile.config | 1 +
 1 file changed, 1 insertion(+)
