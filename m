From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Fri, 23 Mar 2012 17:15:37 -0700
Message-ID: <CAE9FiQW-dNhZGYdpGEwsUbSG9okPyM-JR50GaASSLvAR0nBt8A@mail.gmail.com>
References: <1332512984-79664-1-git-send-email-trenn@suse.de>
	<CAE9FiQVFd=Zef2bH_3MinLEV_V+cEShrmRTe7Sr8HT2R46yHHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53067 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382Ab2CXAPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Mar 2012 20:15:38 -0400
In-Reply-To: <CAE9FiQVFd=Zef2bH_3MinLEV_V+cEShrmRTe7Sr8HT2R46yHHw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, hpa@zytor.com

On Fri, Mar 23, 2012 at 1:54 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> --- a/arch/x86/mm/init.c
>> +++ b/arch/x86/mm/init.c
>> @@ -391,6 +391,12 @@ void free_initrd_mem(unsigned long start, unsig=
ned long end)
>> =A0 =A0 =A0 =A0 * =A0 - relocate_initrd()
>> =A0 =A0 =A0 =A0 * So here We can do PAGE_ALIGN() safely to get parti=
al page to be freed
>> =A0 =A0 =A0 =A0 */
>> +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
>> + =A0 =A0 =A0 if (acpi_initrd_offset)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_init_pages("initrd memory", start=
 - acpi_initrd_offset,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PAGE_A=
LIGN(end));
>> + =A0 =A0 =A0 else
>> +#endif
>
> table already get copied to allocated ram, So you don't need to keep
> the portion in initrd range.
>
>> =A0 =A0 =A0 =A0free_init_pages("initrd memory", start, PAGE_ALIGN(en=
d));
>> =A0}

oh, i missed it. that is offset

change following would be more clean?

 +#ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
 +       /* offset back to free acpi tables */
 +       if (acpi_initrd_offset)
 +               start -=3D acpi_initrd_offset,
 +#endif

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
