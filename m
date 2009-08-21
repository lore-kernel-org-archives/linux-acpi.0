From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH] acpi: thermal: display forced passive trip points in proc
Date: Fri, 21 Aug 2009 16:49:57 +0200
Message-ID: <200908211649.58046.elendil@planet.nl>
References: <200908211617.03574.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml103.kpnxchange.com ([195.121.3.7]:56848 "EHLO
	CPSMTPM-EML103.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932358AbZHUOt5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2009 10:49:57 -0400
In-Reply-To: <200908211617.03574.elendil@planet.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org

On Friday 21 August 2009, Frans Pop wrote:
> Users can force a passive trip point for a thermal zone that does not
> have _PSV defined in ACPI by setting the passive attribute in sysfs.
> It's useful to display such trip points in /proc/acpi/thermal_zone.
>
> .../TZ1/cooling_mode:<setting not supported>
> .../TZ1/polling_frequency:polling frequency:       10 seconds
> .../TZ1/state:state:                   ok
> .../TZ1/temperature:temperature:             56 C
> .../TZ1/trip_points:critical (S5):           110 C
> .../TZ1/trip_points:passive:                 95 C: forced

Hmm. Maybe the following would be clearer:
  .../TZ1/trip_points:passive (forced):        95 C

?
