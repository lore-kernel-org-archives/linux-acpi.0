From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
Date: Fri, 18 Jan 2019 12:45:12 +0100
Message-ID: <CAJZ5v0iR=0ZoS_=KpTRefZ+fdZOKAAH1PSxfS0cfyS+zx39Hgw@mail.gmail.com>
References: <20190117161722.3945-1-okaya@kernel.org> <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org> <20190117215631.GF5023@zn.tnic>
 <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com> <20190117220959.GG5023@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117220959.GG5023@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2019 at 11:10 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 17, 2019 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
> > I have patches for intel_ips and intel_pmc_ipc queued up (will be
> > pushed for -rc3), plus some others.
>
> Yeah, I saw the patchset and applied some of them locally so that I be
> able to do randconfig builds. Do you have a branch somewhere which I can
> merge locally for testing?

You can pull the tag I've just pushed to Linus:
https://lore.kernel.org/lkml/CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com/T/#u
