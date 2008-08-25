From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS provides one
Date: Mon, 25 Aug 2008 12:48:30 +0200
Message-ID: <200808251248.31786.trenn@suse.de>
References: <20080821174852.0689681d@hyperion.delvare> <200808250020.41626.trenn@suse.de> <1219630502.24775.35.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:35936 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbYHYKse (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Aug 2008 06:48:34 -0400
In-Reply-To: <1219630502.24775.35.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: khali@linux-fr.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, robert.moore@intel.com, lm-sensors@lm-sensors.org

On Monday 25 August 2008 04:15:02 Zhang Rui wrote:
> On Mon, 2008-08-25 at 06:20 +0800, Thomas Renninger wrote:
> > On Monday 25 August 2008 12:11:37 am Thomas Renninger wrote:
> > > On a HP tx2500z laptop one thermal device provides this function:
> > >             Name (REGN, "Processor Thermal Zone")
> >
> > I wonder what we can do to get this added to the ACPI spec or to make
> > vendors use the same function for this.
> >
> > What about trying for above "REGN" as it already exists on HPs.
> > Also try for _NAM (or similar), document that we do this and tell
> > vendors that it's a good thing to provide a sane string/name for
> > thermal_zones on Linux.
> >
> > On ACPI everything that does not start with "_" means unspecified
> > and the function should only be used internally and not by the OS...
>
> Sounds good. But I guess it's not easy to push this the vendors, is it?
At least this is a really easy thing for them to add.

I wonder how localization should work here. One does not want to add
the description of the thermal zone in all possibly supported languages
into BIOS ROM.

Pre-defining 10 different areas:
  0 Processor
  1 Memory
  2 Disk
  3 Graphics card
  4 ...
 10 Others

and then returning an integer value sounds more sane.
If Len or Bob say it makes sense to come up with or add something which
we can tell the vendors to use and which may find its way to a later Spec
version...

After first being excited that HP provided a sane description of a thermal
zone, I think it's not worth adding this right now (or is it?).

      Thomas

PS: Forgot to add lm-sensors list, adding them now.
