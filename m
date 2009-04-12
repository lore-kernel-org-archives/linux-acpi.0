From: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Subject: [BISECTED] EEE PC hangs when booting off battery
Date: Sun, 12 Apr 2009 14:11:57 +0100
Message-ID: <49E1E89D.7040502@tuffmail.co.uk>
References: <49E065CF.6040408@tuffmail.co.uk> <66dc75180904111107q645fbb77i3cf927ffab7a7ef0@mail.gmail.com> <49E1ADAE.2030103@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E1ADAE.2030103-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Alan Jenkins wrote:
> Tzy-Jye Daniel Lin wrote:
>   
>> On Sat, Apr 11, 2009 at 5:41 AM, Alan Jenkins
>> <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org> wrote:
>>   
>>     
>>> Regression #6 on latest git! (last known good is 2.6.29-rc8)
>>>
>>> Magic SysRQ keys work though.  Unfortunately, SysRq-W / SysRq-T generate
>>> too much output, so the useful bits immediately scroll off the top of
>>> the screen.  I can't press SysRq-P (even if that would help), because
>>> the SysRQ key on my laptop is accessed using a Fn modifier key, which
>>> also turns the left hand side of the keyboard into a numeric pad.
>>>     
>>>       
>> I don't own an Eee, but having played with one, the key sequence
>>
>>     Alt down
>>     Fn down
>>     SysRq down, up
>>     Fn up
>>     P down, up
>>     Alt up
>>
>> should work just fine.  As long as you keep holding Alt, you don't
>> need to continue holding SysRq after the initial keypress.
>>
>>   
>>     
>>> Magic SysRQs on my USB keyboard generate no response.  (Sometimes the
>>> numlock key seems to work though.  I can't tell on the laptop keyboard
>>> because the laptop doesn't have a numlock led).
>>>     
>>>       
>> SysRq over USB has never worked.  On PC hardware, Magic SysRq depends
>> on features of the built-in i8042 controller, which only handles PS/2
>> input.
>>   
>>     
> Great, thanks a lot!
>
> I was able to run SysRq-P, and found the following backtrace -
>
> Pid: 0
> EIP is at acpi_idle_enter_bm+0x1df/0x208 [processor]
> cpud_idle_call
> cpu_idle
> rest_init
> start_kernel
> i386_start_kernel
>   

7ec0a7290797f57b780f792d12f4bcc19c83aa4f is first bad commit
commit 7ec0a7290797f57b780f792d12f4bcc19c83aa4f
Author: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Date:   Mon Mar 30 17:48:24 2009 +0000

    ACPI: processor: use .notify method instead of installing handler
directly

    This patch adds a .notify() method.  The presence of .notify() causes
    Linux/ACPI to manage event handlers and notify handlers on our behalf,
    so we don't have to install and remove them ourselves.

    Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
    CC: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    CC: Zhao Yakui <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    CC: Venki Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    CC: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
    Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>



However, reverting this commit from v2.6.30-rc1 doesn't solve the hang.

Alan
