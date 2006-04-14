From: Daniel Drake <dsd@gentoo.org>
Subject: "Unable to start the ACPI Interpreter" in 2.6.16
Date: Fri, 14 Apr 2006 14:29:57 +0100
Message-ID: <443FA3D5.4070103@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:3567 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751251AbWDNNRA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Apr 2006 09:17:00 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060414131659.ORKL27969.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-acpi@vger.kernel.org>; Fri, 14 Apr 2006 14:16:59 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060414131659.VFOZ19763.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>
          for <linux-acpi@vger.kernel.org>; Fri, 14 Apr 2006 14:16:59 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

A Gentoo user reported a 2.6.16 regression at http://bugs.gentoo.org/129011

In a nutshell, ACPI worked in 2.6.15, and breaks in 2.6.16 and the 
/proc/acpi interface is not present. Here are the relevant looking 
messages from dmesg:

ACPI: SCI (IRQ0) allocation failed
ACPI Exception (evevent-0167): AE_NOT_ACQUIRED, Unable to install System 
Control Interrupt handler [20060127]
ACPI: Unable to start the ACPI Interpreter
evxfevnt-0134 [06] disable               : ACPI mode disabled
ACPI (utalloc-0862): No outstanding allocations [20060127]
ACPI Exception (utmutex-0257): AE_BAD_PARAMETER, Thread 1 could not 
acquire Mutex [6] [20060127]
ACPI Exception (utmutex-0257): AE_BAD_PARAMETER, Thread 1 could not 
acquire Mutex [6] [20060127]

Full dmesg can be found at 
http://bugs.gentoo.org/attachment.cgi?id=84551&action=view

This bug is already fixed in 2.6.17-rc1. Does anyone know offhand which 
patch fixes this? I'd like to backport the fix and also submit it for 
the -stable branch.

Thanks,
Daniel
