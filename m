From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] acpi: check the online state of all children in container
Date: Wed, 22 Mar 2017 11:01:18 +0800
Message-ID: <20170322030118.GD20835@linux-l9pv.suse>
References: <20170322010148.32675-1-jlee@suse.com>
 <4105478.B7tRAuaXDe@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:36700 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758669AbdCVDWn (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Tue, 21 Mar 2017 23:22:43 -0400
Content-Disposition: inline
In-Reply-To: <4105478.B7tRAuaXDe@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Mar 22, 2017 at 01:58:30AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 22, 2017 09:01:48 AM Lee, Chun-Yi wrote:
> > Just checking the state of container is not enough to confirm that
> > the whole container is offlined.
> 
> And why is that so?
>

Actually there does not have real kernel issue triggered by this code now.
I reviewed code and found the difference between acpi_container_offline().

Considering a container that it includes devices and sub-containers
like this:

Scope (_SB)
    Device (MODU)
	Name (_HID, "ACPI0004")		<===  main-container
        Device (PCIE)
		Name (_HID, EisaId ("PNP0A08"))
        Device (SUBM)
            	Name (_HID, "ACPI0004")		<=== sub-container
		Device (MEM0)
			Name (_HID, EisaId ("PNP0C80"))
	...

The original code checks the physical nodes on the main container but
doesn't check children's physical nodes. So, it may happen the sub-container
didn't offline but the offline checking of main container is pass. 

Please kindly direct me if I misunderstood or missed any detail in the codes
about physcial node and container offline.

Thank a lot!
Joey Lee
