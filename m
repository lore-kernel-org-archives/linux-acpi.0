From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/6] sony-laptop: refactor model types
Date: Sun, 13 Jan 2008 02:17:40 -0500
Message-ID: <200801130217.40492.lenb@kernel.org>
References: <1200198212-10526-1-git-send-email-malattia@linux.it> <1200198212-10526-3-git-send-email-malattia@linux.it> <1200198212-10526-4-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37120 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbYAMHR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Jan 2008 02:17:58 -0500
In-Reply-To: <1200198212-10526-4-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

$ scripts/checkpatch.pl ~/Documents/sony3.patch
ERROR: "foo * bar" should be "foo *bar"
#66: FILE: drivers/misc/sony-laptop.c:1200:
+       struct sonypi_event *   events;

WARNING: line over 80 characters
#253: FILE: drivers/misc/sony-laptop.c:2380:
+               data_mask = inb_p(dev->cur_ioport->io1.minimum + dev->control->evport_offset);

WARNING: line over 80 characters
#257: FILE: drivers/misc/sony-laptop.c:2383:
+                       ev, data_mask, dev->cur_ioport->io1.minimum, dev->control->evport_offset);

WARNING: line over 80 characters
#284: FILE: drivers/misc/sony-laptop.c:2400:
+                                       dev->control->event_types[i].events[j].event;

ERROR: use tabs not spaces
#289: FILE: drivers/misc/sony-laptop.c:2405:
+  ^Idprintk("unknown event ([%.2x] [%.2x]) at port 0x%.4x(+0x%.2x)\n",$

WARNING: line over 80 characters
#290: FILE: drivers/misc/sony-laptop.c:2406:
+                       ev, data_mask, dev->cur_ioport->io1.minimum, dev->control->evport_offset);

ERROR: use tabs not spaces
#290: FILE: drivers/misc/sony-laptop.c:2406:
+ ^I^I^Iev, data_mask, dev->cur_ioport->io1.minimum, dev->control->evport_offset);$

ERROR: use tabs not spaces
#296: FILE: drivers/misc/sony-laptop.c:2411:
+ ^Iacpi_bus_generate_proc_event(dev->acpi_dev, 1, device_event);$

total: 4 errors, 4 warnings, 261 lines checked
