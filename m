From: Jan Dittmer <jdi@l4x.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Sat, 28 Jul 2007 09:58:01 +0200
Message-ID: <46AAF709.9060407@l4x.org>
References: <200707251238.50218.lenb@kernel.org> <46A98FF9.8060801@l4x.org> <je8x91flu9.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937812AbXG1IAU@vger.kernel.org>
In-Reply-To: <je8x91flu9.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

Andreas Schwab wrote:
> Jan Dittmer <jdi@l4x.org> writes:
> 
>> Len Brown wrote:
>>> Hi Linus,
>>>
>>> please pull from: 
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
>> This seems to break ia64 defconfig:
>>
>>   Building modules, stage 2.
>>   MODPOST 157 modules
>> FATAL: drivers/acpi/button: sizeof(struct acpi_device_id)=20 is not a modulo of the size of section __mod_acpi_device_table=144.
> 
> Are you cross-compiling?  The definition of kernel_ulong_t won't work on
> x86.

Yes, sorry, should have mentioned that. Build system is x86. Still,
it didn't happen before the recent acpi merge.

Jan
