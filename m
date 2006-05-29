From: Diederick de Vries <diederick@diederickdevries.net>
Subject: (newby qustion) sleep states?
Date: Mon, 29 May 2006 19:48:48 +0200
Message-ID: <200605291948.48949.diederick@diederickdevries.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from h100182.upc-h.chello.nl ([62.194.100.182]:29646 "EHLO
	zaphod.diederickdevries.net") by vger.kernel.org with ESMTP
	id S1751113AbWE2RsE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 May 2006 13:48:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zaphod.diederickdevries.net (Postfix) with ESMTP id AA17A17BE0
	for <linux-acpi@vger.kernel.org>; Mon, 29 May 2006 19:48:49 +0200 (CEST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a Compaq Armada E500 laptop, which I used to be able to get to sleep 
using something like

echo x > /proc/acpi/sleep

/proc/acpi/sleep Isn't there anymore since the latest kernels, but according 
to various sources on the web i need to do

echo -n "x" > /sys/power/state

where x is anything that comes up after

cat /sys/power/state.

The latter command only returns 

standby mem

so no "disk". For now I'm fine with that, I'd be happy if

echo -n "standby" > /sys/power/state

would have any effect at all. Now since most things on acpi for linux are 
about 2.4 kernels and all pages that are talking about more recent kernels 
don't tell me how to find out what is going on when I give these commands, 
can someone tell me where I should look?

Another question: when I do a find "sleep" (using the / key) in make 
menuconfig, it returns me an ACPI_SLEEP_PROC_SLEEP (deprecated), which is 
supposed to be in ACPI support. However, I can't find it, nor by grepping 
the .config. Does anyone know why it shows up in the search results or how I 
can compile it into the kernel?

Thanks for any help,
Diederick
