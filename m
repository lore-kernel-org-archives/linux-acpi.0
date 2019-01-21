From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Mon, 21 Jan 2019 18:18:12 -0500
Message-ID: <637e85ca-844b-0bab-1691-ecf14b55e80e@kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org>
 <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
 <20190117220959.GG5023@zn.tnic>
 <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 1/18/2019 6:45 AM, Rafael J. Wysocki wrote:
> On Thu, Jan 17, 2019 at 11:10 PM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
>>> I have patches for intel_ips and intel_pmc_ipc queued up (will be
>>> pushed for -rc3), plus some others.
>>
>> Yeah, I saw the patchset and applied some of them locally so that I be
>> able to do randconfig builds. Do you have a branch somewhere which I can
>> merge locally for testing?
> 
> You can pull the tag I've just pushed to Linus:
> https://lore.kernel.org/lkml/CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com/T/#u
> 

Here is a result of my randconfig analysis using next-20190116.

There are two issues that are related to my change:
1. x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled
2. mfd: Fix unmet dependency warning for MFD_TPS68470

I'll post v2 for this patch to pick up the above commit #2.

and three unrelated changes as follows:
1. platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
2. platform/x86: Fix unmet dependency warning for ACPI_CMPC
3. iwlwifi: Fix unmet dependency warning for MAC80211_LEDS

I'm posting these unrelated changes independently.
