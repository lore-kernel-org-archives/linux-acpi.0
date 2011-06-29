From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: PATCH: Don't enable GPE if GPE dispatch failed
Date: Wed, 29 Jun 2011 14:19:42 +0800
Message-ID: <1309328382.7886.2.camel@rui>
References: <20110628220535.GA19846@intel.com>	<1309311174.5389.0.camel@rui>
	 <1309311310.5389.2.camel@rui>
	 <BANLkTinqc5FeP9x3B=QjQ0RaXJPytYzn4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16316 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892Ab1F2GRE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jun 2011 02:17:04 -0400
In-Reply-To: <BANLkTinqc5FeP9x3B=QjQ0RaXJPytYzn4A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: "acpi@linux.intel.com" <acpi@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, H.J.

IMO, the real problem is that EC address space handler is not installed.
please attach the full dmesg output of your patched kernel after boot.

thanks,
rui

On Wed, 2011-06-29 at 10:51 +0800, H.J. Lu wrote:
> On Tue, Jun 28, 2011 at 6:35 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > CC linux-acpi mail list.
> >
> > On Wed, 2011-06-29 at 09:32 +0800, Zhang, Rui wrote:
> >> Hi,
> >>
> >> can you send me the acpidump output of this machine please?
> >>
> >> thanks,
> >> rui
> >>
> >> On Wed, 2011-06-29 at 06:05 +0800, Lu, Hongjiu wrote:
> >> > Hi,
> >> >
> >> > I have a broken BIOS, which generates thousands of kernel messages:
> >> >
> >> > Jun 28 14:13:26 gnu-18 kernel: [  628.704003] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] (20110112/evgpe-551)
> >> > Jun 28 14:13:26 gnu-18 kernel: [  628.826752] ACPI Error: No handler for Region [ECF2] (ffff88013763b6c0) [EmbeddedControl] (20110112/evregion-369)
> >> > Jun 28 14:13:26 gnu-18 kernel: [  628.826761] ACPI Error: Region EmbeddedControl(0x3) has no handler (20110112/exfldio-292)
> >> > Jun 28 14:13:26 gnu-18 kernel: [  628.826768] ACPI Error: Method parse/execution failed [\_GPE._L01] (Node ffff88013765a488), AE_NOT_EXIST (20110112/psparse-536)
> >> >
> >> > This patch avoids enabling GPE if GPE dispatch failed.  Now I got only
> >> > one kernel message:
> >> >
> >> > Jun 28 14:38:51 gnu-18 kernel: [    0.937479] ACPI Error: No handler for Region [ECF2] (ffff88013763b6c0) [EmbeddedControl] (20110112/evregion-369)
> >> > Jun 28 14:38:51 gnu-18 kernel: [    0.937485] ACPI Error: Region EmbeddedControl(0x3) has no handler (20110112/exfldio-292)
> >> > Jun 28 14:38:51 gnu-18 kernel: [    0.937490] ACPI Error: Method parse/execution failed [\_GPE._L01] (Node ffff88013765a488), AE_NOT_EXIST (20110112/psparse-536)
> >> > Jun 28 14:38:51 gnu-18 kernel: [    0.937502] ACPI Exception: AE_NOT_EXIST, while evaluating GPE method [_L01] (20110112/evgpe-551)
> >> >
> >> >
> >> >
> >> > H.J.
> >> > ---
> >> > diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
> >> > index f472521..5b1f4b2 100644
> >> > --- a/drivers/acpi/acpica/evgpe.c
> >> > +++ b/drivers/acpi/acpica/evgpe.c
> >> > @@ -559,11 +559,13 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
> >> >
> >> >     /* Defer enabling of GPE until all notify handlers are done */
> >> >
> >> > -   status = acpi_os_execute(OSL_NOTIFY_HANDLER,
> >> > -                            acpi_ev_asynch_enable_gpe,
> >> > -                            local_gpe_event_info);
> >> > -   if (ACPI_FAILURE(status)) {
> >> > -           ACPI_FREE(local_gpe_event_info);
> >> > +   if (!ACPI_FAILURE(status)) {
> >> > +           status = acpi_os_execute(OSL_NOTIFY_HANDLER,
> >> > +                                    acpi_ev_asynch_enable_gpe,
> >> > +                                    local_gpe_event_info);
> >> > +           if (ACPI_FAILURE(status)) {
> >> > +                   ACPI_FREE(local_gpe_event_info);
> >> > +           }
> >> >     }
> >> >     return_VOID;
> >> >  }
> >> >
> 
> Here it is.
> 
> 


