From: Robert Woerle Paceblade/Support <robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
Date: Thu, 27 Feb 2003 16:53:39 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3E5E3483.7000302@paceblade.com>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com> <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030227151907.GC12434-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



Pavel Machek schrieb:

>Hi!
>
>  
>
>>>>OK, looks reasonable. Can you also gen up a patch documenting this in
>>>>kernel-parameters.txt?
>>>>  
>>>>
>>>>        
>>>>
>>>You can, assuming you took the patch ;-).
>>>
>>>
>>>      
>>>
>>well how can i find the correct value`s to put in ??
>>    
>>
>
>Well, similar method to how you use mem=123@456 parameters. You just
>guess them. [Given kernel messages, it is actually quite easy.]
>
>  
>
well .. wow ... what a accurate solution `????
...
..
.
well cant you tell me more ?

>  
>
>>>--- clean/Documentation/kernel-parameters.txt	2003-02-11 
>>>17:40:28.000000000 +0100
>>>+++ linux/Documentation/kernel-parameters.txt	2003-02-26 
>>>23:43:21.000000000 +0100
>>>@@ -516,6 +516,10 @@
>>>			[KNL,BOOT] Force usage of a specific region of memory
>>>			Region of memory to be used, from ss to ss+nn.
>>>
>>>+	mem=nn[KMG]#ss[KMG]
>>>+			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
>>>+			Region of memory to be used, from ss to ss+nn.
>>>+
>>>	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
>>>			memory.
>>>
>>>      
>>>
>
>
>  
>

-- 
_____________________________________
*Robert Woerle
**Technical Support | Linux
PaceBlade Technology Europe SA*
phone: +49 89 552 99935
fax: +49 89 552 99910
mobile: +49 179 474 45 27
email: robert-fPtsKRK0pHxl57MIdRCFDg@public.gmane.org <mailto:robert@paceblade.com>
web: http://www.paceblade.com
_____________________________________
