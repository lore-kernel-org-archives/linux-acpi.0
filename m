From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Probably wrong temparature for thermal zone on HP DL380 G7
 server
Date: Mon, 4 Apr 2011 16:04:33 +0100
Message-ID: <20110404150433.GA19455@srcf.ucam.org>
References: <4D99F1D8020000A100005903@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40133 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab1DDPEi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Apr 2011 11:04:38 -0400
Content-Disposition: inline
In-Reply-To: <4D99F1D8020000A100005903@gwsmtp1.uni-regensburg.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-acpi@vger.kernel.org

On Mon, Apr 04, 2011 at 04:29:12PM +0200, Ulrich Windl wrote:

> No support for device type: battery
>      Thermal 1: ok, 8.0 degrees C
> No support for device type: ac_adapter

>From the DSDT on a DL580 G7:

    Scope (_TZ)
    {
        Name (\TEMP, 0x0AFF)
...
           Method (_TMP, 0, NotSerialized)
            {
                Store ("_TMP Method", Debug)
                Return (TEMP)
            }

And there's nothing else that touches TEMP (there's a different TEMP in 
the CPU setup tables, but they're in different namespaces). So _TMP 
always returns 0x0AFF, which is 2815, which is 281.5 kelvin, which is 
8.3 degrees C.

Looks like a BIOS bug.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
