From: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Subject: AML parser modifications - 2.6.10 - 2.6.10-bk7 - AE_AML_BUFFER_LIMIT
Date: Fri, 04 Feb 2005 22:35:12 +0100
Message-ID: <4203EA90.6020005@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a machine booting with 2.6.10 not booting any more with 2.6.10-bk7 .

The error during boot is (sorry for the bad formatting):

Executing all Device _STA and_INI methods:.....exoparg2-0436 [14] 
ex_opcode_2A_1T_1R    : Index value (14) beyond end of buffer (14)
  psparse-1138: *** Error: Method execution failed [\STRC] (Node 
ffff8100018b5130), AE_AML_BUFFER_LIMIT psparse-1138: *** Error: Method 
execution failed [\_SB_.PCI0._INI] (Node ffff8100018a00b0), 
AE_AML_BUFFER_LIMIT  nsinit-0414 [06] ns_init_one_device    : 
\_SB_.PCI0._INI._INI failed: AE_AML_BUFFER_LIMIT
...................................................
56 Devices found containing: 56 _STA, 1 _INI methods


The error is thrown in a kind of "strcmp" function \_STRC that compares 
the operating system string:

     Method (STRC, 2, NotSerialized)
     {
         If (LNot (LEqual (SizeOf (Arg0), SizeOf (Arg1))))
         {
             Return (0x00)
         }
         Add (SizeOf (Arg0), 0x01, Local0)
         Name (BUF0, Buffer (Local0) {})
         Name (BUF1, Buffer (Local0) {})
         Store (Arg0, BUF0)
         Store (Arg1, BUF1)
         While (Local0)
         {
             Decrement (Local0)
             If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf 
(Index (BUF1, Local0)))))
             {
                 Return (Zero)
             }
         }
         Return (One)
     }
_______________________________________________________________________

Adding these addtional debug statements:

     Method (STRC, 2, NotSerialized)
     {
         Store (Arg0, Debug)
         Store (Arg1, Debug)
	Store (sizeof(Arg0), Debug)
	Store (sizeof(Arg1), Debug)
         If (LNot (LEqual (SizeOf (Arg0), SizeOf (Arg1))))
         {
             Return (0x00)
         }
         Store ("Strings should have the same size", Debug)
         Add (SizeOf (Arg0), 0x01, Local0)
         Name (BUF0, Buffer (Local0) {})
         Add (SizeOf (Arg1), 0x01, Local0)
         Name (BUF1, Buffer (Local0) {})
         Store (Arg0, BUF0)
         Store (Arg1, BUF1)
         While (Local0)
         {
             Decrement (Local0)
	    Store (Local0, Debug)
             If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf 
(Index (BUF1, Local0)))))
             {
                 Return (Zero)
             }
         }

         Return (One)
     }


Gave me this output:



Completing Region/Field/Buffer/Package 
initialization:........................................................
..............................
Initialized 36/36 Regions 18/18 Fields 19/19 Buffers 13/23 Packages (681 
nodes)
Executing all Device _STA and_INI methods:.....[ACPI Debug] String: 
[0x14] "Microsoft Windows NT"
[ACPI Debug] String: [0x11] "Microsoft Windows"
[ACPI Debug] Integer: 0x00000014
[ACPI Debug] Integer: 0x00000011
[ACPI Debug] String: [0x14] "Microsoft Windows NT"
[ACPI Debug] String: [0x14] "Microsoft Windows NT"
[ACPI Debug] Integer: 0x00000014
[ACPI Debug] Integer: 0x00000014
[ACPI Debug] String: [0x21] "Strings should have the same size"
[ACPI Debug] Integer: 0x00000014
exoparg2-0436 [14] ex_opcode_2A_1T_1R    : Index value (14) beyond end 
of buffer (14)
  psparse-1138: *** Error: Method execution failed [\STRC] (Node 
ffff81001fce5130), AE_AML_BUFFER_LIMIT
  psparse-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] 
(Node ffff81001fcd00b0), AE_AML_BUFFER_LIM
IT
   nsinit-0414 [06] ns_init_one_device    : \_SB_.PCI0._INI._INI failed: 
AE_AML_BUFFER_LIMIT

__________________________________________________________________________

Seems as if accessing BUF0[20] (C style) the kernel thinks the index is 
out of bounds, but it shouldn't ?!?
Is this a regression in the kernel, or was the dsdt code/syntax always 
wrong, but accepted by previous kernels?

Tell me if you need more info.

Thanks,

         Thomas


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
