From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 4/6] thermal: add sanity check for the passive attribute
Date: Wed, 26 Aug 2009 18:48:28 +0200
Message-ID: <200908261848.29897.elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251303445-25317-5-git-send-email-elendil@planet.nl> <20090826162342.GA15868@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml110.kpnxchange.com ([195.121.3.14]:57310 "EHLO
	CPSMTPM-EML110.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750738AbZHZQs2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 12:48:28 -0400
In-Reply-To: <20090826162342.GA15868@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Wednesday 26 August 2009, Matthew Garrett wrote:
> On Wed, Aug 26, 2009 at 06:17:23PM +0200, Frans Pop wrote:
> > Values below 40000 milli-celsius (limit is somewhat arbitrary)
> > don't make sense and can cause the system to go into a thermal
> > heart attack: the actual temperature will always be lower and
> > thus the system will be throttled down to its lowest setting.
>
> Not keen on this - it's a pretty arbitrary cutoff, and there are some
> cases where someone might want this value. Policy belongs in userspac=
e,
> and all that.

What cases do you see? Testing? Or systems that might have to operate a=
t=20
such a low temperature? I deliberately chose a value that's at a level=20
that's easy to reach.

I agree it is arbitrary, but it will prevent major confusion when someo=
ne=20
like me echo's 95 directly in sysfs.
Would 1000 (1 =B0C) perhaps be more acceptable as a limit? I doubt ther=
e are=20
valid use-cases for below 0 temps :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
