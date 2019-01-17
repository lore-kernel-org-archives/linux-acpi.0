From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Thu, 17 Jan 2019 18:02:42 -0500
Message-ID: <b92f439e-b95c-56e3-6960-52ae1e1afe71@kernel.org>
References: <20190117161722.3945-1-okaya@kernel.org>
 <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org>
 <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
 <20190117220959.GG5023@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117220959.GG5023@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 1/17/2019 5:09 PM, Borislav Petkov wrote:
> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
>> I have patches for intel_ips and intel_pmc_ipc queued up (will be
>> pushed for -rc3), plus some others.
> 
> Yeah, I saw the patchset and applied some of them locally so that I be
> able to do randconfig builds. Do you have a branch somewhere which I can
> merge locally for testing?
>

You can use this tag (next-20190116) for local test.
