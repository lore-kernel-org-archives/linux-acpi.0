From: Sinan Kaya <okaya@kernel.org>
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
Date: Sat, 22 Dec 2018 01:05:22 +0100
Message-ID: <783f254d-1301-fe68-bad5-a80a1b9f961b@kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
 <46e896b7-426a-2df9-6eae-c851332b4e43@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <46e896b7-426a-2df9-6eae-c851332b4e43@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 12/21/2018 6:43 PM, Randy Dunlap wrote:
>> Any other issues?
> There are a few Kconfig dependency issues.  Here are 2 of them:
> 
> 
> WARNING: unmet direct dependencies detected for VGA_ARB
>    Depends on [n]: HAS_IOMEM [=y] && PCI [=n] && !S390
>    Selected by [y]:
>    - VGA_SWITCHEROO [=y] && HAS_IOMEM [=y] && X86 [=y] && ACPI [=y]
> 
> WARNING: unmet direct dependencies detected for IOSF_MBI
>    Depends on [n]: PCI [=n]
>    Selected by [y]:
>    - X86_INTEL_LPSS [=y] && X86 [=y] && ACPI [=y]
>    Selected by [m]:
>    - MMC_SDHCI_ACPI [=m] && MMC [=m] && MMC_SDHCI [=m] && ACPI [=y] && X86 [=y]
> 
> 
> The randconfig file for these is attached.
> 
> (on x86_64; both issues are from the same .config file)

Thanks, I reproduced this. I'm getting ready to post a patch.
