From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: High pitched sound + OOPS with acpi/processor on DELL inspiron 8600
Date: Mon, 5 Jul 2004 19:12:47 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F033D362E@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Renald Buter <buter-4r0WXg0DlYa9LbC4/O9sjvP6llvjuJOh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

There is a patch in http://bugme.osdl.org/show_bug.cgi?id=3D1716, it
should fix your problem. Please try.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Renald Buter
>Sent: Monday, July 05, 2004 3:02 PM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] High pitched sound + OOPS with acpi/processor on DELL
>inspiron 8600
>
>Hello list,
>
>When I load the acpi/processor module (or compile it into the kernel),
>a high-pitched sound will start to emit from under the keyboard. This
>whine will lessen when the CPU has something to do, so I presume it has
>something to do the the dummy calls? Would there be an easy fix?
>
>Also, removing the processor module from the kernel results in a kernel
>OOPS:
>	Jul  4 15:25:19 epsilon kernel: Unable to handle kernel paging
>request at virtual address e0ba228c
>	Jul  4 15:25:19 epsilon kernel:  printing eip:
>	Jul  4 15:25:19 epsilon kernel: e0ba228c
>	Jul  4 15:25:19 epsilon kernel: *pde =3D 0146b067
>	Jul  4 15:25:19 epsilon kernel: *pte =3D 00000000
>	Jul  4 15:25:19 epsilon kernel: Oops: 0000 [#1]
>	Jul  4 15:25:19 epsilon kernel: PREEMPT
>	Jul  4 15:25:19 epsilon kernel: CPU:    0
>	Jul  4 15:25:19 epsilon kernel: EIP:    0060:[<e0ba228c>]
Tainted:
>P
>	Jul  4 15:25:19 epsilon kernel: EFLAGS: 00010282   (2.6.6)
>	Jul  4 15:25:19 epsilon kernel: EIP is at 0xe0ba228c
>	Jul  4 15:25:19 epsilon kernel: eax: 00000000   ebx: 009be59a
ecx:
>00000008   edx: 00000000
>	Jul  4 15:25:19 epsilon kernel: esi: de97a8f8   edi: 009bd7e7
ebp:
>de97a800   esp: c034dfbc
>	Jul  4 15:25:19 epsilon kernel: ds: 007b   es: 007b   ss: 0068
>	Jul  4 15:25:19 epsilon kernel: Process swapper (pid: 0,
>threadinfo=3Dc034c000 task=3Dc02dda40)
>	Jul  4 15:25:19 epsilon kernel: Stack: 00099100 00000000
c034c000
>00099100 c037b0a0 003ba007 c0101fa4 c034c000
>	Jul  4 15:25:19 epsilon kernel:        c034e78f c02dda40
00000000
>c0373548 00000012 c034e4d0 c037b0c0 00000816
>	Jul  4 15:25:19 epsilon kernel:        c010019f
>	Jul  4 15:25:19 epsilon kernel: Call Trace:
>	Jul  4 15:25:19 epsilon kernel:  [<c0101fa4>] cpu_idle+0x34/0x40
>	Jul  4 15:25:19 epsilon kernel:  [<c034e78f>]
>start_kernel+0x15f/0x180
>	Jul  4 15:25:19 epsilon kernel:  [<c034e4d0>]
>unknown_bootoption+0x0/0x120
>	Jul  4 15:25:19 epsilon kernel:
>	Jul  4 15:25:19 epsilon kernel: Code:  Bad EIP value.
>	Jul  4 15:25:19 epsilon kernel:  <0>Kernel panic: Attempted to
kill
>the idle task!
>	Jul  4 15:25:19 epsilon kernel: In idle task - not syncing
>Disabling PREEMPT in the kernel will fix this.
>
>Both these issues occur with recent (vanilla) kernels: 2.6.6 and 2.6.7.
>Otherwise, loading acpi/processor in the kernel will (apart from the
>whine) leaves me with a working system: throttling, speedstep, etc.
will
>all work as expected.
>
>If you need more info, I'll be happy to produce it. Hints on where to
>look/change parameters are also more than welcome!
>
>If I'm barking up the wrong tree here, my apologies in advance. But I
>hope at least the pitched sound thing can be fixed, because without the
>acpi/processor the CPU runs hotter than it should.
>
>Thanks for the great work on the ACPI subsytem!
>
>Regards,
>
>Renald Buter



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
