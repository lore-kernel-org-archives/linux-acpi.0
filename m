From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 0/9] ACPI, APEI patches for 2.6.40
Date: Mon, 30 May 2011 14:48:59 +0800
Message-ID: <4DE33DDB.2050304@linux.intel.com>
References: <1305619719-7480-1-git-send-email-ying.huang@intel.com> <alpine.LFD.2.02.1105290252150.7577@arrandale.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1105290252150.7577@arrandale.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=E4=BA=8E 5/29/2011 2:55 PM, Len Brown =E5=86=99=E9=81=93:
>> [PATCH 1/9] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
>> [PATCH 2/9] lib, Add lock-less NULL terminated single list
>> [PATCH 3/9] lib, Make gen_pool memory allocator lockless
>> [PATCH 4/9] ACPI, APEI, GHES, printk support for recoverable error v=
ia NMI
>
> I think the 4 above should go upstream to enable the
> printk for recoverable errors.  If queuing messages
> from NMI context gets re-implemented in the future,
> then so be it.
>
> I'll skip the rest, however, except #9:-)
>
> thanks,
> -Len
>
>> [PATCH 5/9] HWPoison: add memory_failure_queue()
>> [PATCH 6/9] ACPI, APEI, GHES: Add hardware memory error recovery sup=
port
>> [PATCH 7/9] PCIe, AER, add aer_recover_queue
>> [PATCH 8/9] ACPI, APEI, GHES: Add PCIe AER recovery support
>> [PATCH 9/9] ACPI, APEI, ERST, Prevent erst_dbg from loading if ERST =
is disabled
>>
> --

Hi, Len

Would you please help to review and merge my patch to fix an issue for=20
ERST debug module ? Here is the link:
https://patchwork.kernel.org/patch/802662/
