From: dev_zero <dev_xor-eZNTXLQAfP4@public.gmane.org>
Subject: RE: kacpid problems
Date: Tue, 9 Nov 2004 17:15:23 +0100 (CET)
Message-ID: <20041109161523.33975.qmail@web25310.mail.ukl.yahoo.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC041@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC041@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I don't know how to get an output from the event file
so, I give you what I've got so far.

Here is the last messages in the /var/log/acpid file:
[Tue Nov  9 15:52:29 2004] received event
"thermal_zone THRM 00000081 00000000"
[Tue Nov  9 15:52:29 2004] executing action
"/etc/acpi/acpi_handler.sh thermal_zone THRM 00000081
00000000"
[Tue Nov  9 15:52:29 2004] BEGIN HANDLER MESSAGES
[Tue Nov  9 15:52:30 2004] END HANDLER MESSAGES
[Tue Nov  9 15:52:30 2004] action exited with status 0
[Tue Nov  9 15:52:30 2004] completed event
"thermal_zone THRM 00000081 00000000"
[Tue Nov  9 16:15:11 2004] exiting
[Tue Nov  9 16:16:27 2004] starting up
[Tue Nov  9 16:16:27 2004] 1 rule loaded

The thing here is that after I installed the patch as
you can see, I don't get the thermal_zone handler
message..

Output from /var/log/messages:
Nov  9 16:16:01 balder kernel: ohci1394: fw-host0:
OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[e0000000-e00007ff]  Max Packet=[2048]
Nov  9 16:16:01 balder kernel: agpgart: Detected SiS
650 chipset
Nov  9 16:16:01 balder kernel: agpgart: Maximum main
memory to use for agp memory: 174M
Nov  9 16:16:01 balder kernel: agpgart: AGP aperture
is 256M @ 0xd0000000
Nov  9 16:16:03 balder ieee1394.agent[2085]: ... no
drivers for IEEE1394 product 0x/0x/0x
Nov  9 16:16:20 balder logger: /etc/rc.d/rc.hotplug
start (exiting script)
Nov  9 16:16:20 balder sshd[2516]: Server listening on
0.0.0.0 port 22.
Nov  9 16:16:27 balder kernel: lp: driver loaded but
no devices found
Nov  9 16:21:05 balder kernel: Intel 810 + AC97 Audio,
version 1.01, 00:36:43 Oct 28 2004
Nov  9 16:21:05 balder kernel: ACPI: PCI interrupt
0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5
Nov  9 16:21:05 balder kernel: i810: SiS 7012 found at
IO 0x1800 and 0x1c00, MEM 0x0000 and 0x0000, IRQ 5
Nov  9 16:21:05 balder kernel: i810_audio: Audio
Controller supports 6 channels.
Nov  9 16:21:05 balder kernel: i810_audio: Defaulting
to base 2 channel mode.
Nov  9 16:21:05 balder kernel: i810_audio: Resetting
connection 0
Nov  9 16:21:05 balder kernel: ac97_codec: AC97 Audio
codec, id: ALG16 (ALC200/200P)

In the message file before I applied your patch I
usually got a message saying THRM not defined, but
after I applied your patch as you can see above I
don't get anything:
Oct 24 20:15:24 balder logger: ACPI group thermal_zone
/ action THRM is not defined 
Oct 24 20:26:09 balder -- MARK -- 


> >How am i supppose to get an output from
> >/proc/acpi/event ??? I can't access the file,
> because
> >it's in use.
> 
> Just kill acpid or the similar.
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for
> FREE
> LinuxWorld Reader's Choice Award Winner for best
> database on Linux.
> http://ads.osdn.com/?ad_idU88&alloc_id065&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
https://lists.sourceforge.net/lists/listinfo/acpi-devel
>  


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
