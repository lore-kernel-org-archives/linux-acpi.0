From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH] ACPI/APEI: Clear GHES block_status before panic()
Date: Fri, 21 Dec 2018 18:52:20 +0000
Message-ID: <0bb80989-4fe5-c320-8ffc-0f39502110c9@arm.com>
References: <1545238252-79630-1-git-send-email-darcari@redhat.com>
 <20181220192447.GG31403@zn.tnic> <1691682.ckC9UJvgEr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1691682.ckC9UJvgEr@aspire.rjw.lan>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, David Arcari <darcari@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 21/12/2018 11:17, Rafael J. Wysocki wrote:
> On Thursday, December 20, 2018 8:24:47 PM CET Borislav Petkov wrote:
>> + James.

Thanks,

>> On Wed, Dec 19, 2018 at 11:50:52AM -0500, David Arcari wrote:
>>> From: Lenny Szubowicz <lszubowi@redhat.com>
>>>
>>> In __ghes_panic() clear the block status in the APEI generic
>>> error status block for that generic hardware error source before
>>> calling panic() to prevent a second panic() in the crash kernel
>>> for exactly the same fatal error.
>>>
>>> Otherwise ghes_probe(), running in the crash kernel, would see
>>> an unhandled error in the APEI generic error status block and
>>> panic again, thereby precluding any crash dump.

I bet that was fun to watch!


>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 02c6fd9..f008ba7 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -691,6 +691,8 @@ static void __ghes_panic(struct ghes *ghes)
>>>  {
>>>  	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
>>>  
>>> +	ghes_clear_estatus(ghes);
>>> +
>>>  	/* reboot to log the error! */
>>>  	if (!panic_timeout)
>>>  		panic_timeout = ghes_panic_timeout;
>>
>> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Patch applied, thanks!

Great!

Do we need to ghes_ack_error() too?

With the location cleared the new kernel will never find the records, and
firmware can never re-use that location because it wasn't ack'd. The upshot is
RAS records can't be generated for the kdump kernel. The acpi spec talks about
use of the memory, so I don't think its fair for it to use this to disarm a
watchdog.

I think we can live with this as the kdump kernel isn't going to handle RAS
errors for the bulk of memory anyway.


Thanks,

James
