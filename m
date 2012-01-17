From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/5] ACPI processor: Do not export acpi_idle_driver in processor.h
Date: Tue, 17 Jan 2012 15:08:05 +0100
Message-ID: <201201171508.05802.trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-2-git-send-email-trenn@suse.de> <4F155A94.3070403@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57729 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab2AQOIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 09:08:07 -0500
In-Reply-To: <4F155A94.3070403@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Tuesday, January 17, 2012 12:25:08 PM Len Brown wrote:
> On 11/17/2011 05:36 PM, Thomas Renninger wrote:
>=20
> > Instead move its declaration from processor_idle.c to processor_dri=
ver.c
> > and declare it static as it's the only file using this struct.
> >=20
> > Cleanup only, no functional change.
> >=20
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: Len Brown <lenb@kernel.org>
> > CC: linux-acpi@vger.kernel.org
> > ---
> >  drivers/acpi/processor_driver.c |    5 +++++
> >  drivers/acpi/processor_idle.c   |    5 -----
> >  include/acpi/processor.h        |    1 -
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> >=20
>=20
>=20
> drivers/acpi/processor_idle.c: In function =91acpi_processor_setup_cp=
uidle_states=92:
> drivers/acpi/processor_idle.c:1032:32: error: =91acpi_idle_driver=92 =
undeclared (first use in this function)
> drivers/acpi/processor_idle.c:1032:32: note: each undeclared identifi=
er is reported only once for each function it appears in
> drivers/acpi/processor_idle.c: In function =91acpi_processor_cst_has_=
changed=92:
> drivers/acpi/processor_idle.c:1158:29: error: =91acpi_idle_driver=92 =
undeclared (first use in this function)
> drivers/acpi/processor_idle.c: In function =91acpi_processor_power_in=
it=92:
> drivers/acpi/processor_idle.c:1239:38: error: =91acpi_idle_driver=92 =
undeclared (first use in this function)
> drivers/acpi/processor_idle.c: In function =91acpi_processor_power_ex=
it=92:
> drivers/acpi/processor_idle.c:1270:31: error: =91acpi_idle_driver=92 =
undeclared (first use in this function)
>=20
> eh?
Oh, this one does not work anymore since:
commit 46bcfad7a819bd17ac4e831b04405152d59784ab
Author: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date:   Fri Oct 28 16:20:42 2011 +0530

    cpuidle: Single/Global registration of idle states

got merged in recently.
Please ignore this patch.

   Thomas
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
