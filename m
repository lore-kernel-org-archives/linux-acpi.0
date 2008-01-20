From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 5/5] ACPI: add DMI to enable OSI(Linux) on ThinkPad T61
Date: Sun, 20 Jan 2008 20:21:02 +0100
Message-ID: <47939F1E.2090407@dbservice.com>
References: <a4d865fcfc9913f3d2428bc2b7ab1683227a6096.1200565331.git.len.brown@intel.com> <200801192313.10296.lenb@kernel.org> <47933886.7050401@dbservice.com> <200801201331.59478.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dbservice.com ([213.239.204.14]:41324 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755065AbYATTVU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Jan 2008 14:21:20 -0500
In-Reply-To: <200801201331.59478.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Matthew Garrett <mjg59@srcf.ucam.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org

Len Brown wrote:
> On Sunday 20 January 2008 07:03, Tomas Carnecky wrote:
>> Len Brown wrote:
>>>    I am okay with defining OSI strings for the benefit of BIOS vendors that
>>>    need to know about Linux capabilities.  But the string must
>>>    identify that specific capability (or lack of a capability).
>> Is there a chance this will be added to future ACPI specs, or have it 
>> standardized in one way or another? I think that would be not only good 
>> for Linux, but all other UNIX-like operating systems as well (and maybe 
>> Windows as well).
>>
>> Not that I care, really, but for me as an outsider to the whole ACPI 
>> domain, it seems _OSI() isn't a well thought out interface. Checking for 
>> an OS name rather than individual capabilities may not matter as much 
>> under Windows, but for Linux, with its rather short release cycle, it 
>> certainly does.
> 
> Originally, there was _OS="<insert your OS name>" to identify the OS to the BIOS.
> We proudly answered _OS="Linux" and broke every BIOS on Earth
> that assumed that the only two choices for _OS
> which corresponded to Win98 and WinNT.
> That is why _OS="Microsoft Windows NT" is hardwired
> into Linux and any other OS that is concerned about
> following what has proven to be the only tested
> path through the BIOS.
> 
> So naming the OS turned out to be a failure (for everybody,
> not just for Linux -- consider that XP and Vista claim they are NT
> according to _OS or they hit the same BIOS bugs we do...)
> 
> _OSI is supposed to tell the BIOS what interfaces the OS supports,
> for example "Extended Address Space Descriptor".
> 
> However, it is being mis-used to identify the
> version of the OS, which is why you see this:
> 
> static char *acpi_interfaces_supported[] = {
>         /* Operating System Vendor Strings */
> 
>         "Windows 2000",         /* Windows 2000 */
>         "Windows 2001",         /* Windows XP */
>         "Windows 2001 SP1",     /* Windows XP SP1 */
>         "Windows 2001 SP2",     /* Windows XP SP2 */
>         "Windows 2001.1",       /* Windows Server 2003 */
>         "Windows 2001.1 SP1",   /* Windows Server 2003 SP1 - Added 03/2006 */
>         "Windows 2006",         /* Windows Vista - Added 03/2006 */
> 
> ie. basically the OS name is a proxy for all the interfaces
> that OS supports.  Taken another way, OS-version-specific quirks
> and workarounds are included in the definition of that interface...

So _OSI _is_ a good interface, it's just being misused. Thanks for the 
explanation.

> We could do the same with Linux, except that
> 1. the string "Linux" is even more poorly defined than those above,
>    as it has no version information.

Who came up with the idea to use "Linux"? After what you described 
above, this seems even worse choice then what Windows does - they at 
least have some information about the version in it.

> 2. the presence of the string "Linux" tends to break as many BIOS'
>    implementations as it fixes -- because it isn't universally tested.
> 
> So if new strings come up in the ACPI spec, we can use standard strings.
> But I don't think the ACPI spec is necessary to address Linux'
> problem-at-hand.

After what you explained above, I don't think either, the ACPI spec is ok.

> We as the Linux community can define "Needs BIOS S3 video restore" as a string
> and ship it in our kernel, telling BIOS writers about it.
> However, we'd reserve the right to _stop_ answering YES to a query on that string
> when we no longer need it.

Still, it would be nice to have these strings somehow standardized. 
Maybe Intel and other vendors or BIOS developers come up with something 
and document it properly, include some of the most important strings in 
the ACPI spec? Because if Linux starts using some strings and Windows or 
BSD different strings, there will surely be a mess - again.

tom
