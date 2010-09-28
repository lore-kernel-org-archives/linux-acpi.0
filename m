From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH 1/1] acpi: clear PCIEXP_WAKE_STS on resume
Date: Tue, 28 Sep 2010 16:46:02 +0100
Message-ID: <1285688763.2072.6.camel@lenovo>
References: <1285671624-7826-1-git-send-email-colin.king@canonical.com>
	 <1285671624-7826-2-git-send-email-colin.king@canonical.com>
	 <20100928083121.f76e8991.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LaCLinZddrYGbcRrYrrZ"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:47940 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab0I1PqJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 11:46:09 -0400
In-Reply-To: <20100928083121.f76e8991.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


--=-LaCLinZddrYGbcRrYrrZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2010-09-28 at 08:31 -0700, Randy Dunlap wrote:
> On Tue, 28 Sep 2010 12:00:24 +0100 Colin King wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Section 4.7.3.1.1 (PM1 Status Registers) of version 4.0 of
> > the ACPI spec concerning PCIEXP_WAKE_STS points out in
> > in the final note field in table 4-11 that if this bit is
> > set to 1 and the system is put into a sleeping state then
> > the system will not automatically wake.
> > 
> > This bit gets set by hardware to indicate that the system
> > woke up due to a PCI Express wakeup event, so clear it during
> > acpi_hw_clear_acpi_status() calls to enable subsequent
> > resumes to work.
> > 
> > BugLink: http://bugs.launchpad.net/bugs/613381
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/acpi/acpica/aclocal.h |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> > index 147a7e6..f26db38 100644
> > --- a/drivers/acpi/acpica/aclocal.h
> > +++ b/drivers/acpi/acpica/aclocal.h
> > @@ -853,6 +853,7 @@ struct acpi_bit_register_info {
> >  	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
> >  	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
> >  	ACPI_BITMASK_RT_CLOCK_STATUS       | \
> > +        ACPI_BITMASK_PCIEXP_WAKE_DISABLE   | \
> 
> (1) Above should be indented with tabs, not spaces.

My fail. Attached corrected patch.

> 
> (2) It should not take 2 emails to send a patch with one line changed.
> Patch 0/N is unnecessary and not desirable on short patch series (N = 1 is short).
> 
> >  	ACPI_BITMASK_WAKE_STATUS)
> >  
> >  #define ACPI_BITMASK_TIMER_ENABLE               0x0001
> > -- 
> 
> 
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***


--=-LaCLinZddrYGbcRrYrrZ
Content-Disposition: attachment; filename="0001-acpi-clear-PCIEXP_WAKE_STS-on-resume.patch"
Content-Type: text/x-patch; name="0001-acpi-clear-PCIEXP_WAKE_STS-on-resume.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 871dccf769ad7be6625bb10a0d58408bf90e6c51 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 2 Aug 2010 15:14:43 +0000
Subject: [PATCH] acpi: clear PCIEXP_WAKE_STS on resume

Section 4.7.3.1.1 (PM1 Status Registers) of version 4.0 of
the ACPI spec concerning PCIEXP_WAKE_STS points out in
in the final note field in table 4-11 that if this bit is
set to 1 and the system is put into a sleeping state then
the system will not automatically wake.

This bit gets set by hardware to indicate that the system
woke up due to a PCI Express wakeup event, so clear it during
acpi_hw_clear_acpi_status() calls to enable subsequent
resumes to work.

BugLink: http://bugs.launchpad.net/bugs/613381

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 147a7e6..f26db38 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -853,6 +853,7 @@ struct acpi_bit_register_info {
 	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
 	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
 	ACPI_BITMASK_RT_CLOCK_STATUS       | \
+	ACPI_BITMASK_PCIEXP_WAKE_DISABLE   | \
 	ACPI_BITMASK_WAKE_STATUS)
 
 #define ACPI_BITMASK_TIMER_ENABLE               0x0001
-- 
1.7.0.4


--=-LaCLinZddrYGbcRrYrrZ--

