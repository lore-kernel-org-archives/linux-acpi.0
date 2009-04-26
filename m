From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2ram on Lenovo X300 is broken
Date: Mon, 27 Apr 2009 01:12:28 +0200
Message-ID: <200904270112.28813.rjw@sisk.pl>
References: <6D80BDFB1A1FA74DA476417C24C452A102495C8361@scl-exch2k7.phoenix.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45843 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZDZXNR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Apr 2009 19:13:17 -0400
In-Reply-To: <6D80BDFB1A1FA74DA476417C24C452A102495C8361@scl-exch2k7.phoenix.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kaushik Barde <Kaushik_Barde@phoenix.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sunday 26 April 2009, Kaushik Barde wrote:
> I am using stable-2.6.29.1 on Lenovo X300.
> 
> echo mem > /sys/power/state works if I disable AP core using echo 0 > /sys/devices/system/cpu/cpu1/online.
> 
> With SMP, first s3 cycle goes through, subsequent suspend does not work.
> 
> Is this a known issue with CPU_HOTPLUG or suspend re-ordering code?

Similar symptoms have been reported, but the previous reporter did not connect
them with the CPU hotplugging.

The issue isn't actually known and suspend-resume works on many SMP systems.

Is the problem reproducible with the current mainline kernel?

Rafael
