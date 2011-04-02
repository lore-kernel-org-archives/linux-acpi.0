From: Andrea Gelmini <andrea.gelmini@gmail.com>
Subject: Re: Regression 2.6.39-rc1 for sony-laptop
Date: Sat, 2 Apr 2011 11:44:57 +0200
Message-ID: <BANLkTikPjwowBge82viT+Ma5UnP0fA-pew@mail.gmail.com>
References: <AANLkTi=1xtjEZc2C1=W-v2oYbvvcGH9k_DGGXvJ8=swq@mail.gmail.com>
	<20110401172241.GA26851@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110401172241.GA26851@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: anssi.hannula@iki.fi, linux-acpi@vger.kernel.org, axel.lin@gmail.com, trenn@suse.de, len.brown@intel.com, error27@gmail.com, malattia@linux.it, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

2011/4/1 Matthew Garrett <mjg59@srcf.ucam.org>:
> touch any Sony code. I'll take a look at the Sony patches, thanks for
> the report!

Hi Matthew,
   and thanks a lot for your quick answer.
   Maybe I messed up with bisect trying to find the origin of two regression.
   One was this. The other one is this one.

   Hibernation (to disk, of course) doesn't work no more.
   Screen blanks and nothing happens. No HD activity, and so on. I also
   waited some minutes.

   Well, bisect blame this commit:

commit 2a4f0c81adcd1f812a63bc9106be2fd26f437730
Author: Mattia Dongili <malattia@linux.it>
Date:   Sat Feb 19 11:52:30 2011 +0900

    sony-laptop: cache handles and report them via sysfs

    Avoid calling into acpi each time we need to lookup a method handle
    and report the available handles to ease collection of information when
    debugging issues. Also move initialization of the platform driver
    earlier to allow adding files from other setup functions.

    Signed-off-by: Mattia Dongili <malattia@linux.it>
    Signed-off-by: Matthew Garrett <mjg@redhat.com>

 drivers/platform/x86/sony-laptop.c |   97 ++++++++++++++++++++++++++++++------
 1 files changed, 81 insertions(+), 16 deletions(-)

   Do you have any suggestion to better track down this issue?
   It's not possibile to simply revert it.

Thanks a lot for your time,
Andrea
