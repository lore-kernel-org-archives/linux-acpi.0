From: Richard <tuxbox.guru@gmail.com>
Subject: 2.6.25 pci=noacpi
Date: Tue, 29 Apr 2008 07:53:57 +0100
Message-ID: <4816C605.4000601@gmail.com>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080425183934.516655076@ldl.fc.hp.com> <4813B5AB.4060308@keyaccess.nl> <200804281507.38309.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:65374 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbYD2GyF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 02:54:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1054408ugc.16
        for <linux-acpi@vger.kernel.org>; Mon, 28 Apr 2008 23:54:04 -0700 (PDT)
In-Reply-To: <200804281507.38309.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>, Andrew Morton <akpm@linux-foundation.org>

Hi all,

Using an AMD Sempron notebook (HP Compaq 6715b) single processor 
machine,  It shuts down during bootup when ACPI is fully enabled.  I 
added pci=noacpi to the cmdline and it finally boots, but its extremely 
slow...  (kdm times out with error saying it took too long to load and 
disables graphical)

Dmesg doest show anything out of the ordinary, irq_stats only shows the 
timer interrupts being incremented. (noirq also works, but same 
behaviour) Can someone please offer me some pointers so I can fault find 
this problem.

Thanks in advance
Richard
