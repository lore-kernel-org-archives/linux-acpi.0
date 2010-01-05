From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Mon, 04 Jan 2010 20:15:40 -0600
Message-ID: <4B42A0CC.2090907@gmail.com>
References: <20100104162114.GA30113@percival.namespace.at> <alpine.LFD.2.00.1001041209300.4012@localhost.localdomain> <4B4225B3.8070705@zytor.com> <alpine.LFD.2.00.1001041632330.4012@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754544Ab0AECPv@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1001041632330.4012@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Andrey Borzenkov <arvidjaar@mail.ru>
List-Id: linux-acpi@vger.kernel.org

On 01/04/2010 04:03 PM, Len Brown wrote:
>>> I believe that Venki is sending a patch to make all recent
>>> motherboards use acpi reset by default; and I'd rather
>>> see that kind of patch than this one.
>>>
>>> I've had the patch below patch in acpi-test, and thus linus-next,
>>> and -mm since Nov 2008 to change the default for
>>> all systems w/ no issues.
>>>
>>
>> Maybe I'm misremembering, but didn't we have to pull this patch after it
>> hit mainstream the last time?
>
>
> c7ffa6c26277b403920e2255d10df849bd613380
> "x86: default to reboot via ACPI"
>
> set ACPI as the default in 2.6.28-rc1
>
> 8d00450d296dedec9ada38d43b83e79cca6fd5a3
> Revert "x86: default to reboot via ACPI"
>
> pulled it in v2.6.28-rc4
>
> The original patch was justified by VMX support,
> and the revert was in response to Andrey Borzenkov's
> DMI patch to usee BIOS reset on his Toshiba Porgege 4000:
>
> http://lkml.org/lkml/2008/10/31/242
>
> The Toshiba Portege 4000 shipped in early 2002.
>
> The patch to restore ACPI reset to default has been in Linux-next
> (with occasional drops) since the day it was dropped from 2.6.28-rc4.
>
> As we have an existence proof, I have no doubt that using
> ACPI reset by default will un-earth some regressions.  However,
> my guess is that the DMI list of old machines that will fail
> with ACPI reset will be smaller than by the DMI list of
> brand-new machines that will fail without ACPI reset.
>
> We couuld use a DMI year cut-off as we do with
> ACPI itself CONFIG_ACPI_BLACKLIST_YEAR, though that
> doesn't work on systems that don't have DMI...
> If I were to propose a year, I'd say 2006 and newer,
> since XP was "Windows 2006".

Think you mean 2001, Vista was 2006..

I'm assuming that Windows is using ACPI reset these days, so presumably 
that's what we should be doing by default, and blacklisting machines 
where that doesn't work, rather than the reverse..
