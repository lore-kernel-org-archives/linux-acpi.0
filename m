From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Thu, 14 Jun 2012 14:49:06 -0700
Message-ID: <20120614214906.GA11309@us.ibm.com>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
 <20120613104651.52ce8840@endymion.delvare>
 <4FD86EFF.1080004@linux.intel.com>
 <20120614095330.7d797f1d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:60163 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab2FNVus (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 17:50:48 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <garyhade@us.ibm.com>;
	Thu, 14 Jun 2012 15:50:47 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 270681FF001C
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 21:50:08 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5ELnSM2219422
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 15:49:50 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5ELnC6O017343
	for <linux-acpi@vger.kernel.org>; Thu, 14 Jun 2012 15:49:13 -0600
Content-Disposition: inline
In-Reply-To: <20120614095330.7d797f1d@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Xiao, Hui" <hui.xiao@linux.intel.com>, garyhade@us.ibm.com, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On Thu, Jun 14, 2012 at 09:53:30AM +0200, Jean Delvare wrote:
> Hi Hui,
> 
> On Wed, 13 Jun 2012 18:44:15 +0800, Xiao, Hui wrote:

< snip >

> 
> > Besides if addressing a data structure, per ACPI spec bit_width and bit_offset
> > must be zero, the original condition will always end with error even valid 
> > access width is given.
> 
> I agree that the original test did not support the data structure case.
> OTOH after quickly reading the relevant page of the ACPI specification,
> I do not understand how the structure size is passed, so I have no idea
> how this case could be handled.

I wasn't able to find any references to the Generic Address
Structure (GAS) in the APEI portion of the ACPI spec implying
data structure access via an address contained in a GAS.  However,
I believe it is a good idea to cover the data structure case in the
event that the code is ever used beyond APEI where the data structure
case could become an issue.

Hui, Please check my assertion that the data structure case is
not a factor for APEI.

Thanks,
Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc

