From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Linux 2.6.21-rc7 - ACPI issues?
Date: Sat, 21 Apr 2007 12:46:14 -0700
Message-ID: <20070421124614.1206dcfa.akpm@linux-foundation.org>
References: <8355959a0704210703n35b0dc35wcad04e5723eaec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:37602 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063AbXDUTqR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 15:46:17 -0400
In-Reply-To: <8355959a0704210703n35b0dc35wcad04e5723eaec7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sunil Naidu <akula2.shark@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, 21 Apr 2007 19:33:52 +0530 "Sunil Naidu" <akula2.shark@gmail.com> wrote:

> Hello,
> 
> I did compile 2.6.21-rc7 for a P-III machine. Here is the ACPI part in
> the dmesg:-
> 
> ACPI Error (psargs-0355): [PRSE] Namespace lookup failure, AE_NOT_FOUND
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.LNKE._PRS] (Node dfd63f40), AE_NOT_FOUND
> ACPI Exception (pci_link-0180): AE_NOT_FOUND, Evaluating _PRS [20060707]
> ACPI Error (psargs-0355): [PRSF] Namespace lookup failure, AE_NOT_FOUND
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.LNKF._PRS] (Node dfd63ea0), AE_NOT_FOUND
> ACPI Exception (pci_link-0180): AE_NOT_FOUND, Evaluating _PRS [20060707]
> ACPI Error (psargs-0355): [PRSG] Namespace lookup failure, AE_NOT_FOUND
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.LNKG._PRS] (Node dfd63e00), AE_NOT_FOUND
> ACPI Exception (pci_link-0180): AE_NOT_FOUND, Evaluating _PRS [20060707]
> ACPI Error (psargs-0355): [PRSH] Namespace lookup failure, AE_NOT_FOUND
> ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.LNKH._PRS] (Node c147d75c), AE_NOT_FOUND
> ACPI Exception (pci_link-0180): AE_NOT_FOUND, Evaluating _PRS [20060707]
> 
> I tried with few configurations (config) to solve the problem, am not
> sure what's causing this failure. Any hint?
> 

(added linux-acpi)

Are any other problems observeable due to this?

