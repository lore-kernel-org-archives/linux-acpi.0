From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Acer TM3012
Date: Mon, 21 Jan 2008 13:12:32 -0500
Message-ID: <200801211312.32835.lenb@kernel.org>
References: <20080119132321.GC3262@gamma.logic.tuwien.ac.at> <200801201827.12708.lenb@kernel.org> <20080121073910.GA20698@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41275 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbYAUSMw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 13:12:52 -0500
In-Reply-To: <20080121073910.GA20698@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org


> > can you send me the acpidump so I can figure out how to set the DMI entry?

thanks for the acpidump.
Like other Acers, acpi_osi=Linux sets OSYS=0x03E8,
a value which no AML code checks for.  But it prevents
the settings for Windows, thus disabling all the (tested) paths
that Windows takes through the BIOS.

This includes a bunch of hooks in docking, device power management,
and who-knows-what 2nd-order hooks througout their 8000 line BIOS.

Unless comebody can show that acpi_osi=Linux specifically helps
some Linux functionality, there is a strong case to keep
it disabled by default on this Acer, and all Acers.

thanks,
-Len



            Store (0x07D0, OSYS)
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }
                Else
                {
                    Store (0x07D1, OSYS)
                    If (_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x07D2, OSYS)
                    }

                    If (_OSI ("Windows 2006"))
                    {
                        Store (0x07D6, OSYS)
                    }

                    If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
                    {
                        TRAP (0x3D)
                    }
                }
            }
            If (LGreaterEqual (OSYS, 0x07D0))
            {
                Store (0x01, PRM0)
                If (LGreaterEqual (OSYS, 0x07D1))
                {
                    Store (0x03, PRM0)
                }
            }
            Else
            {
                Store (0x00, PRM0)
            }
