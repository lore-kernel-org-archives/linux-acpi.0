From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86/pci: host mmconfig detect clean up v2
Date: Thu, 5 Feb 2009 19:15:34 +0100
Message-ID: <20090205181534.GC5661@elte.hu>
References: <1233765552.16414.6.camel@localhost.localdomain> <86802c440902041212q51f2a444l84e1ac29ee6f702e@mail.gmail.com> <20090204212517.GM22608@elte.hu> <498A4DFB.7040608@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <498A4DFB.7040608@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ed Swierk <eswierk@aristanetworks.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> Impact: not assume one place for mmconfig in nb
> 
> prepare for following case: amd fam10h + mcp55
> CPU MSR has some range, mcp55 pci config will have another one.
> 
> also prepare for mcp55 + io55 system. every one will have one range.
> 
> if it s mcp55 detect duties to execlude range that is used by CPU MSR
> aka, if CPU state bus 0-255, range in mcp55 need to be dropped.
> because HW in CPU will not route that mcp55 mmconfig to handle it.
> 
> v2: fix e7520 exit path
> 
> Signed-off-by: Yinghai Lu <yinghai.lu@kernel.org>
> 
> ---
>  arch/x86/pci/mmconfig-shared.c |   98 ++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 44 deletions(-)

looks good to me. One for the PCI tree?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
