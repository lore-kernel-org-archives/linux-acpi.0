From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok
 Prime UX31A
Date: Thu, 24 Oct 2013 01:53:26 +0100
Message-ID: <20131024005326.GA5783@srcf.ucam.org>
References: <1382307388.4030.30.camel@lamella>
 <CAMP44s1rNLVQ2Mh5MS+4jvnY3suE-PNGs12407uW+7GczsG5JA@mail.gmail.com>
 <20131023153114.GA31944@srcf.ucam.org>
 <CAMP44s16AfMk4rCZ3E2WCmBcT_3aS0rhzhpvyCtFpjsBHnMutg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35095 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3JXAxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 20:53:33 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s16AfMk4rCZ3E2WCmBcT_3aS0rhzhpvyCtFpjsBHnMutg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Vincent Blut <vincent.debian@free.fr>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rafael.j.wysocki@intel.com

On Wed, Oct 23, 2013 at 02:39:58PM -0500, Felipe Contreras wrote:
> On Wed, Oct 23, 2013 at 10:31 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Mon, Oct 21, 2013 at 09:12:22PM -0500, Felipe Contreras wrote:
> >
> >> But yeah, it should work in v3.11, but when you set the level to 0,
> >> the backlight is turned off, isn't it?
> >
> > That's a valid thing for the backlight system to do.
> 
> In your opinion.

Documentation/stable/sysfs-class-backlight doesn't say otherwise, so 
yes, it's valid.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
