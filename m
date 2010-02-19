From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Fri, 19 Feb 2010 12:20:56 +0100
Message-ID: <201002191220.56517.trenn@suse.de>
References: <1266357351-20224-1-git-send-email-trenn@suse.de> <1266357351-20224-2-git-send-email-trenn@suse.de> <alpine.LFD.2.00.1002190138310.24628@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41251 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab0BSLU6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Feb 2010 06:20:58 -0500
In-Reply-To: <alpine.LFD.2.00.1002190138310.24628@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Friday 19 February 2010 07:39:43 Len Brown wrote:
> Thomas,
> 
> What good things happen after this patch that didn't happen before it?

The guy sees a valid temperature, in /proc-/sys and also in the
corresponding X-apps (which his original complaints were).

The thermal zone has a valid passive trip point (95 C), which now is 
active again.

He reported this as a regression, let me double check:

Oh dear..., _CRT doesn't return anything for Windows 2006
(or newer, not defined Windowses) -> broken trip point.

There is a Linux workaround (which does not work anymore,
this probably was the reason for the regression -> OSI!=Linux),
which make _CRT return a valid trip point like on old Windowses.

So this makes the behavior more "latest Windows OS" like.
Hmm, depends whether Windows still takes the thermal zone into
account if _CRT is not available or invalid.
The fact that a valid _HOT trip point is only exported on latest
Windowses, hardens the guess that Windows also serves this
thermal zone with an invalid critical trip point.
It looks like the (TPOS == 0x40) thermal workarounds wants to avoid
thermal shutdowns (critical) in case 100 C are reached and change it
into a (debug?) message (_HOT) on latest Windowses.

   Thomas

Related ASL output:


If (_OSI ("Linux"))
                {
                    Store (One, LINX)
                    Store (0x80, OSTB)
                    Store (0x80, TPOS)
                }
If (_OSI ("Windows 2006"))
                {
                    Store (0x40, OSTB)
                    Store (0x40, TPOS)
                }

...
Name (TPC, 0x64)
Method (_HOT, 0, Serialized)
{
    If (LEqual (TPOS, 0x40))
    {
        Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
    }
}

Method (_CRT, 0, Serialized)
{
    If (LNotEqual (TPOS, 0x40))
    {
        Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
    }
}

