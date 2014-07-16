From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Regression]: Changing brightness does not work with v3.16-rc4
Date: Wed, 16 Jul 2014 02:43:42 +0200
Message-ID: <2231725.PEI454q0UP@vostro.rjw.lan>
References: <20140712180636.698e2e4c@saldaea> <53C53543.1050207@redhat.com> <53C53E89.2020505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57198 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932943AbaGPAZ2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jul 2014 20:25:28 -0400
In-Reply-To: <53C53E89.2020505@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Julian Wollrath <jwollrath@web.de>, linux-acpi@vger.kernel.org

On Tuesday, July 15, 2014 10:45:29 PM Aaron Lu wrote:
> On 07/15/2014 10:05 PM, Hans de Goede wrote:

[cut]

> > On 07/15/2014 04:00 PM, Aaron Lu wrote:
> > 
> >  > If we have to consider the following config:
> >  > 1 ACPI backlight interface works(or can work with some cmdline option);
> > 
> > And the BIOS advertises native win8 support.
> 
> Right.
> So this condition should be:
> 1 ACPI backlight interface works in Win8 mode;
> 
> This means, for Julian's system, the commit 751109aad583 doesn't need to
> be reverted as the ACPI backlight interface on his system only works
> when the acpi_osi="!Windows 2012" is added. In that case, the
> video.use_native_backlight=X doesn't make any difference anymore.

But Julian reports that he needs to revert that commit to make things work
as before for him.  What gives?

Rafael

