From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] [RESUBMIT] Fix mute key on older Lenovo made Thinkpads by
 OSI blacklisting
Date: Thu, 20 May 2010 01:48:17 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005200136220.2921@localhost.localdomain>
References: <1272770432.15493.49.camel@laptop>
 <alpine.LFD.2.00.1005192325470.2921@localhost.localdomain>
 <1274329374.4479.403.camel@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:39917 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab0ETFsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 01:48:23 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P00DREESIT622@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 00:48:21 -0500 (CDT)
In-reply-to: <1274329374.4479.403.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

thanks for the DSDT for the x200 and x301.
In these two cases, the OSI(Linux) workaround looks isolated,
and thus relatively safe.

I've applied your patch to the ACPI test branch, and I'm inclined to
push it with 2.6.35 with the justification that it is consistent
with our current DMI entries to fix thinkpad mute button on other 
models.

Matthew, Henrique,
If you'd like to talk me out of this, now is your chance:-)

thanks,
Len Brown, Intel Open Source Technology Center

Both the x200 and x301 DSDT do this:

              If (CondRefOf (\_OSI, Local0))
                {
                    If (\_OSI ("Windows 2001"))
                    {
                        Store (0x01, \WNTF)
                        Store (0x01, \WXPF)
                        Store (0x00, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP1"))
                    {
                        Store (0x01, \WSPV)
                    }

                    If (\_OSI ("Windows 2001 SP2"))
                    {
                        Store (0x02, \WSPV)
                    }

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x01, \WVIS)
                    }

                    If (\_OSI ("Windows 2009"))
                    {
                        Store (0x01, \WIN7)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, \LNUX)
                    }

The important thing here is that OSI(Linux)
doesn't disable any of the windows compatibility
flags above as it does in some other DSDTs.

                    If (\_OSI ("FreeBSD"))
                    {
                        Store (0x01, \LNUX)
                    }


and this _INI-time check is the only effect of LNUX:

            If (\LNUX)
            {
                \_SB.PCI0.LPC.EC.SAUM (0x02)
                \UCMS (0x1C)
            }

Of course SAUM pokes the EC and UCMS is an SMI wrapper,
so we don't really know all they may do; but at least
OSI(Linux) doesn't obviously disable the concept of
windows compatibility in this BIOS, and checks for
LNUX are limited to init-time.


