From: Simon Kitching <skitching@apache.org>
Subject: Index is beyond end of object; Method parse/execution failed
Date: Tue, 08 Sep 2009 21:16:05 +0200
Message-ID: <1252437365.5669.14.camel@simon-laptop>
Reply-To: skitching@apache.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from viefep31-int.chello.at ([62.179.121.49]:46668 "EHLO
	viefep31-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbZIHTfL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2009 15:35:11 -0400
Received: from edge04.upc.biz ([192.168.13.239]) by viefep16-int.chello.at
          (InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
          id <20090908191606.BCKS422.viefep16-int.chello.at@edge04.upc.biz>
          for <linux-acpi@vger.kernel.org>; Tue, 8 Sep 2009 21:16:06 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All,

Suspend-to-mem and resume seem to work fine, but I get a few odd ACPI
messages in dmesg. Is this of interest to anyone?

[  188.914261] ACPI Exception: AE_AML_PACKAGE_LIMIT, Index (000000005)
is beyond end of object 20090521 exoparg2-445
[  188.914278] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.C248] (Node f701a6d8), AE_AML_PACKAGE_LIMIT
[  188.914344] ACPI Error (psparse-0537): Method parse/execution failed
[\_SB_.C002.C0DE.C354._STM] (Node f701d780), AE_AML_PACKAGE_LIMIT
[  188.914415] ata5: ACPI set timing mode failed (status=0x300b)


Kernel: 2.6.31-rc9
Distro: ubuntu 09.04
Hardware: Compaq nc8430 laptop
CPU: core duo T2500

These messages are generated every time I run
   echo "mem" > /sys/power/state
although otherwise the suspend/resume seems 100% ok.

I'm happy to provide more info or run tests if anyone wants me to.

Regards, Simon

