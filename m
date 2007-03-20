From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 21:07:06 -0300
Message-ID: <20070320000706.GE5932@khazad-dum.debian.net>
References: <20070315133900.GC26862@khazad-dum.debian.net> <20070315080644.c73db24a.kristen.c.accardi@intel.com> <20070315175505.GB6596@khazad-dum.debian.net> <20070315110156.09e80b99.kristen.c.accardi@intel.com> <20070315193123.GB14394@khazad-dum.debian.net> <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070318183652.GB29422@khazad-dum.debian.net> <20070319111745.faa38198.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36274 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030778AbXCTAHp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 20:07:45 -0400
Content-Disposition: inline
In-Reply-To: <20070319111745.faa38198.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

On Mon, 19 Mar 2007, Kristen Carlson Accardi wrote:
> > It should work with the generic bay device too, but I have no ideas about
> > dock.  But you'll need to deal with udev with the new bay device, something
> > I am not too happy about.  These things are ACPI events, they should remain
> > so unless all other ACPI events are going to become uevents.
> 
> So ACPI is just a mechanism - an implementation detail in the kernel.  I
> don't think we should have special ACPI events to deal with bay/dock activity.

Well, that's how the userspace power management structure operates right
now.  We can walk away from that, of course, but if we are going to, then
let's do it for the entire set of ACPI events sent to userspace.

In the meanwhile, I would really appreciate a way to hook ibm-acpi into bay
so that I can provide the ACPI events ibm-acpi used to generate... we can
deprecate them and remove them in one year's time, or when the
/proc/acpi/events (and its sysfs counterpart) interface gets removed,
whichever happens first.

> If for whatever reason we ever dock something without using ACPI, we can
> make this transparent to userspace.  

Yes.  But this is also true for battery, thermal notifications,
suspend/resume, and pretty much every ACPI event :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
