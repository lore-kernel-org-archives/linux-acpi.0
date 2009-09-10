From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 5/6] thermal: Only set passive_delay for forced passive cooling
Date: Thu, 10 Sep 2009 18:07:12 +0200
Message-ID: <200909101807.13874.elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-6-git-send-email-elendil@planet.nl> <20090826162537.GC15868@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml105.kpnxchange.com ([195.121.3.9]:61394 "EHLO
	CPSMTPM-EML105.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750827AbZIJQHM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2009 12:07:12 -0400
In-Reply-To: <20090826162537.GC15868@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Hi Matthew,

On Wednesday 26 August 2009, Matthew Garrett wrote:
> On Wed, Aug 26, 2009 at 06:17:24PM +0200, Frans Pop wrote:
> > Setting polling_delay is useless as passive_delay has priority,
> > so the value shown in proc isn't the actual polling delay. It
> > also gives the impression to the user that he can change the
> > polling interval through proc, while in fact he can't.
> >
> > Also, unset passive_delay when the forced passive trip point is
> > unbound to allow polling to be disabled.
> >
> > Signed-off-by: Frans Pop <elendil@planet.nl>
> > Cc: Matthew Garrett <mjg@redhat.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
>
> I'll look over this - I seem to remember having some reason to set
> that, but it escapes me now.

Have you had a chance to check this?

Cheers,
FJP
