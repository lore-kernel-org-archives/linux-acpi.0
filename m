From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] PCI IRQ resource deallocation support [2/3]
Date: Fri, 24 Sep 2004 15:29:14 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4153BEBA.5030202@jp.fujitsu.com>
References: <414FEBDB.2050201@soft.fujitsu.com>
 <200409210857.59457.bjorn.helgaas@hp.com> <4150D458.3050400@jp.fujitsu.com>
 <20040924.145229.108814142.t-kochi@bq.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040924.145229.108814142.t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Takayoshi Kochi <t-kochi-UDFczIW9X1d8UrSeD/g0lQ@public.gmane.org>
Cc: bjorn.helgaas-VXdhtT5mjnY@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kaneshige.kenji-tPnzhWqfZ96MLkP6nYsO9A@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Takayoshi,

Thank you for feedback.

Takayoshi Kochi wrote:
>> > Why do we need to fiddle with dev->irq?  I think it should
>> > just be undefined after acpi_pci_irq_disable().
>> 
>> I had been considering what the "undefined dev->irq" was.
>> In fact, I had other ideas that was clearing it by zero or
>> -1 (0xffffffff). But I didn't know if we can use these values
>> as a undefined IRQ number. So I'm clearing it by the value
>> which was assigned by PCI core code (pci_read_irq()) before
>> acpi_pci_irq_enable() was called. 
> 
> I think it has little sense in restoring value from the configuration
> space to dev->irq or clearing it.
> 
> If we do preventive programming, it may be worth
> trying to define some magic constant (e.g. PCI_UNDEFINED_IRQ) and
> panic/BUG when the irq is being enabled.
> Otherwise, leaving dev->irq as it is would be ok.

Hmm, I think you are right.
I'll change my patch to leave dev->irq as it is. And then I'll
investigate about defining PCI_UNDEFINED_IRQ.

In fact, I posted updated patches a little before. I'll re-post
it with your feedback :-)

Thanks,
Kenji Kaneshige



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
