From: "Brown, Len" <len.brown@intel.com>
Subject: ACPI_DBG_TRACK_ALLOCATIONS
Date: Thu, 9 Mar 2006 00:13:40 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006523B4E@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:54245 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751486AbWCIFNo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Mar 2006 00:13:44 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k295DhQj008436
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 05:13:43 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k295Dbr7008179
	for <linux-acpi@vger.kernel.org>; Thu, 9 Mar 2006 05:13:43 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030821134305438
 for <linux-acpi@vger.kernel.org>; Wed, 08 Mar 2006 21:13:43 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
Is ACPI_DBG_TRACK_ALLOCATIONS of any use in kernel builds?
I notice that it is getting enabled with ACPI_DEBUG_OUTPUT
which is getting enabled with CONFIG_ACPI_DEBUG=y

thanks,
-Len
