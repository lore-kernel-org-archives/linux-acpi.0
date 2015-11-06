From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH v2] acpi: Use kstrtoul() instead of
 strtoul()/simple_strtoul()
Date: Fri, 6 Nov 2015 16:21:41 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D991668@ORSMSX112.amr.corp.intel.com>
References: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
 <20150802071643.GF32270@amd> <55BDD287.70004@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28974 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074AbbKFQWK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2015 11:22:10 -0500
In-Reply-To: <55BDD287.70004@roeck-us.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>


> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()

So, this would fix the issue(s) (in aclinux.h):

#define strtoul                     kstrtoul



strtoul is used frequently in with the ACPICA in-kernel AML Debugger:

dbcmds.c(188):        Address = strtoul (InString, NULL, 16);
dbcmds.c(266):    SleepState = (UINT8) strtoul (ObjectArg, NULL, 0);
dbcmds.c(1283):    GpeNumber = strtoul (GpeArg, NULL, 0);
dbcmds.c(1291):        BlockNumber = strtoul (BlockArg, NULL, 0);
dbdisply.c(213):    Address = strtoul (Target, NULL, 16);
dbdisply.c(749):    Handle = ACPI_TO_POINTER (strtoul (ObjectArg, NULL, 16));
dbexec.c(769):    NumThreads = strtoul (NumThreadsArg, NULL, 0);
dbexec.c(770):    NumLoops = strtoul (NumLoopsArg, NULL, 0);
dbhistry.c(292):        CmdNum = strtoul (CommandNumArg, NULL, 0);
dbinput.c(1018):                strtoul (AcpiGbl_DbArgs[1], NULL, 16);
dbinput.c(1026):            AcpiGbl_DbDebugLevel = strtoul (AcpiGbl_DbArgs[1], NULL, 16);
dbinput.c(1060):        Temp = strtoul (AcpiGbl_DbArgs[2], NULL, 0);
dbmethod.c(162):    Address = strtoul (Location, NULL, 16);
dbmethod.c(249):    Value = strtoul (ValueArg, NULL, 16);
dbmethod.c(271):    Index = strtoul (IndexArg, NULL, 16);
dbmethod.c(381):        NumStatements = strtoul (Statements, NULL, 0);
dbnames.c(334):            MaxDepth = strtoul (DepthArg, NULL, 0);
dbnames.c(405):    OwnerId = (ACPI_OWNER_ID) strtoul (OwnerArg, NULL, 0);
dbnames.c(411):        MaxDepth = strtoul (DepthArg, NULL, 0);
dbnames.c(990):    Address = strtoul (ObjectArg, NULL, 16);
dbtest.c(1046):        Info.MaxCount = strtoul (CountArg, NULL, 0);






> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, August 02, 2015 1:19 AM
> To: Pavel Machek
> Cc: rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert; Zheng, Lv; linux-
> acpi@vger.kernel.org; linux-kernel@vger.kernel.org; devel@acpica.org
> Subject: Re: [PATCH v2] acpi: Use kstrtoul() instead of
> strtoul()/simple_strtoul()
> 
> On 08/02/2015 12:16 AM, Pavel Machek wrote:
> > On Mon 2015-07-27 17:32:22, Guenter Roeck wrote:
> >> simple_strtoul() is deprecated; replace with kstrtoul() and
> kstrtouint().
> >> Return an error if the value passed to the sysfs attribute is not a
> >> number.
> >>
> >> Drop the definition of strtoul() since it is no longer needed.
> >>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >> v2: An additional use of strtoul() was introduced with commit 4fa4616e.
> >>      Replace it as well.
> >>
> >>   drivers/acpi/acpica/evgpeinit.c | 5 +++--
> >>   drivers/acpi/sysfs.c            | 8 ++++++--
> >>   include/acpi/platform/aclinux.h | 1 -
> >>   3 files changed, 9 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpica/evgpeinit.c
> >> b/drivers/acpi/acpica/evgpeinit.c index ea4c0d3fca2d..aa1e8c1f2d4a
> >> 100644
> >> --- a/drivers/acpi/acpica/evgpeinit.c
> >> +++ b/drivers/acpi/acpica/evgpeinit.c
> >> @@ -326,6 +326,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >>   	u32 gpe_number;
> >>   	char name[ACPI_NAME_SIZE + 1];
> >>   	u8 type;
> >> +	int err;
> >>
> >>   	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
> >>
> >> @@ -377,8 +378,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
> >>
> >>   	/* 4) The last two characters of the name are the hex GPE Number
> >> */
> >>
> >> -	gpe_number = strtoul(&name[2], NULL, 16);
> >> -	if (gpe_number == ACPI_UINT32_MAX) {
> >> +	er = kstrtouint(&name[2], 16, &gpe_number);
> >> +	if (err < 0 || gpe_number == ACPI_UINT32_MAX) {
> >
> > Are you sure you compile-tested this?
> >
> 
> I was, but maybe not ;-). Since the patch was rejected it does not really
> matter.
> 
> Guenter

