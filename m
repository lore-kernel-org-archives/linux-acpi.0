From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic allocation
Date: Mon, 28 Aug 2006 19:01:07 -0700
Message-ID: <EB12A50964762B4D8111D55B764A845480122D@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33831 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751003AbWH2CBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Aug 2006 22:01:09 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Jiri Kosina [mailto:jikos@jikos.cz] 
>Sent: Saturday, August 26, 2006 8:39 AM
>To: Pallipadi, Venkatesh
>Cc: Len Brown; linux-acpi@vger.kernel.org
>Subject: RE: [patch 11/14] ACPI: change GFP_ATOMIC to 
>GFP_KERNEL for non-atomic allocation
>
>On Fri, 25 Aug 2006, Pallipadi, Venkatesh wrote:
>
>> I don't seem to be able to reproduce this on my T40 laptop. Can you
>> please send me the following: 1) Output of acpidump (from 
>latest pmtools
>> here: 
>http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/ )
>> 2) dmesg and cat /proc/acpi/processor/*/* output without this patch.
>
>http://www.jikos.cz/jikos/junk/ACPIDUMP
>http://www.jikos.cz/jikos/junk/DMESG
>http://www.jikos.cz/jikos/junk/PROC_ACPI
>
>These are from stock 2.6.18-rc4 kernel. 
>

Thanks Jiri for identifying the problem with this patch and reporting
it. I was able to reproduce it on a system locally and I have tracked
down the problem. I will send out the updated patch soon and cc it to
you. 

Thanks,
Venki
