From: Thomas Renninger <trenn@suse.de>
Subject: Re: hwapci-0142 error
Date: Thu, 24 Jul 2008 09:49:11 +0200
Message-ID: <200807240949.11306.trenn@suse.de>
References: <20080720001417.GA22429@eorbit.net> <200807231256.05113.trenn@suse.de> <20080723231734.GA29832@eorbit.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:48028 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbYGXIWq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Jul 2008 04:22:46 -0400
In-Reply-To: <20080723231734.GA29832@eorbit.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Collins <chris@eorbit.net>
Cc: linux-acpi@vger.kernel.org

On Thursday 24 July 2008 01:17:34 am Chris Collins wrote:
> Hello,
>
> On Wed, Jul 23, 2008 at 12:56:04PM +0200, Thomas Renninger wrote:
> > This machine/BIOS is rather old?
> > You should better stay with ACPI switched off.
>
> I believe there are no newer updates for this BIOS.
>
> I will try to test this with a Windows installation.
> Is it the case that this BIOS which clearly has
> some kind of an ACPI capability should be written off.
>
> How can I test the capabilities, or seek help in
> solving of the kinks or idiosyncrasies of this
> BIOS.  Is Award/Phoenix represented on this forum?
> Do they support the work of making ACPI function
> on Linux?

We blacklist BIOSes by year to either take ACPI or not even they claim to 
support it. 2000 should be on the edge.
Depending on the vendor (and where he gets his BIOS from) there might already 
be ACPI capabilities in the BIOS.
Whether the vendor decided to use it or to still do all the QA and testing and 
fixups on the legacy BIOS parts or the ACPI ones cannot be detected 
automatically.

The idea from Zhao to try out Windows is a good one.
If Windows is running in ACPI mode you have good chances to get this working 
on Linux also.

But as the mode switching itself does not work...

Good luck,

        Thomas
