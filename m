From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI thermal: Check for thermal zone requiremen
Date: Sat, 20 Feb 2010 11:15:21 +0100
Message-ID: <201002201115.21988.trenn@suse.de>
References: <1266357351-20224-1-git-send-email-trenn@suse.de> <201002191220.56517.trenn@suse.de> <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48673 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab0BTKO1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Feb 2010 05:14:27 -0500
In-Reply-To: <alpine.LFD.2.00.1002191108590.4030@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi,

I haven't seen your post at then end of the mail...

On Friday 19 February 2010 05:20:51 pm Len Brown wrote:
> >
> > Related ASL output:
> >
> >
> > If (_OSI ("Linux"))
> >                 {
> >                     Store (One, LINX)
> >                     Store (0x80, OSTB)
> >                     Store (0x80, TPOS)
> >                 }
> > If (_OSI ("Windows 2006"))
> >                 {
> >                     Store (0x40, OSTB)
> >                     Store (0x40, TPOS)
> >                 }
> >
> > ...
> > Name (TPC, 0x64)
> > Method (_HOT, 0, Serialized)
> > {
> >     If (LEqual (TPOS, 0x40))
> >     {
> >         Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
> >     }
> > }
> >
> > Method (_CRT, 0, Serialized)
> > {
> >     If (LNotEqual (TPOS, 0x40))
> >     {
> >         Return (Add (0x0AAC, Multiply (TPC, 0x0A)))
> >     }
> > }
>
> It appears that if acpi_osi=Linux were set (or TPOS were
> anything other than Windows 2006), then you
> would not get a _HOT or _CRT in this TZ.
> I don't understand how that is related to this issue,
> as acpi_osi=Linux is not set, right?
>
> acpi_osi="Windows 2006", on the other hand, should be set.
> In that case the AML will return a valid trip point for
> both _HOT and _CRT, yes?  So what is the problem?
The problem is that in:
      - _HOT it's a LEqual (TPOS, 0x40)
      - _CRT it's a LNotEqual (TPOS, 0x40)

You will get a valid hot tp on Windows 2006 (or newer) and an invalid critical 
one.
On all others you get an invalid hot, but a valid critical tp (which is also 
the case with osi=Linux).

      Thomas
