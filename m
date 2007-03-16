From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ACPI patches in test for Linux-2.6.22
Date: Fri, 16 Mar 2007 21:03:16 +0300
Message-ID: <45FADBE4.4070703@linux.intel.com>
References: <11734992592550-git-send-email-lenb@kernel.org> <1174067916.15637.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39841 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965795AbXCPSD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Mar 2007 14:03:28 -0400
In-Reply-To: <1174067916.15637.2.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Sergio Monteiro Basto wrote:
> On Fri, 2007-03-09 at 23:00 -0500, Len Brown wrote:
>   
>> These patches are in test for Linux-2.6.22.
>>
>>     
> Since we have big changes on ACPI for 2.6.21 , why we don't test all at
> once (why we don't also include this on 6.21) ? 
>
> Best regards, 
>   
Because testing is expected to be done in Andrew Morton' -mm and not in 
Linus' stable kernel.
