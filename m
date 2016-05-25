From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Additional ACPI update for v4.7-rc1
Date: Wed, 25 May 2016 22:51:13 +0200
Message-ID: <CAJZ5v0gNjckTo55rG6WL3rjyLEqa=a7NqSGFtZD3OUa=z1egiQ@mail.gmail.com>
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
 acpi-4.7-rc1-more

to receive an additional ACPI update for v4.7-rc1 with top-most
commit 0cc4b48149ff6948dd82a039ad55cdbec49107f7

 Merge branch 'acpi-battery'

on top of commit 46c13450624e36302547a2ac3695f2350fe7ffc3

 Merge tag 'acpi-4.7-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

Just one fix for incorrect async_synchronize_cookie() usage in the
ACPI battery driver (Chris Wilson).

Thanks!

---------------

Chris Wilson (1):
      ACPI / battery: Correctly serialise with the pending async probe

---------------

 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
