From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/8] device async action mechanism
Date: Wed, 15 Jul 2009 15:38:32 +0800
Message-ID: <1247643512.26272.74.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753029AbZGOHhp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

this is the patch set I made to speed up the device
suspend/resume/shutdown process.

A new mechanism called Device Async Actions is introduced in this patch=
 set.
The basic idea is that,
1. device declares to support certain kinds of device async action,
   like suspend, resume, shutdown, etc.
2. a async domain is create for this device
3. the child device inherits the async domain
4. devices in the same domain suspend/resume/shutdown asynchronously wi=
th
   the other devices.

Currently, in order to make sure that it won't bring any side effects,
I only convert the ACPI battery and i8042 to use this framework, which =
reduces
0.5s+ S3 time(suspend time plus resume time)=EF=BB=BF, from 7.0s to les=
s than 6.5s.
and about 0.5s shutdown time in my test.

Any comments are welcome. :)

thanks,
rui


 drivers/acpi/battery.c      |   13 +++
 drivers/base/Makefile       |    3 +-
 drivers/base/async_dev.c    |  210 +++++++++++++++++++++++++++++++++++=
++++++++
 drivers/base/core.c         |   16 +++-
 drivers/base/power/main.c   |   10 ++-
 drivers/input/serio/i8042.c |   10 ++-
 include/linux/async.h       |    3 +
 include/linux/async_dev.h   |   45 +++++++++
 include/linux/device.h      |    2 +
 9 files changed, 306 insertions(+), 6 deletions(-)
