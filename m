From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: 2.6.25 regression/oops on boot (ACPI related?)
Date: Fri, 29 Feb 2008 07:38:54 +0800
Message-ID: <1204241934.10256.151.camel@acpi-hp-zz.sh.intel.com>
References: <20080228200855.GJ9009@earth.li>
	 <1204219227.10256.146.camel@acpi-hp-zz.sh.intel.com>
	 <20080229075449.GK9009@earth.li>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36945 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbYB2I1O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Feb 2008 03:27:14 -0500
In-Reply-To: <20080229075449.GK9009@earth.li>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ming.m.lin@intel.com


On Fri, 2008-02-29 at 15:54 +0800, Jonathan McDowell wrote:
> On Fri, Feb 29, 2008 at 01:20:27AM +0800, Zhang, Rui wrote:
> > Please attach the acpidump output using the latest pmtools at :
> > http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> > Please attach the result of "cat /proc/acpi/thermal_zone/*/*" as
> well.
> 
> I've attached the output of acpidump. The cat results in this output:
> 
> [noodles@meepok /proc/acpi/thermal_zone/THRM]$ cat *
> 0 - Active; 1 - Passive
> <polling disabled>
> state:                   ok
> temperature:             40 C
> Segmentation fault
> 
> It also causes a general protection fault, which I've attached as
> well.
> 
> This is a stock Debian kernel:
> 
> Linux meepok 2.6.24-1-amd64 #1 SMP Mon Feb 11 13:47:43 UTC 2008 x86_64
> GNU/Linux
> 
> I have a patch from Ming Lin to try out but it'll have to wait until
> tomorrow before I can do so.
> 
We've root caused the problem and Lin Ming's patch should work for you.
Please give it a try. :)

From: Lin Ming <ming.m.lin@intel.com>

Fix a memory overflow bug when copying
NULL internal package element object to external.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/utilities/utobject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/utilities/utobject.c
===================================================================
--- linux-2.6.orig/drivers/acpi/utilities/utobject.c
+++ linux-2.6/drivers/acpi/utilities/utobject.c
@@ -432,7 +432,7 @@ acpi_ut_get_simple_object_size(union acp
 	 * element -- which is legal)
 	 */
 	if (!internal_object) {
-		*obj_length = 0;
+		*obj_length = sizeof(union acpi_object);
 		return_ACPI_STATUS(AE_OK);
 	}
 


