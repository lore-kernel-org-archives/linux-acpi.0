From: Ramon Casellas <casellas-Ps1RxedxAdk/xqpuW5qSgA@public.gmane.org>
Subject: Thinkpad ACPI blues... getting better
Date: Sun, 5 Oct 2003 14:25:53 +0200 (MEST)
Sender: linux-thinkpad-admin-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
Message-ID: <Pine.SOL.4.40.0310051411450.26646-100000@gervaise.enst.fr>
Reply-To: linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-thinkpad-admin-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org>
Errors-To: linux-thinkpad-admin-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
List-Help: <mailto:linux-thinkpad-request-l7BEYHA5S10i5T99jlK1SuPq5ANwx5YgaFUAG64dwko@public.gmane.org>
List-Post: <mailto:linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request-l7BEYHA5S10i5T99jlK1SuPq5ANwx5Yg+iqrErVy8Mf2+df2TVCvIA@public.gmane.org>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request-l7BEYHA5S10i5T99jlK1SuPq5ANwx5Ygv5P9MsFVvkkBB/WhxxnpHQ@public.gmane.org>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org
Cc: Linux on Thnkpad X31 <linux31-+jrgr4Rcu/Jg9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi all,

I'm a happy owner of an IBM Thinkpad X.31 (with latest 2.01a BIOS),
currently running either 2.4.22pre6 or 2.6.0-test6-mm4 depending on the
moon phase. I've had a love-hate relationship with ACPI, and fortunatly it
looks like recent versions (20030918) are getting better and work (swsusp,
hibernate, etc, are other related problems...).

However, when booting either kernel, I got:
Linux gandalf 2.6.0-test6-mm4 #1 Sun Oct 5 11:46:17 CEST 2003 i686
Intel(R) Pentium(R) M processor 1400MHz GenuineIntel GNU/Linux
gandalf casellas$ dmesg | grep ACPI
 BIOS-e820: 000000003ff60000 - 000000003ff78000 (ACPI data)
 BIOS-e820: 000000003ff78000 - 000000003ff7a000 (ACPI NVS)
 user: 000000003ff60000 - 000000003ff78000 (ACPI data)
 user: 000000003ff78000 - 000000003ff7a000 (ACPI NVS)
ACPI: RSDP (v002 IBM                                       ) @ 0x000f6b40
ACPI: XSDT (v001 IBM    TP-1Q    0x00002011  LTP 0x00000000) @ 0x3ff6b67d
ACPI: FADT (v003 IBM    TP-1Q    0x00002011 IBM  0x00000001) @ 0x3ff6b700
ACPI: SSDT (v001 IBM    TP-1Q    0x00002011 MSFT 0x0100000e) @ 0x3ff6b8b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00002011 IBM  0x00000001) @ 0x3ff77e0c
ACPI: TCPA (v001 IBM    TP-1Q    0x00002011 PTL  0x00000001) @ 0x3ff77e5e
ACPI: BOOT (v001 IBM    TP-1Q    0x00002011  LTP 0x00000001) @ 0x3ff77fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00002011 MSFT 0x0100000e) @ 0x00000000
ACPI: Subsystem revision 20030918
ACPI: Found ECDT
    ACPI-0165: *** Warning: The ACPI AML in your computer contains errors,
please nag the manufacturer to correct it.
******************************************
    ACPI-0168: *** Warning: Allowing relaxed access to fields; turn on
CONFIG_ACPI_DEBUG for details.
ACPI: Interpreter enabled


I know I can always path the DSDT table, but it is a painful process,
since there is no simple way (read "oneliner") in the official mainstream
kernels (I really like the initrd way to do that!)

So my question is : Who should I nag? I assume there must be people from
IBM that watch these mailing lists. I also know that IBM does not
officially support Linux on thinkpads (which is unfortunate, given their
other great contributions to Linux)...


I've though of some "IBM fix ACPI in BIOS petition online" process. What
do you think? Would you support such an initiative? In that case, we could
turn on "ACPI debug messages" for different thinkpad models and send a big
fat full report detailing which operation regions are not ok, missing
return values, etc.

Am I being too optimistic/idealist here? Has this been tried before with
no success?

Best regards,

R.


// --------------------------------------------------------
// Ramon Casellas 		GET/ENST/INFRES/RHD/C206


-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
