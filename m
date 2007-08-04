From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Sat, 04 Aug 2007 17:03:09 +0900
Message-ID: <46B432BD.5040109@gmail.com>
References: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>	 <20070802123145.GA30304@srcf.ucam.org> <1186101896.25162.0.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:22236 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbXHDIEM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Aug 2007 04:04:12 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1098120wah
        for <linux-acpi@vger.kernel.org>; Sat, 04 Aug 2007 01:04:11 -0700 (PDT)
In-Reply-To: <1186101896.25162.0.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>

Shaohua Li wrote:
> On Thu, 2007-08-02 at 13:31 +0100, Matthew Garrett wrote:
>> On Thu, Aug 02, 2007 at 02:14:08PM +0800, Shaohua Li wrote:
>>> ACPI spec defines the sequence of IDE power on/off:
>> Most distributions seem to be using the libata PATA code now - any plans 
>> to implement it there as well?
> Ok, I'll look at it too.

libata already has acpi support.  Please take a look at
drivers/ata/libata-acpi.c

-- 
tejun
