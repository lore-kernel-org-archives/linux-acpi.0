From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
Date: Mon, 17 May 2004 23:13:38 +0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40A90EE2.3040507@wasp.net.au>
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S262238AbUEQTOF@vger.kernel.org>
In-Reply-To: <1084820518.12349.347.camel@dhcppc4>
To: Len Brown <len.brown@intel.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Len Brown wrote:

> LNKH would have hit the bug fixed in 2665.
> However, LNKH isn't enabled, so we don't hit that bug.
> 
> LNKC, OTOH, is already enabled on IRQ12; and both
> 2.6.5 and 2.6.6 will leave it there unless you explicity
> tell Linux to move IRQs in PIC mode with "acpi_irq_balance".
> 
> apples/apples comparison would be to boot your 2.6.5 kernel with
> "noapic".  I expect 2.6.5 will have the same issue with IRQ12
> in PIC mode.  Unusual for a BIOS to put PCI devices on IRQ12 like
> that...

Err.. yeah, I'm not quite sure why but a make oldconfig on my 2.6.5 config did not enable apic.
Rather than boot 2.6.5 noapic, I enabled apic on 2.6.6 and the dmesg compares perfectly to the 2.6.5 
one, right up until it tries to probe the 9th disk where it proceeds to dma timeout and then cease 
to listen to anything..

Regards,
Brad
