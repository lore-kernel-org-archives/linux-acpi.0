From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 2/6] thermal: sysfs-api.txt - document passive attribute for thermal zones
Date: Thu, 3 Sep 2009 16:34:37 +0200
Message-ID: <200909031634.38316.elendil@planet.nl>
References: <1251303445-25317-1-git-send-email-elendil@planet.nl> <1251765882.3483.193.camel@rzhang-dt> <20090902200233.GB1918@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:60954 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445AbZICOeg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Sep 2009 10:34:36 -0400
In-Reply-To: <20090902200233.GB1918@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Wednesday 02 September 2009, Pavel Machek wrote:
> So '0=disabled'? Better say that, because throttling at 0C would be
> useless in most of the world.

I've addressed this in the new version of patch 4/6 I just sent.

Cheers,
FJP
