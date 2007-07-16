From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI strangeness - battery jumping to low capacity and back
Date: Mon, 16 Jul 2007 19:25:06 +0400
Message-ID: <469B8DD2.1040304@gmail.com>
References: <469B4E8A.3050809@iversen-net.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:25143 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbXGPPZI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 11:25:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so999318ugf
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 08:25:06 -0700 (PDT)
In-Reply-To: <469B4E8A.3050809@iversen-net.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Iversen <chrivers@iversen-net.dk>
Cc: linux-acpi@vger.kernel.org

Hi Christian,

First, it is better if you open a bug in bugzilla.kernel.org against 
ACPI/Battery and attach all your files there, so they will not be lost.
Second, please try latest stable kernel from kernel.org, not Ubuntu one, 
as they seem to be not very careful with ACPI. 

Regards,
Alex.

Christian Iversen wrote:
> 
> Hi $ALL
> 
> My notebook is behaving somewhat oddly. The KDE battery indicator
> usually shows the right amount of battery power left, although every now
> and then, it jumps to a value in the range 0-10%, and then jumps back.
> This is quite annoying, because it gives of all sorts of warnings about
> imminent power failure.
> 
> I'm running kubuntu 7.04 with 2.6.20-15-generic from standard packages,
> on a Zepto 4200 (rebranded Compal CL56)
> 
> It _seems_ -- I'm not quite sure about the causality of this -- that the
> following error messages turn up in dmesg when the jump happens:
> 
> ...
> [577843.068000] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPC0.BAT1._BST] (Node df853608), AE_NOT_FOUND
> [577843.068000] ACPI Exception (acpi_battery-0207): AE_NOT_FOUND,
> Evaluating _BST [20060707]
> [577873.068000] ACPI Error (psargs-0355): [PBST] Namespace lookup
> failure, AE_NOT_FOUND
> [577873.068000] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPC0.BAT1._BST] (Node df853608), AE_NOT_FOUND
> [577873.068000] ACPI Exception (acpi_battery-0207): AE_NOT_FOUND,
> Evaluating _BST [20060707]
> [577903.080000] ACPI Error (psargs-0355): [PBST] Namespace lookup
> failure, AE_NOT_FOUND
> [577903.080000] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPC0.BAT1._BST] (Node df853608), AE_NOT_FOUND
> [577903.080000] ACPI Exception (acpi_battery-0207): AE_NOT_FOUND,
> Evaluating _BST [20060707]
> [577933.076000] ACPI Error (psargs-0355): [PBST] Namespace lookup
> failure, AE_NOT_FOUND
> [577933.076000] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPC0.BAT1._BST] (Node df853608), AE_NOT_FOUND
> [577933.076000] ACPI Exception (acpi_battery-0207): AE_NOT_FOUND,
> Evaluating _BST [20060707]
> [577963.068000] ACPI Error (psargs-0355): [PBST] Namespace lookup
> failure, AE_NOT_FOUND
> [577963.068000] ACPI Error (psparse-0537): Method parse/execution failed
> [\_SB_.PCI0.LPC0.BAT1._BST] (Node df853608), AE_NOT_FOUND
> [577963.068000] ACPI Exception (acpi_battery-0207): AE_NOT_FOUND,
> Evaluating _BST [20060707]
> ...
> 
> Maybe it has nothing to do with it? It seems to be battery-related, at
> least.
> 
> Is there something else I can do to help debug the cause of these error
> messages and/or the battery problem?
> 
> I've attached the output of dmidecode and acpidump, in case it's useful.
> 

