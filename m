From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 3/3] x86/xen: supply rsdp address in boot
 params for pvh guests
Date: Tue, 28 Nov 2017 11:47:09 +0100
Message-ID: <5a2f5ecb-e1a6-5823-aa59-2fafd2d6f756@suse.com>
References: <20171128094400.25955-1-jgross@suse.com>
 <20171128094400.25955-4-jgross@suse.com>
 <20171128101724.ol5sufd6x3qzomcc@MacBook-Pro-de-Roger.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933323AbdK1KrM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Nov 2017 05:47:12 -0500
In-Reply-To: <20171128101724.ol5sufd6x3qzomcc@MacBook-Pro-de-Roger.local>
Content-Language: de-DE
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, corbet@lwn.net, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, lenb@kernel.org

On 28/11/17 11:17, Roger Pau Monné wrote:
> On Tue, Nov 28, 2017 at 10:44:00AM +0100, Juergen Gross wrote:
>> When booted via the special PVH entry save the RSDP address set in the
>> boot information block in struct boot_params. This will enable Xen to
>> locate the RSDP at an arbitrary address.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/xen/enlighten_pvh.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
>> index 436c4f003e17..0175194f4236 100644
>> --- a/arch/x86/xen/enlighten_pvh.c
>> +++ b/arch/x86/xen/enlighten_pvh.c
>> @@ -71,6 +71,8 @@ static void __init init_pvh_bootparams(void)
>>  	 */
>>  	pvh_bootparams.hdr.version = 0x212;
> 
> Shouldn't this be 0x20e, like it's set in patch 1?

I think it was meant to be 0x20c. But setting it to 0x20e in this patch
seems to be a good idea.

In the end it doesn't really matter, as hdr.version is meant to be read
by the boot loader which is already history when this code is being
executed.


Juergen
