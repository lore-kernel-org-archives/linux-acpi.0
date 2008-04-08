From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Hard freeze / interrupt-related death / instability
Date: Wed, 09 Apr 2008 02:14:29 +0400
Message-ID: <47FBEE45.8010900@gmail.com>
References: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>	 <1207687673.3091.12.camel@linux-2bdv.site> <d55656c10804081502s52c61c7eo623cd9b6255613bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <d55656c10804081502s52c61c7eo623cd9b6255613bb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Peter Gervai <grinapo@gmail.com>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Peter Gervai wrote:
>
>>  > #acpi=off                       - uniprocessor, ok
>>  > #noapic acpi=off                - uniprocessor, ok
>>  What means uniprocessor?
>>  Also added nosmp or maxcpus=1?
>>     
>
> Oh, maybe forgot to explain this one (copypaste from my grub menu.lst
> :)). It means the machine didn't freeze but the kernel completely
> ignored the second core of the dual core cpu, basically seem to have
> ignored SMP capability altogether. I did not use nosmp or maxcpu since
> I do want to use them all. :)
>
>   
This is expected, there are two ways to find second CPU -- with MP 
tables and ACPI.
New machines do not carry MP tables, so if you disable ACPI, second CPU 
remains
unknown to the system.

