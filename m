From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: APEI: ERST table in ACPI NVS not supported
Date: Tue, 29 Jan 2013 10:08:11 -0800
Message-ID: <5108100B.9040907@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:47179 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480Ab3A2SI2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jan 2013 13:08:28 -0500
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Tue, 29 Jan 2013 11:08:23 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 43C85C40013
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jan 2013 11:08:19 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r0TI8JGe356088
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jan 2013 11:08:19 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r0TI8HPp029286
	for <linux-acpi@vger.kernel.org>; Tue, 29 Jan 2013 11:08:17 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gong.chen@linux.intel.com, ying.huang@intel.com
Cc: linux-acpi@vger.kernel.org, masbock@linux.vnet.ibm.com

Hi,

we have systems that declare the memory range for ERST in ACPI NVS.
Because ACPI NVS is marked 'busy' by e820_reserve_resources() the call 
to request_mem_region(erst_erange.base, erst_erange.size, "APEI ERST") 
made from erst_init() fails and we get:
ERST: Can not request iomem region <0x        7e91f000-0x        
7e920c00> for ERST.

I did notice that quite some effort was made to add code to avoid 
resource conflicts between APEI and ACPI NVS. But ERST still goes 
straight to request_mem_region() which is bound to fail. I am assuming 
this should go through apei_resources_request() instead or I am missing 
something?

thanks,
Max

