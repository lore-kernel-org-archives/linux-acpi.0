From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: /usr/include/*/acpi.h
Date: Thu, 04 Jan 2007 14:02:08 +0300
Message-ID: <459CDEB0.5040302@linux.intel.com>
References: <200701031552.37919.lenb@kernel.org> <1167900335.14297.23.camel@prodigy.suse.de> <20070104104945.GA31430@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19564 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932343AbXADLCI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jan 2007 06:02:08 -0500
In-Reply-To: <20070104104945.GA31430@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thorsten Kukuk <kukuk@suse.de>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, pbaudis@suse.cz

Thorsten Kukuk wrote:
> On Thu, Jan 04, Thomas Renninger wrote:
>
>   
>> On Wed, 2007-01-03 at 15:52 -0500, Len Brown wrote:
>>     
>>> Thomas,
>>> Why do the following files appear in OpenSuse 10.2?
>>>
>>> $ find /usr/include -name '*acpi*'
>>> /usr/include/asm/acpi.h
>>> /usr/include/asm-x86_64/acpi.h
>>> /usr/include/asm-i386/acpi.h
>>> /usr/include/linux/acpi.h
>>> /usr/include/linux/pci-acpi.h
>>>
>>> They are not present on a Fedora Core 6 system.
>>>       
>> No idea. I never used them and I don't know any user space tool using
>> them.
>>     
>
> This header files are part of the linux kernel, and thus of course
> available in /usr/include/{asm,linux}.
>
>   Thorsten
>
>   
Not all kernel headers have a meaning to user space, and not all of them 
should be available there.
More, none of the ACPI linux kernel headers have meaning to user space 
applications, thus they "of course"
should not be available.

Regards,
    Alex.
