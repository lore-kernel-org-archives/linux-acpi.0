From: ael <law_ence.dev@ntlworld.com>
Subject: power down regression: 2.6.18-rc5 against 2.6.18-rc4 on i386,  82371AB/EB/MB
 PIIX4
Date: Fri, 01 Sep 2006 16:41:54 +0100
Message-ID: <44F854C2.50607@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:17182 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751637AbWIAPmA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Sep 2006 11:42:00 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060901154159.TLIJ27023.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Sep 2006 16:41:59 +0100
Received: from [192.168.0.3] (really [86.3.128.127])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060901154158.EIMW644.aamtaout01-winn.ispmail.ntl.com@[192.168.0.3]>
          for <linux-acpi@vger.kernel.org>; Fri, 1 Sep 2006 16:41:58 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On 2.6.18-rc4 and all earlier versions, power-down is called when the
system is shutdown: the last message on screen is Power down & shutdown.

On 2.6.18-rc5, there is no call to power down: the last message is
"System Halted" and power remains on.

==========================================================================

i386 architecture, 440BX chipset:

---------------------------------------------------------------------
lspci:
=====
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
Host bridge (rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX
AGP bridge (rev 02)
0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE
(rev 01)
0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB
(rev 01)
0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:08.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
(rev 01)
0000:00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX
(rev 20)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200
AGP (rev 01)
-------------------------------------------------------------------------

2.6.18-rc5 compiled with this .config:

http://homepage.ntlworld.com/lawrence_a_e/config_2.6.18-rc5

Above has no significant difference from .config used for 2.6.18-rc4:

---------------------------------------------------------------
$ diff linux-2.6.18-rc4/.config linux-2.6.18-rc5/.config
3,4c3,4
< # Linux kernel version: 2.6.18-rc4
< # Mon Aug 28 11:33:37 2006
---
> # Linux kernel version: 2.6.18-rc5
> # Thu Aug 31 19:50:52 2006
809a810
> # CONFIG_FIXED_PHY is not set
----------------------------------------------------------------

(Setting acpi debug has no effect even on screen.)

------------------------------------------------------------------------------
$ gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)

------------------------------------------------------------------------------

/proc/cpuinfo:-
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 300.045
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat p
se36 mmx fxsr
bogomips        : 600.69
----------------------------------------------------------------------------------------------

Adrian Lawrence.

