From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24 regression:  hibernation hangs on "Suspending console" in low-battery condition
Date: Sun, 11 Nov 2007 19:27:25 +0100
Message-ID: <200711111927.26540.rjw@sisk.pl>
References: <200711052201.17150.arvidjaar@mail.ru> <200711111331.00826.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34678 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbXKKSKD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Nov 2007 13:10:03 -0500
In-Reply-To: <200711111331.00826.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

On Sunday, 11 of November 2007, Andrey Borzenkov wrote:
> On Monday 05 November 2007, Andrey Borzenkov wrote:
> > Notice "hung" not "hangs". This happened so far only once - when low battery 
> > condition triggered suspend to disk. I was not able to reproduce it after 
> > this running on AC.
> > 
> > Just in case it rings the bell for someone. This is not suspend regression 
> > reported earlier by Jens - I do not even have SATA nor is using libata 
> > drivers.
> > 
> 
> This happened second time, now with 2.6.24-rc2. I have kpowersave configured
> to initiate suspend-to-disk on low battery. Suspend-to-disk is initiated,
> but system stops after Suspending console line. Suspend image is not created.
> 
> This did work before although I do not name exact version.
> 
> I am rather at loss how to proceed further ... any idea? dmesg and config
> attached just in case. The problem is that hibernation works when I initiate
> it manually ...

Have you tried it with the battery removed?
