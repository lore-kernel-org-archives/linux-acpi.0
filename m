From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of FSC Amilo Pa 2510
Date: Mon, 21 Jan 2008 22:58:38 -0500
Message-ID: <200801212258.38848.lenb@kernel.org>
References: <200708121802.41426.crunchy@bitkipper.net> <200801210011.20057.lenb@kernel.org> <1200942295.26290.169.camel@coin.buesching.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56784 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387AbYAVD64 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 22:58:56 -0500
In-Reply-To: <1200942295.26290.169.camel@coin.buesching.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas =?utf-8?q?B=C3=BCsching?= <crunchy@bitkipper.net>
Cc: linux-acpi@vger.kernel.org

Thanks for the acpidump


                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

LINX is written, but never read --a NOP
TPOS is compared to 0x40 (vista) in the SATA AML,
which OSI(Linux) will break
OSTB is compard to 0x40 (vista), which OSI(Linux) will break,
apparently disabling video notifies.

So I recommend that we continue to disable OSI(Linux) on this
box, unless you find that SATA or the video driver work
better without it.

thanks,
-Len


                    Method (_Q10, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.OSTB, 0x40))
                        {
                            Notify (\_SB.PCI0.AGP.VGA.LCD, 0x86)
                        }
                        Else
                        {
                            If (LLess (\_SB.PCI0.LCDL, 0x07))
                            {
                                Increment (\_SB.PCI0.LCDL)
                                Store (\_SB.PCI0.LCDL, BKLG)
                            }
                        }
                    }
                    Method (_Q11, 0, NotSerialized)
                    {
                        If (LEqual (\_SB.OSTB, 0x40))
                        {
                            Notify (\_SB.PCI0.AGP.VGA.LCD, 0x87)
                        }
                        Else
                        {
                            If (\_SB.PCI0.LCDL)
                            {
                                Decrement (\_SB.PCI0.LCDL)
                                Store (\_SB.PCI0.LCDL, BKLG)
                            }
                        }
                    }
System Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: AMILO Pa 2510
        Version: 20
        Serial Number: 12345678
        UUID: 006581C7-5E2A-DB11-B7FE-D1AD14F053E9
        Wake-up Type: Power Switch
        SKU Number: 12345678
        Family: AMILO

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: F37
