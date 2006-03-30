From: glen martin <lists@locutory.org>
Subject: Re: FIXED: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 23:11:20 -0800
Message-ID: <442B8498.6060106@locutory.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10F0BE5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:48376 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1751197AbWC3HLZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Mar 2006 02:11:25 -0500
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD10F0BE5@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org

Yes, no problems detected under WinXP Pro. Somehow Windows is forgiving 
of these issues.

glen


Yu, Luming wrote:

>>Or at least, I'm past my pain, thanks to a lot of help from 
>>Robert and Len.
>>
>>To recap:
>>
>>The DSDT in my BIOS was very broken, such that ACPI didn't load up 
>>properly.  This meant I was having trouble reading the data 
>>    
>>
>>from my BIOS 
>  
>
>>using /proc/acpi/dsdt.
>>    
>>
>
>Does windows works with such broken BIOS ?
>
>  
>

