From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 02/27] ACPICA: Utilities: Deploy ACPI_DEBUGGER_EXEC for
 ACPI_DEBUGGER enabled code in utglobal.c.
Date: Tue, 6 May 2014 13:54:53 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880255A0E9@SHSMSX101.ccr.corp.intel.com>
References: <cover.1398817612.git.lv.zheng@intel.com>
 <53dbe352c16de24ea99d00af21eb01750af90074.1398817612.git.lv.zheng@intel.com>
 <20140506075353.GA20931@xo-6d-61-c0.localdomain>
 <1AE640813FDE7649BE1B193DEA596E880255A03B@SHSMSX101.ccr.corp.intel.com>
 <20140506110826.GB7089@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140506110826.GB7089@amd.pavel.ucw.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi,

> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Tuesday, May 06, 2014 7:08 PM
> 
> Hi!
> 
> > > From: Pavel Machek [mailto:pavel@ucw.cz]
> > > Sent: Tuesday, May 06, 2014 3:54 PM
> > >
> > > On Wed 2014-04-30 10:03:39, Lv Zheng wrote:
> > > > This patch deploys ACPI_DEBUGGER_EXEC usage to utglobal.c to reduce "ifdef"
> > > > of ACPI_DEBUGGER.  No functional changes.  Lv Zheng.
> > > >
> > > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > > > ---
> > > >  drivers/acpi/acpica/utglobal.c |    4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
> > > > index f3abeae..825b064 100644
> > > > --- a/drivers/acpi/acpica/utglobal.c
> > > > +++ b/drivers/acpi/acpica/utglobal.c
> > > > @@ -377,9 +377,7 @@ acpi_status acpi_ut_init_globals(void)
> > > >  	acpi_gbl_disable_mem_tracking = FALSE;
> > > >  #endif
> > > >
> > > > -#ifdef ACPI_DEBUGGER
> > > > -	acpi_gbl_db_terminate_threads = FALSE;
> > > > -#endif
> > > > +	ACPI_DEBUGGER_EXEC(acpi_gbl_db_terminate_threads = FALSE);
> > > >
> > > >  	return_ACPI_STATUS(AE_OK);
> > >
> > > Is it just me or is this incredibly ugly?
> >
> > This patch is no-op for Linux kernel.
> > ACPI_DEBUGGER is not enabled for Linux kernel.
> >
> > This patch is here to reduce the source code differences between
> > Linux and ACPICA.
> 
> > ACPICA release is done by a set of conversion utilities, the process is known as linuxizing.
> > The generation result of the linuxizing will require more human
> > interventions if such differences grow bigger.
> 
> You don't have to do the change to the original ACPICA release, do
> you?

There are many ACPI_DEBUGGER_EXEC() invocations already in the ACPICA source base, this is just a follow up to use the existing mechanism.

> 
> Would it be feasible to modify your linuxizing scripts to simply
> delete #ifdefs that can not happen for linux?

Currently there is no such mechanism.
If it is allowed and urgent, I'll try to add it. Thanks for the suggestion.
This might be happen in the future, not this release cycle.

If we can talk about the future, well, IMO, there is a better way to modulize ACPICA.
For example, this code is invoked in acpi_ut_init_globals(), I do believe it should be invoked in something like acpi_db_initialize().
Then it might also be possible to make the acpi_gbl_db_terminate_threads a static global variable bound to debugger, and invisible to any other files outside of debugger.
The most important benefit might be: we are able to kill many #ifdef/#endif code in this way.
This is more like Linux style. :-)

Thanks and best regards
-Lv
