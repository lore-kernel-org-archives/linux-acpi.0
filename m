From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Vortex86SX: only works with irqpoll
Date: Tue, 24 Nov 2009 17:42:02 -0600
Message-ID: <4B0C6F4A.1080304@gmail.com>
References: <be7a9f3d0911191311p45d4438bg84d55234eacdd320@mail.gmail.com>	 <20091123134002.bac1e664.akpm@linux-foundation.org>	 <4B0B1B62.2030302@gmail.com>	 <be7a9f3d0911231601p4dcfa519q4d1504a8ee37fdad@mail.gmail.com>	 <4B0B36F0.30109@gmail.com> <be7a9f3d0911240329r50ddb22dvd933f01d296295c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934468AbZKXXmI@vger.kernel.org>
In-Reply-To: <be7a9f3d0911240329r50ddb22dvd933f01d296295c1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11/24/2009 05:29 AM, Otavio Salvador wrote:
> Hello Robert,
>
> On Mon, Nov 23, 2009 at 11:29 PM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> Looking at the BIOS manual on their web site:
>>
>> ftp://download@ftp.dmp.com.tw/vortex86sx/Vortex86SX_BIOS_Manual.pdf
>>
>> you can try toggling a few of the options: Try switching OnBoard IDE Operate
>> Mode between Legacy Mode and Native Mode. If the kernel and the actual
>> device disagree here, that could cause IRQ delivery problems. You can also
>> try playing with the "Plug&  Play OS" setting.
>
> The machine with me has no "OnBoard IDE Operate Mode" option. "Plug&
> Play OS" has been tried with "Yes" and "No".
>
> If the kernel and the actual device disagree, could it  also "break"
> the ethernet adaptor? This also doesn't work.

Well, the ethernet adapter would likely be a different problem. Do you 
get any interrupts showing up in /proc/interrupts for either the disk or 
the network adapter?
