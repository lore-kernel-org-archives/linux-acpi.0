From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 0/3] acpi/pmic: add opregion driver for Intel BXT
 WhiskeyCove PMIC
Date: Thu, 23 Jun 2016 16:16:41 +0300
Message-ID: <20160623131641.GF27263@kuha.fi.intel.com>
References: <20160623075515.GB239751@worksta>
 <CAJZ5v0j1M2X-ygZgmbO3ebbT3d9RQ2h6DRYjs4NK5vROQDHFqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36204 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcFWNRs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 09:17:48 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j1M2X-ygZgmbO3ebbT3d9RQ2h6DRYjs4NK5vROQDHFqQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bin Gao <bin.gao@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>, Felipe Balbi <felipe.balbi@linux.intel.com>

On Thu, Jun 23, 2016 at 03:03:34PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2016 at 9:55 AM, Bin Gao <bin.gao@linux.intel.com> wrote:
> > This series modifies the pen function signature to take bit field
> > and adds a new opregion driver for Intel BXT WhiskeyCove PMIC. It
> > also adds support for PMIC regs operation region.
> >
> > Yegnesh Iyer (1):
> >   acpi: pmic: Modifying the pen function signature to take bit field
> >
> > Ajay Thomas (1):
> >   acpi: pmic: Add opregion driver for Intel BXT WhiskeyCove PMIC
> 
> I've just applied the above two patches from the previous series.  Are
> there any changes to them here?
> 
> > Chandra Sekhar Anagani (1):
> >  acpi: pmic: Add support for PMIC regs operation region
> 
> That's a new one I suppose?
> 
> How is this related to http://marc.info/?l=linux-acpi&m=146660742815070&w=2 ?

Looks the like same to me.. Just ignore the one I send then. Sorry,
there seems to have been a miscommunication somewhere.


Thanks,

-- 
heikki
