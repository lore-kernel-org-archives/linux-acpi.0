From: "Jim Adam" <jimadam@cinci.rr.com>
Subject: ACPI: Windows equivalent of /proc/acpi?
Date: Thu, 24 Aug 2006 09:09:19 -0400
Message-ID: <LPBBKAHCOJNFNMBCIKPAOELMDCAA.jimadam@cinci.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ms-smtp-01.ohiordc.rr.com ([65.24.5.135]:15784 "EHLO
	ms-smtp-01.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S1751338AbWHXNJP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 09:09:15 -0400
Received: from dorgonville (cpe-24-33-125-96.cinci.res.rr.com [24.33.125.96])
	by ms-smtp-01.ohiordc.rr.com (8.13.6/8.13.6) with SMTP id k7OD9D2O029243
	for <linux-acpi@vger.kernel.org>; Thu, 24 Aug 2006 09:09:14 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Am porting ACPI-dependent functionality from UNIX to Windows.  Am unable to
determine what the Windows equivalent is of /proc/acpi device files, etc.
Our small app only does a few things:

(a) Determine # of CPUs on the machine.
(b) Determine what speeds are supported for a CPU.
(c) Change the current CPU speed.
(d) Get the number of instructions executed by the CPU.

This is a fully funded project, so someone able to provide working
implementations of these methods using ACPI on Windows could negotiate fee
for service.

Thanks,
Jim
jimadam@cinci.rr.com

