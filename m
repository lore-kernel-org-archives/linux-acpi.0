From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH 0/6] acpi-cpufreq and powernow-k8 fixes
Date: Sun, 20 Jan 2013 11:24:24 +0100
Message-ID: <1358677470-17394-1-git-send-email-bp@alien8.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41417 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab3ATKYj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2013 05:24:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?q?Andr=C3=A9=20Przywara?= <andre@andrep.de>, Leonid Isaev <lisaev@umail.iu.edu>, Tom Gundersen <teg@jklm.no>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>

From: Borislav Petkov <bp@suse.de>

Hi all,

here are a couple of patches fixing acpi-cpufreq and powernow-k8 loading
sequence and handoff.

Patch 0001 should be in Rafael's tree already but I'm adding it here for
the sake of completeness. Basically, we want to address all possible
cases of powernow-k8 and acpi-cpufreq:

(M: module, Y: built-in)

powernow-k8		acpi-cpufreq
M			M		- powernow-k8 requests acpi-cpufreq
M			Y		- powernow-k8 sees already loaded acpi-cpufreq
Y			M		- impossible after patch 0001
Y			Y		- patches 2,3 fix that

Anyway, please take a look and let me know.

Thanks.




Borislav Petkov (5):
  powernow-k8: Add a kconfig dependency on acpi-cpufreq
  cpufreq: Make acpi-cpufreq link first
  cpufreq: Add a get_current_driver helper
  powernow-k8: Cleanup module request
  powernow-k8: Cleanup init function

Matthew Garrett (1):
  acpi-cpufreq: Do not load on K8

 drivers/cpufreq/Kconfig.x86    |  2 +-
 drivers/cpufreq/Makefile       |  5 +++--
 drivers/cpufreq/acpi-cpufreq.c |  6 ++++++
 drivers/cpufreq/cpufreq.c      | 14 +++++++++++++
 drivers/cpufreq/powernow-k8.c  | 46 ++++++++++++++++++++++++++++++------------
 include/linux/cpufreq.h        |  1 +
 6 files changed, 58 insertions(+), 16 deletions(-)

-- 
1.8.1.rc3

