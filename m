From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: Oops when removing button and asus_acpi modules
Date: Sun, 13 May 2007 09:32:23 +0200
Message-ID: <4646BF07.1020603@wpkg.org>
References: <46461602.3040503@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.syneticon.net ([213.239.212.131]:44909 "EHLO
	mail2.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbXEMHcp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 May 2007 03:32:45 -0400
In-Reply-To: <46461602.3040503@wpkg.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, paul.s.diefenbaugh@intel.com, julien.lerouge@m4x.org, sziwan@hell.org.pl

Tomasz Chmielewski schrieb:
> I have a kernel OOPS when I remove button and/or asus_acpi modules on 
> 2.6.21.1 kernel.

Here's my lspci, if anyone is interested:


# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] 
Host Bridge (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 78)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1)


-- 
Tomasz Chmielewski
http://wpkg.org
