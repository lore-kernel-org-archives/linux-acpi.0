From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [2/2] ACPI: report "Module Device" support via _OSI
Date: Thu, 20 Apr 2006 08:42:05 -0600
Message-ID: <200604200842.05123.bjorn.helgaas@hp.com>
References: <200604181558.55296.bjorn.helgaas@hp.com> <200604191022.05016.bjorn.helgaas@hp.com> <44474758.6000208@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:31117 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750798AbWDTOmO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Apr 2006 10:42:14 -0400
In-Reply-To: <44474758.6000208@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>, "Moore, Robert" <robert.moore@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>, Motoyuki Ito <motoyuki@soft.fujitsu.com>

On Thursday 20 April 2006 02:33, Kenji Kaneshige wrote:
> Bjorn Helgaas wrote:
> > On Wednesday 19 April 2006 00:34, Kenji Kaneshige wrote:
> > 
> >>I have a question. The ACPI container driver can be build as a
> >>kernel module. Should _OSI("Module Device") returns TRUE even
> >>when container driver module is not loaded? (Typically, _OSI is
> >>evaluated at _INI time, I think. So container driver module is
> >>not loaded at _OSI("Module Device") time anyway.)
> > 
> > 
> > Good question.  I think _OSI("Module Device") should return
> > true even if the container driver isn't loaded.
> > 
> > Do you think that's a bad idea?
> > 
> > I think it's OK if the namespace contains container devices
> > that we ignore until the driver is loaded.  Someday, the
> > presence of those devices should be enough to cause udev
> > to load the driver automatically.  But for now, I think we
> > have to do it manually.
> >
> 
> I see. I think you are right.
> 
> But now, I'm wondering why ACPI firmware needs _OSI("Module
> Device") because I think module devices in the namespace will
> be ignored by the OS if it doesn't support "Module Device"...

I think the intent is that firmware might choose to expose
some devices differently (either using module devices or
not) depending on whether the OS supports module devices.
I guess the firmware might use the result of _OSI("Module
Device") to decide which table to load.
