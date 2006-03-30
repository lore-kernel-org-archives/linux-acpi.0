From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: FIXED: no /proc/acpi, trying to dump dsdt to a file
Date: Thu, 30 Mar 2006 15:15:09 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD10F0D2A@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20356 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751198AbWC3HPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Mar 2006 02:15:37 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, glen martin <lists@locutory.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>


Then, Linux could need to forgive it too. :-)
--Luming


>Yes, no problems detected under WinXP Pro. Somehow Windows is 
>forgiving 
>of these issues.
>
>glen
>
>
>Yu, Luming wrote:
>
>>>Or at least, I'm past my pain, thanks to a lot of help from 
>>>Robert and Len.
>>>
>>>To recap:
>>>
>>>The DSDT in my BIOS was very broken, such that ACPI didn't load up 
>>>properly.  This meant I was having trouble reading the data 
>>>    
>>>
>>>from my BIOS 
>>  
>>
>>>using /proc/acpi/dsdt.
>>>    
>>>
>>
>>Does windows works with such broken BIOS ?
>>
>>  
>>
>
