From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
 acpi_osi=!Darwin provided
Date: Mon, 22 Feb 2016 08:55:56 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB4DB10@SHSMSX101.ccr.corp.intel.com>
References: <1454377278-3398-1-git-send-email-yu.c.chen@intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BB4DAB4@SHSMSX101.ccr.corp.intel.com>
 <36DF59CE26D8EE47B0655C516E9CE640286C6882@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43601 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbcBVI4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2016 03:56:04 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE640286C6882@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>

Hi,

> From: Chen, Yu C
> Subject: RE: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
> acpi_osi=!Darwin provided
> 
> 
> > From: Zheng, Lv
> > Subject: RE: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
> > acpi_osi=!Darwin provided
> >
> > Hi, Yu
> >
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Chen Yu
> > > Subject: [PATCH][v3] ACPI: Do not report _OSI("Darwin") when
> > > acpi_osi=!Darwin provided
> > >
> > > Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
> > > reports positive value when Apple hardware queries _OSI("Darwin").
> > > But sometimes the users might want to tell the hardware they don't
> > > need the Darwin feature, for example, users may leverage the hardware
> > > to power off the Thunderbolt, by appending acpi_osi=!Darwin in command
> > > line, thus Apple hardware regards it as an incompatible OS X system,
> > > hence turns off the Thunderbolt.
> > [Lv Zheng]
> > Both this patch and the original commit that is from Matthew look wrong to
> > me.
> > IMO, the feature should be done with an entirely different approach.
> > Without test, I'm not sure if my comment is helpful for you.
> > So could you let me take over to fix this issue?
> >
> Yes, sure, thanks.
[Lv Zheng] 
It looks to me, the original Matthew's commit was trying to make the world easier with "acpi_osi=! acpi_osi=Darwin".
While it finally adds limitation to the acpi_osi= quirk mechanism and is proven to be a bad idea.
So why don't we just revert that commit?

According to my understanding, there is no better choice other than letting users to choose a non-recent-Windows OS that the kernel should pretend to be.
So that kernel can stay simple to just pretend to be "recent-Windows".

And the only improvement that is acceptable in this case is:
We can allow acpi_osi=Darwin to be equivalent to "acpi_osi=! acpi_osi=Darwin".
While I don't think this improvement is necessary.
All reporters, including the contribution vendors should have already been familiar with "acpi_osi=! acpi_osi=Darwin".

Thanks and best regards
-Lv

> 
> yu
> 

