From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: [RFC] Reliable video POSTing on resume (was: Re: Samsung P35,
 S3, black screen (radeon))
Date: Fri, 04 Feb 2005 03:35:39 +0100
Message-ID: <4202DF7B.2000506@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107474198.5727.9.camel-r49W/1Cwd2ff0s6lnCXPXw0QcLn3kwYh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2005-02-04 at 09:54, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>>>Are you able to use framebuffer(radeonfb,1024x768) with this
>>>>>configuration or do you need to use plain vga-console for it to work?
>>>>
>>>>No.
>>>>For a working framebuffer console you would have to perform the steps
>>>>my script does *before* the kernel tries to access the framebuffer
>>>>console after resume. Since this is not yet possible, you're out of
>>>>luck. If
>>>>- the vbestate utility was a kernel module or
>>>
>>>OK, I managed to track this down further.
>>>"vbetool post" should be equivalent to "acpi_sleep=s3_bios", but there
>>>are some differences. For me, that's easy to explain: "vbetool post"
>>>segfaults because it wants to access parts of the video bios which
>>>are no longer available. "acpi_sleep=s3_bios" suffers from the same
>>>problem, but it runs in real mode and can't recover :-(
>>>
>>>To alleviate that problem, the kernel could run the video bios in
>>>vm86 mode (like vbetool does by using lrmi). This would simplify
>>>the asm wakeup code and make video POST more reliable.
>>>
>>>Pavel, what do you think?
>>
>>Well, calling BIOS using vm86 is going to be quite a lot of code. If
>>it is self-contained and not too huge, it is probably okay. It should
>>help with quite a lot of cards, but who knows...
>>
>>Yes, it is probably worth trying.
> 
> I'd love to see it too. Pavel, even if you don't want to merge it for a
> while, we can always incorporate it in the Suspend2 patches so it gets
> some testing. I know I'd try it on my i830 based Omnibook.

Can we use call_usermodehelper at this early resume stage (before any
video access)? Calling vm86 directly is probably not going to fly
because we want to be shielded from any misbehaviour in the bios code
and it may be necessary to kill the process running the bios code.

Cases in point: My bios will cause the POSTing application to segfault.
Others have reported the POSTing application just hangs, but the
important things are done before the hang, so killing it after maybe
5 seconds would be ok.

Rough outline how to do that without adding tons of code:
We need a call_usermodehelper_from_ram_with_timeout for that.

Kernel:                          Userspace:
User wants to enter S3
init_mutex_locked(s3_sem)
call_usermodehelper("vesaposter")
                                 vesaposter calls LRMI_init
                                 vesaposter mlocks all its memory
                                 vesaposter calls into kernel
                                          and down(s3_sem)
suspend vesafb

User has triggered resume
run wakeup.S
thaw essential threads
set a timer of 5 seconds
up(s3_sem)
thaw and schedule vesaposter
wait for timer or vesaposter termination
                                 vesaposter returns from kernel
                                 vesaposter posts video card
                                 vesaposter terminates
resume vesafb
continue resume

Problems with that approach:
- vesaposter has to be locked in memory to avoid disk accesses
- vesafb has to refrain from touching video until after POST
- the vesaposter thread has to be the first unfrozen and
  scheduled and completed thread. Only after that we can resume
  vesafb and other threads
- the locking will be tricky

Advantages:
- the problems all seem to be solvable easily
- security and stability are similar to the current userspace code
- we can use vesafb on such machines
- the kernel code won't be much more than two dozen lines
- the userspace POSTing code can be upgraded without the need
  for kernel updates (no policy in the kernel)

What do you think?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
