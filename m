From: Dave Hansen <dave@sr71.net>
Subject: Re: possible_cpus broken in linux-next
Date: Wed, 29 May 2013 15:14:12 -0700
Message-ID: <51A67DB4.9090404@sr71.net>
References: <51A6367E.1060400@intel.com>  <1369852557.16819.54.camel@misato.fc.hp.com> <1369853414.16819.56.camel@misato.fc.hp.com> <51A650BC.7030604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A650BC.7030604@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Toshi Kani <toshi.kani@hp.com>, Dave Hansen <dave.hansen@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 05/29/2013 12:02 PM, Rafael J. Wysocki wrote:
>>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>>> index 130ba0b..b9f0eec 100644
>>> --- a/drivers/base/cpu.c
>>> +++ b/drivers/base/cpu.c
>>> @@ -281,6 +281,7 @@ int __cpuinit register_cpu(struct cpu *cpu, int num)
>>>       cpu->dev.bus = &cpu_subsys;
>>>       cpu->dev.release = cpu_device_release;
>>>       cpu->dev.offline_disabled = !cpu->hotpluggable;
>>> +    cpu->dev.offline = !cpu_online(num);
>>>   #ifdef CONFIG_ARCH_HAS_CPU_AUTOPROBE
>>>       cpu->dev.bus->uevent = arch_cpu_uevent;
>>>   #endif

This gets things working for me again.  Thanks for the quick response!

Tested-by: Dave Hansen <dave.hansen@intel.com>
