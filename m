From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: Video output shutdown
Date: Thu, 09 Nov 2006 22:47:31 +0100
Message-ID: <4553A1F3.8020405@tzi.de>
References: <20061109054240.22995.qmail@web86913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:27135 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S965695AbWKIVqx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Nov 2006 16:46:53 -0500
In-Reply-To: <20061109054240.22995.qmail@web86913.mail.ukl.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nicolas ricard <nicolasricard@yahoo.fr>
Cc: linux-acpi@vger.kernel.org

nicolas ricard wrote:
> Hi,
> I run linux kernel 2.6.13 with ACPI enabled on a PC104
> board from DigitalLogic with Pentium M and integrated
> graphic chipset (915GM or 
> 955GM i think).
>
> The system runs with a video output and XFree86 as X
> server, but no input like keyboard or mouse.
>
> My problem is that after a while (~ 15'), the video
> output is switched off. If i plug a mouse, a mouse
> move is enougth to switch it on again.
>    
> Do you think this is an ACPI issue?
> If so, how can i avoid that video switch off ?
>    
> Thanks for your response.
>    
> Nicolas RICARD
>  
>
>   
man XFree86.conf should fix your problem...

   Janosch
