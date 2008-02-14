From: Len Brown <lenb@kernel.org>
Subject: Re: dmi info requested... - Dell - Precision WorkStation 690
Date: Wed, 13 Feb 2008 23:26:22 -0500
Message-ID: <200802132326.22597.lenb@kernel.org>
References: <47B0FA26.4010302@tlinx.org> <200802122321.50524.lenb@kernel.org> <47B299B5.4040002@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59305 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650AbYBNE05 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 23:26:57 -0500
In-Reply-To: <47B299B5.4040002@tlinx.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Walsh <acpi@tlinx.org>
Cc: linux-acpi@vger.kernel.org

Thanks for the acpidump.

It looks a lot like the Dell Precision M4300, but slightly simpler.

ISLI returns 1 for OSI(Linux). 0 for everything else.
GUSB is the only invocation of ISLI.

GUSB is invoked only on USB _INI, and on wakeup from hibernate.

So... If you notice any difference in USB function either
upon boot or resume from hibernate when using acpi_osi=Linux,
please let let us know.

thanks,
-Len


        Method (ISLI, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Return (One)
                }
                Else
                {
                    Return (Zero)
                }
            }
            Else
            {
                Return (Zero)
            }
        }
...
    Method (GUSB, 0, NotSerialized)
    {
        If (ISLI ())
        {
            Return (Zero)
# OSI(Linux)
        }
        Else
        {
# else
            Return (SMI2 (0xBA))
        }
    }
