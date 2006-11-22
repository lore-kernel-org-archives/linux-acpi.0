From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: new pmtools available for testing
Date: Wed, 22 Nov 2006 17:36:43 +0300
Message-ID: <4564607B.2050604@linux.intel.com>
References: <45634459.8040404@linux.intel.com> <1164203742.3721.346.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9380 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1752367AbWKVOgs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 09:36:48 -0500
In-Reply-To: <1164203742.3721.346.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> On Tue, 2006-11-21 at 21:24 +0300, Alexey Starikovskiy wrote:
>   
>> Hi,
>>
>> acpixtract perl-script is being replaced by C xtract utility. Please test.
>> Advances are:
>>     - Perl not required :)
>>     - no 64k output limit of perl-script
>>     - --list option shows all tables in the file
>>     - unified interface with acpidump
>>     - faster(?)
>>
>> Thanks in advance,
>>     
> Is this acpixtract that already existed in ACPICA since some time and
> now moved to pmtools?
>
>   
Nope, it's duplicated effort.
> If yes, I can say that it's working stable (at least older ACPICA vers)
> and makes live easier.
>
> Thanks,
>
>    Thomas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
