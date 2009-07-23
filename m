From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: next: sfi build fails when !CONFIG_ACPI
Date: Thu, 23 Jul 2009 12:43:30 +0400
Message-ID: <a4423d670907230143l78f324dewefa4cb8990ef4266@mail.gmail.com>
References: <a4423d670907160148n66760052wbef60e4a2c3c7941@mail.gmail.com>
	 <alpine.LFD.2.00.0907162145140.3531@sony-vgn-z540>
	 <a4423d670907170657o2c68c479j9b4810af5adad29f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <a4423d670907170657o2c68c479j9b4810af5adad29f@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-next <linux-next@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

2009/7/17 Alexander Beregalov <a.beregalov@gmail.com>:
> 2009/7/17 Len Brown <lenb@kernel.org>:
>>> drivers/sfi/sfi_core.c: In function 'sfi_init':
>>> drivers/sfi/sfi_core.c:346: error: 'acpi_disabled' undeclared (first
>>> use in this function)
>>> drivers/sfi/sfi_core.c:346: error: (Each undeclared identifier is
>>> reported only once
>>> drivers/sfi/sfi_core.c:346: error: for each function it appears in.)
>>>
>>>
>>> $ grep ACPI .config
>>> # Power management and ACPI options
>>
>> It builds for me.
>> Please send me the complete failing .config
>
> Attached (x86_64)

Still fails for me in the same way,
X86_64
next-20090723
