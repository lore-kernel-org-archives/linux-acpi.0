From: Sinan Kaya <okaya@kernel.org>
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
Date: Sat, 22 Dec 2018 01:04:50 +0100
Message-ID: <8c6c251b-2ec6-93d3-00c3-97387923c5c2@kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
 <00a8511e-0b8e-13d3-220a-ed979dc3e020@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00a8511e-0b8e-13d3-220a-ed979dc3e020@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/21/2018 7:28 PM, Randy Dunlap wrote:
>> Any other issues?
> 
> and on i386, there is this additional kconfig warning:
> 
> WARNING: unmet direct dependencies detected for INTEL_SOC_DTS_IOSF_CORE
>    Depends on [n]: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && PCI [=n]
>    Selected by [m]:
>    - INT340X_THERMAL [=m] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && ACPI [=y]
> 
> 
> The randconfig file for this is attached.

Thanks, I reproduced this. I'm getting ready to post a patch.
