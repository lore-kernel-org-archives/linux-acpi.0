From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC  - V2] - Mapping ACPI tables as CACHED
Date: Thu, 26 Aug 2010 11:08:02 -0700
Message-ID: <4C76AD82.2030105@zytor.com>
References: <20100722152220.GA18290@sgi.com> <20100724001449.GA9618@khazad-dum.debian.net> <4C743C0F.2010101@zytor.com> <20100826171704.GA21584@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33562 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab0HZSI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Aug 2010 14:08:27 -0400
In-Reply-To: <20100826171704.GA21584@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: hmh@hmh.eng.br, mingo@elte.hu, tglx@linutronix.de, lenb@kernel.org, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/26/2010 10:17 AM, Jack Steiner wrote:
> Map ACPI tables as WB on x86_64. No substantive changes to IA64.
> 
> 
> Signed-off-by: Jack Steiner <steiner@sgi.com>
> 
> ---
> V2 - Change the patch to unconditionally map ACPI tables as WB on x86_64.
>      I'm still some paranoid about this because of the potential imapct on
>      some platforms with weird BIOSs. However, note that on EFI-enabled
>      systems (like UV), the ACPI tables are already mapped as WB memory.
>      This is done in the EFI function efi_enter_virtual_mode().
>      The ACPI code in acpi_os_map_memory() is not currently aware of the
>      EFI mapping & currently maps the memory as UC. This seems like a bug.
> 

I really think that it's all a consequence of the fact that ioremap()
became implicitly UC when we added PAT support (being the more
conservative choice.)

Len, want to take this one or should I?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

