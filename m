From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 09:16:07 +0800
Message-ID: <1237425368.3640.61.camel@localhost.localdomain>
References: <1237365385.3640.43.camel@localhost.localdomain>
	 <20090318134153.GA28461@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36962 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532AbZCSBPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 21:15:06 -0400
In-Reply-To: <20090318134153.GA28461@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-03-18 at 21:41 +0800, Matthew Garrett wrote:
> On Wed, Mar 18, 2009 at 04:36:25PM +0800, yakui_zhao wrote:
> > Subject: ACPI: Add the Pansonic CF51 box to the dmi check table
> > From: Zhao Yakui <yakui.zhao@intel.com>
> > 
> > The Pansonic CF51-2L box can't be resumed if the boot option of
> > "acpi_sleep=old_ordering" is not added.
> 
> Do we have any idea what's going on here, yet?
>  Several of the machines 
> on this blacklist are modern, so it's not a workaround for ancient 
> hardware.
Now we have no idea how the behaviour is changed with the boot option.
In fact the boot option is useful for all the boxes that can't be
resumed unless it is added. 

Although the machine is modern, the ACPI 1.0 is followed on this box.
Without the boot option of "acpi_sleep=old_ordering", it can't be
resumed from S3 correctly. But after adding the boot option, the box can
be resumed. 
      
> 

