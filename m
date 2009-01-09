From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Fri, 9 Jan 2009 13:16:15 +0100
Message-ID: <200901091316.16334.trenn@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901091154.43606.trenn@suse.de> <alpine.LFD.2.00.0901090556360.4091@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:37453 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZAIMQS (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 07:16:18 -0500
In-Reply-To: <alpine.LFD.2.00.0901090556360.4091@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Friday 09 January 2009 11:59:28 Len Brown wrote:
> > > >    In such case the boot option of "acpi=rsdt" is provided so that
> > > > RSDT is tried instead of XSDT table when the system can't work well.
> >
> > Great, now we still need a dmi blacklist with machines which are known
> > broken. Then we are at the patchset I posted about a year ago -> scnr.
> >
> > I am going to post the missing two patches to make R40e and R50e work.
>
> please do not.
>
> this option is just for manual debugging.
> as i wrote when i nacked your original series,
> the object should be to figure out which path to take w/o using dmi.

It's not possible (maybe someone has an idea, there wasn't any yet).
Either you always use it or not, you cannot check for much, because it is
too early.
If it's always used, I expect it's not the RSDT that should be taken, but
the 32 bit addresses of the RSDT/XSDT.

IMO this cannot generally be done, because chances are high that machines
which do not support Windows likely will break.
Chances are high that a machine which does not support Windows uses 64 bit
addresses and leaves the 32 bit ones uninitialized, a spec valid configuration 
which will then break.

Also: Until the object (figure out which path to take w/o using dmi) is
achieved, these machines should work properly, right?
This task seem to not be easy and unsuccessfully took several kernel 
iterations already,
So why can't these simple patches just be added and the machines be fixed 
until eventually at some time this will generally be fixed?

     Thomas
