From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Output ACPI info via sysfs
Date: Thu, 11 May 2006 13:48:25 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB66D4F4E@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:798 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030400AbWEKRxG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2006 13:53:06 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org


>Currently, after booting a system there is no way to tell what 
>hardware 
>is currently in the system.  The current output from sysfs only 
>indicates what knowledge the kernel has of the system (ie, is 
>limited by 
>NR_CPUS, etc.).  However, during ACPI initialization a lot of data is 
>output to the console about the precise number of CPUs, lapics, etc.

Can you give an example of a person or program that can not
access a specific piece of information that they need?
