From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Bad libata resume behaviour due to ACPICA change (in acpi-test)
Date: Thu, 8 Feb 2007 13:30:25 -0200
Message-ID: <20070208153025.GA466@khazad-dum.debian.net>
References: <20070203004140.GB619@khazad-dum.debian.net> <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34175 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbXBHPag (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2007 10:30:36 -0500
Content-Disposition: inline
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC803F9D@mssmsx411>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Mon, 05 Feb 2007, Starikovskiy, Alexey Y wrote:
> I cannot reproduce your problem with T43 here on linux-acpi-test with
> defconfig (relevant ACPI modules were tried both dynamic and static).
> Resume time is about 4-6 seconds, not 20-40 as you mention.
> Could you please send your .config and try defconfig on your machine?

Sorry for the delay on doing the tests.  2.6.20+acpi-test defconfig does NOT
do ACPI S3, so I had to use defconfig with SMP turned off (that was the only
change).  Are you sure you tried linux-acpi-test in 2.6.20 defconfig without
any changes?

gcc is Debian 3.4.6-5.  I am avoiding 4.1.1 because of the reports of it
miscompiling the kernel sometimes.

The bug changed behaviour a little in defconfig.  Now, I get the "Restarting
tasks ... done" right away after the line that used to hang (SCSI device
sda: write cache...", and THEN it hangs for about 20s.

In my default T43 kernel, I get "Restarting tasks ... done" *before* the
(SCSI device sda: write cache..." line.

So the hang is still there, it is still 100% reproducible here, but I am not
sure it has much to do with libata.  It might have something to do with
whatever happens after "Restarting tasks ... done", and libata resume just
happens to be running in another thread at that time and outputs its stuff
through printk.

Any ideas on how to debug this further?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
