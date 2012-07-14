From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] cpufreq fix for 3.5-rc7
Date: Sat, 14 Jul 2012 15:06:18 +0200
Message-ID: <201207141506.18345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull one cpufreq fix for 3.5-rc7 on top of commit
bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6

with commit hash c4686c71a9183f76e3ef59098da5c098748672f6

  cpufreq / ACPI: Fix not loading acpi-cpufreq driver regression

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git cpufreq-for-3.5-rc7

It fixes a regression that prevents the ACPI cpufreq driver from loading
on some systems where it previously worked without any problems.

Thanks!


 drivers/acpi/processor_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

---------------

Thomas Renninger (1):
      cpufreq / ACPI: Fix not loading acpi-cpufreq driver regression
