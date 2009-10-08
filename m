From: wferi <wferi@niif.hu>
Subject: Suspend to RAM freeze with kernel modesetting
Date: Thu, 08 Oct 2009 03:40:34 +0200
Message-ID: <7ff4351d91a63843e586e595d0c5a5d5@niif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rs14.lvs.iif.hu ([193.225.14.164]:52831 "EHLO rs14.lvs.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbZJHBr4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Oct 2009 21:47:56 -0400
Received: from lipton.aai.niif.hu (HELO testmail.iif.hu) ([193.225.14.195])
          (envelope-sender <wferi@niif.hu>)
          by mail.iif.hu (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 8 Oct 2009 03:40:34 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi ACPI folks,

I'd like to solicit your opinion on the
https://bugs.freedesktop.org/show_bug.cgi?id=22126 issue.
In short, if I load the Intel graphics driver with kernel
modesetting enabled, my ThinkPad R50e won't suspend to RAM
anymore, it freezes instead (ie. does not enter S3).
Tracing seems to show that the freeze happens in a
particular line of drivers/acpi/acpica/hwsleep.c:

/* Run the _PTS method */
status = acpi_evaluate_object(NULL, METHOD_NAME__PTS, &arg_list, NULL);

in acpi_enter_sleep_state_prep, as described in the bug
report. Can anybody provide a clue why this happens?
Suspend to disk works invariably, just like suspend to RAM
until I enable the kernel modesetting by a module option.

Please Cc me or the bug report, I'm not subscribed to linux-acpi.

Thanks,
Feri.
