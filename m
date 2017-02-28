From: Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] Pull request fro 4.11 for IPMI
Date: Mon, 27 Feb 2017 20:02:00 -0600
Message-ID: <101a1825-e3da-19fc-c030-90c62c31bb88@acm.org>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36298 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdB1Cht (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Feb 2017 21:37:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ipmitool-devel <ipmitool-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bhumika Goyal <bhumirks@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rami Rosen <ramirose@gmail.com>

The following changes since commit c433eb70f37de2514f3ae3d43dd7e4a75493fe48:

   Merge tag 'pinctrl-v4.10-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl 
(2017-01-05 10:36:56 -0800)

are available in the git repository at:

   git://git.code.sf.net/p/openipmi/linux-ipmi tags/for-linus-4.11

for you to fetch changes up to eb994594bc22220976f367c03ffa141580aa45e4:

   ipmi: bt-bmc: Use a regmap for register access (2017-02-20 11:00:48 
-0600)

----------------------------------------------------------------
This is a few small fixes to the main IPMI driver, make some
things const, fix typos, etc.

The last patch came in about a week ago, but IMHO it's best to
go in now.  It is not for the main driver, it's for the bt-bmc
driver, which runs on the management controller side, not on
the host side, so the scope is limited and the change is
necessary.

Thanks,

-corey

----------------------------------------------------------------
Andrew Jeffery (1):
       ipmi: bt-bmc: Use a regmap for register access

Bhumika Goyal (1):
       char: ipmi: constify ipmi_smi_handlers structures

Corey Minyard (2):
       ipmi: make ipmi_usr_hndl const
       acpi:ipmi: Make IPMI user handler const

Rami Rosen (1):
       Documentation: Fix a typo in IPMI.txt.

  Documentation/IPMI.txt              |  2 +-
  drivers/acpi/acpi_ipmi.c            |  2 +-
  drivers/char/ipmi/Kconfig           |  3 +-
  drivers/char/ipmi/bt-bmc.c          | 80 
+++++++++++++++++++++++++++----------
  drivers/char/ipmi/ipmi_devintf.c    |  2 +-
  drivers/char/ipmi/ipmi_msghandler.c |  4 +-
  drivers/char/ipmi/ipmi_powernv.c    |  2 +-
  drivers/char/ipmi/ipmi_watchdog.c   |  2 +-
  include/linux/ipmi.h                |  2 +-
  9 files changed, 69 insertions(+), 30 deletions(-)

