From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Huu, 2.6.25-rc6 and my battery is gone ...
Date: Thu, 20 Mar 2008 10:49:42 +0100
Message-ID: <200803201049.43600.rjw@sisk.pl>
References: <20080320084239.GB17435@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32963 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbYCTJu0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Mar 2008 05:50:26 -0400
In-Reply-To: <20080320084239.GB17435@gamma.logic.tuwien.ac.at>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Thursday, 20 of March 2008, Norbert Preining wrote:
> Hi all,
> 
> I recently switched from 2.6.25-rc3 to -rc6 and now my battery is gone.
> gnome-power-guru does show permanent AC plugged in, the acpi command
> returns nothing:
> 
> ACPI: AC Adapter [ACAD] (on-line)
> ACPI: Battery Slot [BAT1] (battery absent) PM: Adding info for No Bus:input0
> 
> That did work before.
> 
> Is this a know issue?

Probably.

Please test -rc6-git4 and see if the problem is gone.

Thanks,
Rafael
