From: Chad LeClair <celeclai-CgpX1INfHeY@public.gmane.org>
Subject: ACPI events generated on PCI usage.
Date: Mon, 09 Feb 2004 13:26:32 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4027D0D8.2020908@mtu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry if this is a repeat, the list seemed to have filtered out the last 
one.

Since upgrading to the 2.6 series of kernel I have
noticed the events/0 process consuming processor time
any time I use a PCI device. For example, when I play
sound on my SB Live, the events/0 consumes ~15% of my
processor. It doesn't effect AGP, or onboard devices.
I turned ACPI debugging on and found that when these
devies are in use a constant stream of DEVICE WAKE
events are generated.

Is there any way to prevent or ignore these events to
avoid wasting processor time on them?

Debug log with debug_level=0xff:

Execute Method: [\_GPE._L05] (Node dff61e68)
  psxface-0124 [18] psx_execute           : **** Begin
Method Parse **** Entry=dff61e68 obj=dff61de8
  psparse-1062 [19] ps_parse_aml          : Entered
with walk_state=dff6a428 Aml=e0802a16 size=0
  psparse-1085 [19] ps_parse_aml          :
State=dff6a428
  psparse-0672 [20] ps_parse_loop         : Opcode 0086
[Notify] Op dff691e8 Aml e0802a17 aml_offset 00000
  psparse-0672 [20] ps_parse_loop         : Opcode 000A
[ByteConst] Op dfe81368 Aml e0802a22 aml_offset 0000B
  psscope-0254 [21] ps_pop_scope          : Popped Op
dff691e8 Args 0
  psparse-0967 [20] ps_parse_loop         : Popped
scope, Op=dff691e8
  psscope-0254 [21] ps_pop_scope          : Popped Op
00000000 Args 0
  psparse-0967 [20] ps_parse_loop         : Popped
scope, Op=00000000
  psparse-0982 [20] ps_parse_loop         : AML package
complete at Op 00000000
  psscope-0254 [21] ps_pop_scope          : Popped Op
00000000 Args 0
  psparse-1099 [19] ps_parse_aml          : Completed
one call to walk loop, AE_OK State=dff6a428
  psparse-1152 [19] ps_parse_aml          :
return_value=00000000, State=dff6a428
dswstate-0743 [19] ds_get_current_walk_st: Current
walk_state 00000000
  psxface-0170 [18] psx_execute           : **** Begin
Method Execution **** Entry=dff61e68 obj=dff61de8
  psparse-1062 [19] ps_parse_aml          : Entered
with walk_state=dff6a428 Aml=e0802a16 size=0
  psparse-1085 [19] ps_parse_aml          :
State=dff6a428
  psparse-0672 [20] ps_parse_loop         : Opcode 0086
[Notify] Op dff691e8 Aml e0802a17 aml_offset 00000
  psparse-0672 [20] ps_parse_loop         : Opcode 000A
[ByteConst] Op dff68d68 Aml e0802a22 aml_offset 0000B
  psscope-0254 [21] ps_pop_scope          : Popped Op
dff691e8 Args 0
  psparse-0967 [20] ps_parse_loop         : Popped
scope, Op=dff691e8
  exnames-0289 [24] ex_get_name_string    :
root_prefix(\) at e0802a17
  exnames-0330 [24] ex_get_name_string    :
dual_name_prefix at e0802a18
  exnames-0188 [25] ex_name_segment       : Bytes from
stream:
  exnames-0194 [25] ex_name_segment       : _
  exnames-0194 [25] ex_name_segment       : S
  exnames-0194 [25] ex_name_segment       : B
  exnames-0194 [25] ex_name_segment       : _
  exnames-0188 [25] ex_name_segment       : Bytes from
stream:
  exnames-0194 [25] ex_name_segment       : P
  exnames-0194 [25] ex_name_segment       : C
  exnames-0194 [25] ex_name_segment       : I
  exnames-0194 [25] ex_name_segment       : 0
   evmisc-0121 [22] ev_queue_notify_reques: Dispatching
Notify(2) on node dff610e8
   evmisc-0133 [22] ev_queue_notify_reques: Notify
value: Device Wake
   evmisc-0199 [22] ev_queue_notify_reques: No notify
handler for [PCI0] node dff610e8
  psscope-0254 [21] ps_pop_scope          : Popped Op
00000000 Args 0
  psparse-0967 [20] ps_parse_loop         : Popped
scope, Op=00000000
  psparse-0982 [20] ps_parse_loop         : AML package
complete at Op 00000000
  psscope-0254 [21] ps_pop_scope          : Popped Op
00000000 Args 0
  psparse-1099 [19] ps_parse_aml          : Completed
one call to walk loop, AE_OK State=dff6a428
  psparse-1152 [19] ps_parse_aml          :
return_value=00000000, State=dff6a428
dswstate-0743 [19] ds_get_current_walk_st: Current
walk_state 00000000
acpi_bus-0492 [15] acpi_bus_notify       : Received
DEVICE WAKE notification for device [PCI0]
...


I am running a vanilla 2.6.2 kernel.  I also tried
adding the latest ACPI patches which had no effect.

I am using an Epox 8kha+ mobo, with an AthlonXP 2200+
output of lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7
[Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7
[Apollo KT266/A/333 AGP]
00:0a.0 Multimedia audio controller: Creative Labs SB
Live! EMU10k1 (rev 0a)
00:0a.1 Input device controller: Creative Labs SB
Live! MIDI/Game Port (rev 0a)
00:0b.0 Multimedia video controller: Brooktree
Corporation Bt878 Video Capture (rev 02)
00:0b.1 Multimedia controller: Brooktree Corporation
Bt878 Audio Capture (rev 02)
00:0c.0 Ethernet controller: Linksys Network
Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI
to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB
(rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. USB
(rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. USB
(rev 1b)
00:11.5 Multimedia audio controller: VIA Technologies,
Inc. VT8233/A/8235 AC97 Audio Controller (rev 30)
01:00.0 VGA compatible controller: Matrox Graphics,
Inc. MGA G400 AGP (rev 03)

Thanks!
--
Chad LeClair




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
