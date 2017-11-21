From: "Schmauss, Erik" <erik.schmauss@intel.com>
Subject: RE: [PATCH 00/11] ACPICA release 20170929
Date: Tue, 21 Nov 2017 17:05:41 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED539646E2D@ORSMSX110.amr.corp.intel.com>
References: <erik.schmauss@intel.com>
 <20171117234024.833-1-erik.schmauss@intel.com>
 <2319214.my3GEoqqme@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:15156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbdKURF7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 21 Nov 2017 12:05:59 -0500
In-Reply-To: <2319214.my3GEoqqme@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Monday, November 20, 2017 5:05 PM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: linux-acpi@vger.kernel.org; Moore, Robert <robert.moore@intel.com>
> Subject: Re: [PATCH 00/11] ACPICA release 20170929
> 
> Hi Erik,
> 
> On Saturday, November 18, 2017 12:40:13 AM CET Erik Schmauss wrote:
> > This series of patches are from the 20170929 release of ACPICA.
> > This set is meant to be applied on top of the 20170831 ACPICA release.
> >
> > Bob Moore (4):
> >   ACPICA: Rename AE_AML_INFINITE_LOOP exception
> >   ACPICA: Tools: Deploy -vd option (build date/time) across all tools
> >   ACPICA: iASL/Tools: Add support for PDTT,SDEV,TPM2 ACPI tables
> >   ACPICA: Update version to 20170929
> >
> > Colin Ian King (1):
> >   ACPICA: Avoid null pointer dereference on Op.
> >
> > Erik Schmauss (3):
> >   ACPICA: Disassembler: reset parser_state's Aml pointer when parsing
> >     bad externals
> >   ACPICA: disassembler: getting rid of error message
> >   ACPICA: iASL: change processing of external op namespace nodes for
> >     correctness
> >
> > Jung-uk Kim (1):
> >   ACPICA: Fix an off-by-one error in acpi_get_timer_duration().
> >
> > Lv Zheng (2):
> >   ACPICA: Dispatcher: Introduce timeout mechanism for infinite loop
> >     detection
> >   ACPICA: Utilities: Cleanup style issue for bit clearing
> >
> >  drivers/acpi/acpica/acapps.h             |  3 ++
> >  drivers/acpi/acpica/aclocal.h            |  2 +-
> >  drivers/acpi/acpica/dscontrol.c          | 18 ++++----
> >  drivers/acpi/acpica/hwtimer.c            | 29 ++++++------
> >  drivers/acpi/acpica/nsaccess.c           | 13 +++---
> >  drivers/acpi/acpica/nssearch.c           |  1 +
> >  drivers/acpi/acpica/psobject.c           | 10 +----
> >  drivers/acpi/acpica/psutils.c            |  6 +--
> >  drivers/acpi/acpica/utinit.c             |  1 -
> >  drivers/acpi/acpica/utmath.c             |  4 +-
> >  include/acpi/acconfig.h                  |  4 +-
> >  include/acpi/acexcep.h                   |  6 +--
> >  include/acpi/acpixf.h                    |  6 +--
> >  include/acpi/actbl1.h                    | 77 +++++++++++++++++++++++++++++---
> >  include/acpi/actbl2.h                    | 14 +++++-
> >  include/acpi/actypes.h                   |  2 +
> >  tools/power/acpi/tools/acpidump/apmain.c | 28 ++++++++++--
> >  17 files changed, 160 insertions(+), 64 deletions(-)
> 
> Thanks for the patches.
> 
> It doesn't look like anything in this series and in the next one you posted is
> particularly urgent, so I'm going to queue them up for 4.16.
> 
> If there is anything is this material that should be included into 4.15, please let
> me know.
Hi Rafael,

This 20170927 release was a small one and I believe that all of these are not very urgent. However, changes to the NFIT table in the 20171110 release has been requested by a few customers

Thanks,
Erik
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
