From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: new pmtools available for testing
Date: Wed, 22 Nov 2006 19:40:36 +0300
Message-ID: <45647D84.9020101@linux.intel.com>
References: <45634459.8040404@linux.intel.com>	 <1164203742.3721.346.camel@queen.suse.de>	 <4564607B.2050604@linux.intel.com> <1164209126.3721.363.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:4893 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1755432AbWKVQkl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Nov 2006 11:40:41 -0500
In-Reply-To: <1164209126.3721.363.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

Thomas Renninger wrote:
> On Wed, 2006-11-22 at 17:36 +0300, Alexey Starikovskiy wrote:
>   
>> Thomas Renninger wrote:
>>     
>>> On Tue, 2006-11-21 at 21:24 +0300, Alexey Starikovskiy wrote:
>>>   
>>>       
>>>> Hi,
>>>>
>>>> acpixtract perl-script is being replaced by C xtract utility. Please test.
>>>> Advances are:
>>>>     - Perl not required :)
>>>>     - no 64k output limit of perl-script
>>>>     - --list option shows all tables in the file
>>>>     - unified interface with acpidump
>>>>     - faster(?)
>>>>
>>>> Thanks in advance,
>>>>     
>>>>         
>>> Is this acpixtract that already existed in ACPICA since some time and
>>> now moved to pmtools?
>>>   
>>>       
>> Nope, it's duplicated effort.
>>     
>
> Hmm, you should talk to (I think acpixtract C prog came from) Bob?
> Someone should decide which should be the final one everybody should
> use...
> If one distri or application starts to package and use the one, others
> start to use the other, we might have compatibility problems in some
> scripts in future.
>
>   
New utility is names 'xtract' so it does not clash with 'acpixtract' 
either perl-script or ACPICA utility.
If are used to acpixtract, no need to change your habits. If you somehow 
tired of crippled interface, you could try new utility.
> The linuxfirmwarekit makes use of ACPICA's acpixtract AFAIK (hardcoded
> by something like system("acpixtract acpidump");).
> I also packaged this one into SUSE pmtools package (since SUSE 10.1?).
> -> I'd prefer to stick to the ACPICA's acpixtract..
>   
no problem at all.

Regards,
    Alex
