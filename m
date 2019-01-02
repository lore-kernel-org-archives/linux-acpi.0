From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Device properties framework fixes for v4.21-rc1
Date: Wed, 2 Jan 2019 11:33:42 +0100
Message-ID: <CAJZ5v0h9Xj-gqYfkJFoEyVoFQKm1hBKboPtcvmPzE0OYTLu0sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.21-rc1-2

with top-most commit f4747b9c68b8864cac32cddc45fdcfdfafb3397c

 drivers: base: swnode: check if swnode is NULL before dereferencing it

on top of commit d8924c0d76aaa52e4811b5c64115d9a7f36cc73a

 Merge tag 'devprop-4.21-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive device properties framework fixes for v4.21-rc1.

These fix two potential NULL pointer dereferences found by Coverity
in the software nodes code introduced recently (Colin Ian King).

Thanks!


---------------

Colin Ian King (2):
      drivers: base: swnode: check if pointer p is NULL before dereferencing it
      drivers: base: swnode: check if swnode is NULL before dereferencing it

---------------

 drivers/base/swnode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
