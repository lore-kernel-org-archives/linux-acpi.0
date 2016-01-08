From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Last-minute ACPI fix for final v4.4
Date: Fri, 8 Jan 2016 23:38:47 +0100
Message-ID: <CAJZ5v0h7P+OJZuN8q-ExKsUgMNdvnr9mf8OL8-FD+A1yvFQtcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.4-final

to receive an ACPI fix for final v4.4 as commit 9db22d928ca9

 ACPI / property: avoid leaking format string into kobject name

on top of commit 168309855a7d1e16db751e9c647119fe2d2dc878

 Linux 4.4-rc8

Just one obvious fix that adds a missing function argument in
ACPI code introduced recently (Kees Cook).

Thanks!


---------------

Kees Cook (1):
      ACPI / property: avoid leaking format string into kobject name

---------------

 drivers/acpi/device_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
