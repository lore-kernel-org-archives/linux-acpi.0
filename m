From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: Question about own battery driver
Date: Tue, 14 Mar 2006 14:58:42 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32A09F@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:22158 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751496AbWCNG7X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Mar 2006 01:59:23 -0500
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k2E6xKos020545
	for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2006 06:59:20 GMT
Received: from pdsmsxvs01.pd.intel.com (pdsmsxvs01.pd.intel.com [172.16.12.122])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k2E6xJOX004506
	for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2006 06:59:20 GMT
Received: from pdsmsx331.ccr.corp.intel.com ([172.16.12.58])
 by pdsmsxvs01.pd.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006031414591903751
 for <linux-acpi@vger.kernel.org>; Tue, 14 Mar 2006 14:59:19 +0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bart Jonkers <jonkersbart@gmail.com>
Cc: linux-acpi@vger.kernel.org

>On Tue, 2006-03-14 at 14:13 +0800, Yu, Luming wrote:
>> >Hey,
>> >
>> >I am busy with creating a battery driver for an embedded 
>> >system and want
>> >to let my driver interface with the acpi interface.
>> 
>> Do you think your embedded system can accommodate ACPI subsystem,
>> which is huge.
>> 
>Wat do you mean with huge? Is the kernel side or the user-space side
>big?
>My device uses an Intel PXA255 processor en has 64MB ram.
>
>I have just seen that ACPI is not supported for ARM. Am I right?

No, it's not, just because of the size of ACPI.

>What should be the right thing in this case? Write my own 
>driver and use
>an own interface to communicate with the driver, or is there some other
>system in the kernel where my driver belongs and that I need to use.
>

Maybe you need to ask linux-arm ML.
