From: Andy Lutomirski <luto@MIT.EDU>
Subject: [PATCH v3 0/2] Forcibly enable some MISC_ENABLE features on Intel
Date: Tue,  9 Aug 2011 08:41:04 -0400
Message-ID: <cover.1312893572.git.luto@mit.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@mit.edu>
List-Id: linux-acpi@vger.kernel.org

Intel allows BIOS or the OS to enable or disable some CPU fueatures via
IA32_MISC_ENABLE.  I have machines that don't enable fast strings or
monitor/mwait in BIOS, so do it on bootup instead.

The Intel SDM volume 3, appendix B.1 says that the OS should not touch
the monitor enable bit if SSE3 is not present, which presumably means
that the OS may touch that bit if SSE3 is present.  In any case, these
patches seem to work.

Changes from v2:
 - Don't linebreak printk messages (for ease of grepping)
 - Use printk_once
 - Update the "Disabled fast string operations" message

Changes from v1:
 - Display FW_WARN messages.
 - Don't change the kmemcheck message.
 - Improve the fast string comment.
 - Improve the changelogs.

Andy Lutomirski (2):
  x86: Enable fast strings on Intel if BIOS hasn't already
  x86: Enable monitor/mwait on Intel if BIOS hasn't already

 arch/x86/kernel/cpu/intel.c |   52 ++++++++++++++++++++++++++++++++++++++----
 1 files changed, 47 insertions(+), 5 deletions(-)

-- 
1.7.6
