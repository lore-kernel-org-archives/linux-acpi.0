From: David John <davidjon@xenontk.org>
Subject: Re: 2.6.30-rc3 : Regression: i915 , video
Date: Fri, 24 Apr 2009 13:08:29 +0530
Message-ID: <49F16C75.9040702@xenontk.org>
References: <72010.86725.qm@web112215.mail.gq1.yahoo.com> <alpine.LFD.2.00.0904231537590.15830@localhost.localdomain>
Reply-To: davidjon@xenontk.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755218AbZDXHj0@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0904231537590.15830@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: We La <w.landgraf@yahoo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 04/24/2009 01:18 AM, Len Brown wrote:
>> Problems on MSI U100 laptop:
>>
>> root@werner:~# modprobe i915
>> WARNING: Error inserting video (/lib/modules/2.6.30-rc3/kernel/drivers/acpi/video.ko): No such device
>> FATAL: Error inserting i915 (/lib/modules/2.6.30-rc3/kernel/drivers/gpu/drm/i915/i915.ko): Unknown symbol in module, or unknown parameter (see dmesg)
>> root@werner:~#
>>
>> Apr 23 16:16:57 localhost kernel: i915: Unknown symbol acpi_video_register
>>
>>
>> On older kernels this drivers worked
>>
>> Werner Landgraf
>> Linux  SYS
> 
> you've got modular i915 and no acpi video driver?
> Does this patch help?
> 
> http://patchwork.kernel.org/patch/18420/
> 
> thanks,
> -Len Brown, Intel Open Source Technology Center
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Hi,

Can you forward this patch to Linus? This regression breaks quite a few
configs where ACPI Video is compiled as a module and i915 is built in.
This should have been in stable, but I guess it's too late now.

Regards,
David
