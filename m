From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: VGA patch by Bruno Ducrot -- no success yet
Date: Thu, 12 Feb 2004 23:37:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040212223706.GA13262@poupinou.org>
References: <m3u11wnflb.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m3u11wnflb.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 12, 2004 at 10:38:24PM +0100, Georg C. F. Greve wrote:
> Hi Bruno,
> 
> thanks for your patch [*] to implement the ACPI VGA display
> extensions, as promised, I gave it a shot on my machine with Linux
> kernel 2.6.2 (swsusp2, ACPI20040116, ACPI/APIC fix).
> 
> The patch applied cleanly and the kernel compiled fine.
> 
> 
> During boot, things look not too bad
> 
>  ACPI: AC Adapter [AC0] (on-line)
>  ACPI: Battery Slot [BAT0] (battery present)
>  ACPI: Power Button (FF) [PWRF]
>  ACPI: Sleep Button (CM) [SLPB]
>  ACPI: Lid Switch [LID]
>  ACPI: Fan [FN00] (off)
>  ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
>  ACPI: Processor [CPU1] (supports C1 C2 C3, 8 throttling states)
>  ACPI: Thermal Zone [THRM] (53 C)
>  Asus Laptop ACPI Extras version 0.27
>    M2N model detected, supported
> 
> 
> Doing a tree /proc/acpi/video/ shows
> 
>  /proc/acpi/video/
>  `-- VGA
>      |-- CRTD
>      |   |-- EDID
>      |   |-- brightness
>      |   |-- info
>      |   `-- state
>      |-- LCDD
>      |   |-- EDID
>      |   |-- brightness
>      |   |-- info
>      |   `-- state
>      |-- POST
>      |-- POST_info
>      |-- ROM
>      `-- info
> 
> (is it normal that CRT and LCD have another "D" at the end?)

Yes, it's the same as for the device in the ACPI namespace, the same
apply for the VGA also.

> Doing a cat on the different nodes gives for LCD:
> 
> cat ./LCDD/EDID
> <not supported>

Ok, that one is very not common.

> cat ./LCDD/brightness
> <not supported>

For an LCD device, that not very fun unfortunately :(

> cat ./LCDD/state
> state:     0x1f
> query:     0x01
>  
> cat ./LCDD/info
> device_id:    0x0400

Yet another ID that I should consider I guess..

> type:         UNKNOWN
> known by bios: yes
> 
> 
> And for CRT:
> 
> cat ./CRTD/EDID
> <not supported>
>  
> cat ./CRTD/brightness
> <not supported>
>  
> cat ./CRTD/state
> state:     0x1d
> query:     0x00
>  
> cat ./CRTD/info
> device_id:    0x0100
> type:         CRT
> known by bios: yes
> 
> 
> And finally POST:
> 
> cat ./POST
> <not supported>
>  
> cat ./POST_info
> <not supported>
>  
> cat ./ROM
> <TODO>

Well, that need to be done as said, even though in fact that is really
uncommon though.

> cat ./info
> Switching heads:              yes
> Video ROM:                    no
> Device to be POSTed on boot:  no
>  
> 

> 
> and the display remaining dead -- unfortunately.

Ok.

> Feb 12 21:54:30 myhost kernel: Uninitialised timer!
> Feb 12 21:54:30 myhost kernel: This is just a warning.  Your computer is OK
> Feb 12 21:54:30 myhost kernel: function=0x00000000, data=0x0
> Feb 12 21:54:30 myhost kernel: Call Trace:
> Feb 12 21:54:30 myhost kernel:  [check_timer_failed+99/101] check_timer_failed+0x63/0x65
> Feb 12 21:54:30 myhost kernel:  [del_timer+26/135] del_timer+0x1a/0x87
> Feb 12 21:54:30 myhost kernel:  [_end+541737980/1069013880] ehci_stop+0x73/0xde [ehci_hcd]
> Feb 12 21:54:30 myhost kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43

Is the system more stable without preempt, btw?

> 
> And then there is one that seems definitely related to the new driver:
> 

Yes.

> Feb 12 21:56:32 myhost kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
> Feb 12 21:56:32 myhost kernel:  printing eip:
> Feb 12 21:56:32 myhost kernel: c020e756
> Feb 12 21:56:32 myhost kernel: *pde = 00000000
> Feb 12 21:56:32 myhost kernel: Oops: 0000 [#2]
> Feb 12 21:56:32 myhost kernel: CPU:    0
> Feb 12 21:56:32 myhost kernel: EIP:    0060:[acpi_video_device_write_brightness+188/248]    Not tainted
> Feb 12 21:56:32 myhost kernel: EFLAGS: 00010246
> Feb 12 21:56:32 myhost kernel: EIP is at acpi_video_device_write_brightness+0xbc/0xf8
> Feb 12 21:56:32 myhost kernel: eax: df5e8820   ebx: 00000003   ecx: 00000000   edx: 00000000
> Feb 12 21:56:32 myhost kernel: esi: d4a5ff58   edi: 080e940b   ebp: 00000000   esp: d4a5ff4c
> Feb 12 21:56:32 myhost kernel: ds: 007b   es: 007b   ss: 0068
> Feb 12 21:56:32 myhost kernel: Process bash (pid: 1962, threadinfo=d4a5e000 task=d4d26080)
> Feb 12 21:56:32 myhost kernel: Stack: d50ae91c 00000014 df5e8820 000a3032 c020e69a d4dfec80 d4dfeca0 00000003
> Feb 12 21:56:32 myhost kernel:        c015b3fc d4dfec80 080e9408 00000003 d4dfeca0 d4dfec80 d50ae880 d4dfec80
> Feb 12 21:56:32 myhost kernel:        00000000 fffffff7 d4a5e000 c015b620 d4dfec80 080e9408 00000003 d4dfeca0
> Feb 12 21:56:32 myhost kernel: Call Trace:
> Feb 12 21:56:32 myhost kernel:  [acpi_video_device_write_brightness+0/248] acpi_video_device_write_brightness+0x0/0xf8
> Feb 12 21:56:32 myhost kernel:  [vfs_write+176/281] vfs_write+0xb0/0x119
> Feb 12 21:56:32 myhost kernel:  [sys_write+85/358] sys_write+0x55/0x166
> Feb 12 21:56:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Feb 12 21:56:32 myhost kernel:
> Feb 12 21:56:32 myhost kernel: Code: 3b 4a 04 7d 2d 8b 42 08 8b 74 24 04 3b 34 88 75 1b 56 ff 74

> 
> 
> Hope this helps with the debugging... :-)

Yes, at least for the latter oops, I will be gratefull if you send me a
brown bag...

--- video.c	2004/02/12 22:26:41	1.1
+++ video.c	2004/02/12 22:34:21
@@ -617,6 +617,9 @@
 	if (!dev || count + 1 > sizeof str)
 		return_VALUE(-EINVAL);
 
+	if (!dev->brightness)
+		return_VALUE(-ENODEV);
+
 	if (copy_from_user(str, buffer, count))
 		return_VALUE(-EFAULT);
 


> P.S. Oh yeah, machine is ASUS M2N, Intel 855GM, more info:
>      http://bugme.osdl.org/show_bug.cgi?id=1774#c3

Thanks for testing!

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
