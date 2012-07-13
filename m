From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of firmware_map_add_early/hotplug
Date: Fri, 13 Jul 2012 13:34:04 +0900
Message-ID: <4FFFA53C.8090707@jp.fujitsu.com>
References: <4FFAB0A2.8070304@jp.fujitsu.com> <4FFAB17F.2090209@jp.fujitsu.com> <4FFD9C08.2070502@linux.vnet.ibm.com> <4FFE5816.6070102@jp.fujitsu.com> <4FFED3CE.7030108@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <4FFED3CE.7030108@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com
List-Id: linux-acpi@vger.kernel.org

Hi Dave,

2012/07/12 22:40, Dave Hansen wrote:
> On 07/11/2012 09:52 PM, Yasuaki Ishimatsu wrote:
>> Does the following patch include your comment? If O.K., I will separate
>> the patch from the series and send it for bug fix.
> 
> Looks sane to me.  It does now mean that the calling conventions for
> some of the other firmware_map*() functions are different, but I think
> that's OK since they're only used internally to memmap.c.

Thank you for reviewing my patch.
I'll send the patch.

Thanks,
Yasuaki Ishimatsu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
