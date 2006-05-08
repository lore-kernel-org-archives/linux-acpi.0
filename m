From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] tpm: update module dependencies (PNPACPI)
Date: Mon, 8 May 2006 18:26:05 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB65EAC3D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47445 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750728AbWEHW0L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2006 18:26:11 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>, linux-acpi@vger.kernel.org

>On Mon, 2006-05-08 at 17:59 -0400, Brown, Len wrote:
>> >The TIS driver is dependent upon information from the ACPI table for
>> >device discovery thus it compiles but does no actual work 
>with out this
>> >dependency.
>> >
>> >Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
>> >---
>> > drivers/char/tpm/Kconfig |    2 +-
>> > 1 files changed, 1 insertion(+), 1 deletion(-)
>> >
>> >--- linux-2.6.17-rc3/drivers/char/tpm/Kconfig	2006-04-26 
>> >21:19:25.000000000 -0500
>> >+++ linux-2.6.17-rc3-tpm/drivers/char/tpm/Kconfig	
>> >2006-05-08 16:11:03.707961750 -0500
>> >@@ -22,7 +22,7 @@ config TCG_TPM
>> > 
>> > config TCG_TIS
>> > 	tristate "TPM Interface Specification 1.2 Interface"
>> >-	depends on TCG_TPM
>> >+	depends on TCG_TPM && PNPACPI
>> 
>> I think you want simply "ACPI" rather than "PNPACPI" here, yes?

>No I think I really want PNPACPI because I have a pnp_driver which
>probes based on a CID value.  PNPACPI is dependent on ACPI.  Am I
>misunderstanding something.  It works with PNPACPI on but turning off
>only PNPACPI causes it to not work.

So if you boot with "pnpacpi=off" it fails to probe?
Nice to have proof that PNPACPI finally obsoletes PNPBIOS
on a real system in the field.

thanks,
-Len
