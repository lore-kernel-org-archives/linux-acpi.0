From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: ACPI / dock: ThinkPad X220: \_SB_.PCI0.LPC_.EC__.BAT1: Unable
 to dock!
Date: Wed, 13 Aug 2014 13:49:10 +0200
Message-ID: <1407930550.27564.4.camel@x220>
References: <1406670374.2406.27.camel@x220>
	 <1589104.UMXrnXY9GI@vostro.rjw.lan> <1407923335.2121.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:54780 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751557AbaHMLtM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Aug 2014 07:49:12 -0400
In-Reply-To: <1407923335.2121.27.camel@x220>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Rubin Abdi <rubin@starset.net>, linux-acpi@vger.kernel.org, linux-thinkpad@linux-thinkpad.org

On Wed, 2014-08-13 at 11:48 +0200, Paul Bolle wrote:
> - XB1S is apparently 0x00 at first resume (I don't know how that
>   happens);

Perhaps because this battery's _EJ0 method was evaluated previously
(say, during suspend):
DefinitionBlock ("dsdt.aml", "DSDT", 1, "LENOVO", "TP-8D   ", 0x00001390)
{
    Scope (\_SB)
    {
        Device (PCI0)
        {
            Device (LPC)
            {
                Device (EC)
                {
                    Device (BAT1)
                    {
                        Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                        {
                            If (Arg0)
                            {
                                [...]
                                Store (0x00, XB1S) /* \_SB_.PCI0.LPC_.EC__.BAT1.XB1S */
                            }
                        }
                    }
                }
            }
        }
    }
}

But I don't know whether that _EJ0 method is actually evaluated during
the first boot and suspend cycle.


Paul Bolle

