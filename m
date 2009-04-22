From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI Exception (AE_ERROR, ACPI thermal trip point state changed)
Date: Wed, 22 Apr 2009 13:19:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221313170.6187@localhost.localdomain>
References: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_WnGURnKyaNeic0CBjL5Irw)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:40367 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbZDVRUZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Apr 2009 13:20:25 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KII003PUIT82UBM@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 22 Apr 2009 12:20:01 -0500 (CDT)
In-reply-to: <fab5b76e0904220858x71bf226dn19071ddc5692e7ec@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcin Gozdalik <gozdal@gmail.com>
Cc: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_WnGURnKyaNeic0CBjL5Irw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT



On Wed, 22 Apr 2009, Marcin Gozdalik wrote:

> Hi
> 
> I am seeing the following in logs:
> 
> Apr 22 16:00:07 myth kernel: [   39.354031] ACPI Exception
> (thermal-0479): AE_ERROR, ACPI thermal trip point state changed
> Apr 22 16:00:07 myth kernel: [   39.354040] Please send acpidump to
> linux-acpi@vger.kernel.org
> Apr 22 16:00:07 myth kernel: [   39.354045]  [20080926]
> 
> I am using Ubuntu 9.04:
> 
> root@myth:/home/gozdal# uname -a
> Linux myth 2.6.28-11-generic #42-Ubuntu SMP Fri Apr 17 01:58:03 UTC
> 2009 x86_64 GNU/Linux
> 
> Motherboard is Abit AN-M2HD(MCP68) flashed with the latest BIOS.
> 
> The machine powers down sometimes because of an ACPI trip point:
> 
> Apr 22 17:27:19 myth kernel: [ 5272.004934] ACPI: Critical trip point
> Apr 22 17:27:19 myth kernel: [ 5272.004952] Critical temperature
> reached (121 C), shutting down.
> Apr 22 17:27:19 myth kernel: [ 5272.004973] ACPI: Unable to turn
> cooling device [ffff88006f841800] 'on'
> Apr 22 17:27:26 myth kernel: [ 5278.204238] Critical temperature
> reached (34 C), shutting down.
> 
> although I believe this is an error in measurement, as the temperature
> probably wouldn't cool in 7 seconds from 121 to 34 Celsius.

did this happen with earlier kernels, or did it start in 2.6.28?

please try 2.6.29.
please try it with CONFIG_HWMON=n

If it still fails, please file a bugzilla
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the acpidump there.

thanks,
Len Brown, Intel Open Source Technology Center

--Boundary_(ID_WnGURnKyaNeic0CBjL5Irw)--
