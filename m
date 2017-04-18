From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Export mutex functions
Date: Tue, 18 Apr 2017 16:07:59 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E593908@ORSMSX110.amr.corp.intel.com>
References: <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE93F83@SHSMSX101.ccr.corp.intel.com>
 <03d661cb-a561-cfce-2c0e-f81ff73e6653@roeck-us.net>
 <1773950.yRmmpX2ztC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16868 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757452AbdDRQID (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 12:08:03 -0400
In-Reply-To: <1773950.yRmmpX2ztC@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Guenter Roeck <linux@roeck-us.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Box, David E" <david.e.box@intel.com>



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Tuesday, April 18, 2017 7:15 AM
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: Zheng, Lv <lv.zheng@intel.com>; Rafael J. Wysocki
> <rafael@kernel.org>; Moore, Robert <robert.moore@intel.com>; Wysocki,
> Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>;
> linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org; Box, David E <david.e.box@intel.com>
> Subject: Re: [PATCH] ACPICA: Export mutex functions
> 
> On Tuesday, April 18, 2017 06:50:26 AM Guenter Roeck wrote:
> > On 04/18/2017 12:14 AM, Zheng, Lv wrote:
> > > Hi,
> 
> [cut]
> 
> > >
> > > Maybe I should provide more detailed examples for this solution.
> > >
> > > For example:
> > > OperationRegion (SIOT, SuperIOAddressSpace, Zero, 100) Field (SIOT,
> > > ByteAcc, Lock, Preserve) {
> > >     FNC1, 8,
> > >     FNC2, 8,
> > >     ...
> > > }
> > >
> > > Acquire (MUX0)
> > > Store (0, FNC1)
> > > Release (MUX0)
> > >
> > > Then you can call (let me use casual pseudo code)
> > > acpi_install_operation_region(SuperIOAddressSpace,
> superio_opregion_handler) from OS side.
> > > In its callback superio_opregion_handler(), you can:
> > >
> > > superio_enter();
> > > If (address == 0) {
> > >    /* mean FNC1 */
> > >    Perform the locked superior accesses } else if (address == 1) {
> > >    /* mean FNC2 */
> > >    Perform the locked superior accesses } superio_exit();
> > >
> > > Are there similar approach in your DSDT?
> > >
> >
> > Some snippets from the DSDT:
> >
> > 	Device (SIO1)
> >             {
> >          	Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard
> Resources */)  // _HID: Hardware ID
> >          	Name (_UID, Zero)  // _UID: Unique ID
> > 		...
> > 		Mutex (MUT0, 0x00)
> > 		Method (ENFG, 1, NotSerialized)
> >                      {
> >                          Acquire (MUT0, 0x0FFF)
> >                          INDX = 0x87
> >                          INDX = One
> >                          INDX = 0x55
> >                          If ((SP1O == 0x2E))
> >                          {
> >                              INDX = 0x55
> >                          }
> >                          Else
> >                          {
> >                              INDX = 0xAA
> >                          }
> >
> >                          LDN = Arg0
> >                      }
> >
> >                      Method (EXFG, 0, NotSerialized)
> >                      {
> >                          INDX = 0x02
> >                          DATA = 0x02
> >                          Release (MUT0)
> >                      }
> >
> > 		    OperationRegion (IOID, SystemIO, SP1O, 0x02)	/* SP1O
> is 0x2e */
> >                      Field (IOID, ByteAcc, NoLock, Preserve)
> >                      {
> >                          INDX,   8,
> >                          DATA,   8
> >                      }
> > 		    ...
> >
> > Example for use:
> > 		Method (DCNT, 2, NotSerialized)
> >                      {
> >                          ENFG (CGLD (Arg0))
> >                          If (((DMCH < 0x04) && ((Local1 = (DMCH &
> 0x03)) != Zero)))
> >                          {
> >                              RDMA (Arg0, Arg1, Local1++)
> >                          }
> >
> >                          ACTR = Arg1
> >                          Local1 = (IOAH << 0x08)
> >                          Local1 |= IOAL
> >                          RRIO (Arg0, Arg1, Local1, 0x08)
> >                          EXFG ()
> >                      }
> >
> > Can there be more than one address space handler for a given region ?
> > Each driver accessing the resource would need that handler.
> 
> Rather, every driver accessing the resource would need to be aware of
> the existence of the operation region handler and would need to use the
> mutual exclusion mechanism used by that handler, if my understanding
> here is correct.
> 
> The existence of an operation region for a specific section of address
> space is a declaration that AML is going to access locations in that
> section.  It allows the OS to install a handler for that region to
> intercept AML accesses and do what it likes with them.
> 
> Thanks,
> Rafael

Yes, agreed.
Bob

