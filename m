From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 3/3] x86/xen: supply rsdp address in boot params for
 pvh guests
Date: Fri, 8 Dec 2017 09:40:57 +0100
Message-ID: <a96445ce-ff79-c7b0-3236-af6fc546b9f4@suse.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-4-jgross@suse.com>
 <20171208072216.nkexmwnbzin4iwmf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208072216.nkexmwnbzin4iwmf@gmail.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 08/12/17 08:22, Ingo Molnar wrote:
> 
> * Juergen Gross <jgross@suse.com> wrote:
> 
>> When booted via the special PVH entry save the RSDP address set in the
>> boot information block in struct boot_params. This will enable Xen to
>> locate the RSDP at an arbitrary address.
>>
>> Set the boot loader version to 2.14 (0x020e) replacing the wrong 0x0212
>> which should have been 0x020c.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V2: set bootloader version to 2.14 (Roger Pau Monné)
>> ---
>>  arch/x86/xen/enlighten_pvh.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
>> index 436c4f003e17..036e3a5f284a 100644
>> --- a/arch/x86/xen/enlighten_pvh.c
>> +++ b/arch/x86/xen/enlighten_pvh.c
>> @@ -68,9 +68,12 @@ static void __init init_pvh_bootparams(void)
>>  	 *
>>  	 * Version 2.12 supports Xen entry point but we will use default x86/PC
>>  	 * environment (i.e. hardware_subarch 0).
>> +	 * The RSDP address is available from version 2.14 on.
>>  	 */
>> -	pvh_bootparams.hdr.version = 0x212;
>> +	pvh_bootparams.hdr.version = 0x20e;
> 
> While 0x212 was "obvious" to read but totally wrong, it would be less fragile and 
> more readable if the version was generated as something like:
> 
> 	pvh_bootparams.hdr.version = (2 << 8) | 14;

Sure, I can make that change.

> 
> similar to how it's written in other cases:
> 
>>  	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
> 
> Also, shouldn't the 0x212 fix be a separate patch, Cc: stable? The bug appears to 
> have been introduced at around v4.12.

While not really being very important, this seems to be cleaner, yes.
After all this value is visible in sysfs, so it should be correct.


Juergen
