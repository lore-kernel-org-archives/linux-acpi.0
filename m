From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 0/6] [resend] thermal: improvements re. forced passive cooling
Date: Wed, 28 Oct 2009 23:49:04 +0100
Message-ID: <200910282349.06322.elendil@planet.nl>
References: <1256542744-26569-1-git-send-email-elendil@planet.nl> <20091028153551.6c665ca1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:64597 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849AbZJ1WtD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Oct 2009 18:49:03 -0400
In-Reply-To: <20091028153551.6c665ca1.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Sujith Thomas <sujith.thomas@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi Andrew,

On Wednesday 28 October 2009, Andrew Morton wrote:
> I'm trying to work out what the actual bug is in here.

It turned out there was no bug in the kernel. This patch set is an 
enhancement of existing kernel functionality.

> afacit some KDE tool put wrong numbers into /proc files, acpi didn't
> sanity check them sufficiently and permitted the CPU to overheat, yes?

No. The problem was that the thermal zone that overheated did not have a 
passive trip point defined in ACPI. So the kernel had no way of knowing 
the system was overheating.

The kernel already has an option to "force" a passive trip point for such 
zones (using polling to check it), and that works. But while testing that 
and looking at the code I spotted some possible enhancements.

> There seems to be rather a lot of non-bugfix stuff in this patch
> series.  Perhaps too much for 2.6.32, and a real problem if we want to
> backport something into 2.6.31.x and earlier.

It would have been nice if it had made .32 from my first submission, but 
now it's fine for .33. It's not stable material.

Thanks for taking the series.

Cheers,
FJP
