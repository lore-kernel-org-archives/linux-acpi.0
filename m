From: Len Brown <len.brown@intel.com>
Subject: Re: /proc/acpi/thermal_zone/THRM/temperature always reports 40C - is this a bug?
Date: Fri, 13 Oct 2006 01:17:02 -0400
Message-ID: <200610130117.02392.len.brown@intel.com>
References: <452D945F.6040709@gentoo.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:63402 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750826AbWJMFO4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 01:14:56 -0400
In-Reply-To: <452D945F.6040709@gentoo.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-acpi@vger.kernel.org, eaburns@cisunix.unh.edu

On Wednesday 11 October 2006 21:03, Daniel Drake wrote:
> Hi,
> 
> Ethan, at http://bugs.gentoo.org/142635 reports that the thermal zone 
> always reads 40C. Is this something that should be filed at the kernel 
> bugzilla for further investigation, or can we simply blame a 
> buggy/unfixable BIOS? I understand that i2c/hwmon is the more common way 
> of measuring temperatures.

Probably this isn't specific to a gentoo build and would happen just
the same with a kernel.org build.  So if it is a bug, it is probably an upstream bug.

However, unless it used to work, or something bad happens,
this is sort of an academic failure.  I suppose if you ran Windows
on the box and it displayed a changing temperature via ACPI
but Linux does not, then it would be more interesting.

It would be good to verify that ACPI events in general
are working on the box -- eg. the power button etc -- as a failure
there would also be more interesting than unchanging temperature.

-Len
