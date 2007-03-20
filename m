From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] CONFIG_IBM_BAY
Date: Mon, 19 Mar 2007 21:12:40 -0300
Message-ID: <20070320001240.GF5932@khazad-dum.debian.net>
References: <20070315125037.3e82e0c4.kristen.c.accardi@intel.com> <45FCD062.3050001@gmail.com> <20070318082751.GA28591@homac2> <20070319132243.GA2869@srcf.ucam.org> <20070319134822.GA4885@homac2.suse.de> <20070319140403.GA3697@srcf.ucam.org> <20070319143746.GC4885@homac2.suse.de> <20070319111109.1a62740b.kristen.c.accardi@intel.com> <20070319231119.GB5932@khazad-dum.debian.net> <20070319165634.2f2f380c.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35982 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030768AbXCTAMy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 20:12:54 -0400
Content-Disposition: inline
In-Reply-To: <20070319165634.2f2f380c.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Holger Macht <hmacht@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Len Brown <lenb@kernel.org>

On Mon, 19 Mar 2007, Kristen Carlson Accardi wrote:
> Is this what you had in mind?  (Warning - I didn't test this).
> 
> 
> Allow the driver to be loaded with an option that will allow userspace to
> control whether the laptop is ejected immediately when the user presses the
> button, or only when the syfs undock file is written.  
> 
> if immediate_undock == 1, then when the user presses the undock button, the
> laptop will send an event to userspace to notify userspace of the undock, but
> then immediately undock without waiting for userspace.  This is the current
> behavior, and I set this to be the default.
> 
> if immediate_undock == 0, then when the user presses the undock button, the
> laptop will send an event to userspace and do nothing.  User space can query
> the "flags" sysfs entry to determine if an undock request has been made by
> the user (if bit 1 is set).  User space will then need to write the undock 
> sysfs entry to complete the undocking process.

Yes, that's it exactly.  I didn't try to test it, as I don't have a dock,
but the above describes what I wanted, indeed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
