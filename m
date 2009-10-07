From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.32-rc3: floating-point build failure (undefined reference
 to	`__udivdi3' in menu governor)
Date: Wed, 07 Oct 2009 07:23:07 -0700
Message-ID: <4ACCA44B.3070706@linux.intel.com>
References: <20091007104125.GA1449@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:25059 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758524AbZJGOYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Oct 2009 10:24:11 -0400
In-Reply-To: <20091007104125.GA1449@rhlx01.hs-esslingen.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-kernel@vger.kernel.org, Adam Belay <abelay@novell.com>, linux-acpi@vger.kernel.org

Andreas Mohr wrote:
> Hi,
> 
> didn't find any report about this, so...
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xd85a1): In function `menu_select':
> drivers/cpuidle/governors/menu.c:212: undefined reference to `__udivdi3'
> make: *** [.tmp_vmlinux1] Error 1
> 
> # gcc -v
> Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/3.2.3/specs
> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --disable-checking --with-system-zlib --enable-__cxa_atexit --host=i386-redhat-linux
> Thread model: posix
> gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-49)

seems you're the only user of this left.

it's not floating point but a 64 bit division.
The only one I can imagine is the one on line 213

looking at it, can you try sticking (u32) at the end of line 212; that multiply is not very likely to exceed 32 bits


