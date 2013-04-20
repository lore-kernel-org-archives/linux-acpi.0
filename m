From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo ThinkPads
Date: Sun, 21 Apr 2013 00:06:53 +0200
Message-ID: <1595406.DWIUmGvNI0@vostro.rjw.lan>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com> <515BD48B.7000901@bjencks.net> <5170B6ED.2040408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:39218 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449Ab3DTV6v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 20 Apr 2013 17:58:51 -0400
In-Reply-To: <5170B6ED.2040408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, joeyli <jlee@suse.com>, Matthew Garrett <mjg59@srcf.ucam.org>

On Friday, April 19, 2013 11:15:57 AM Aaron Lu wrote:
> On 04/03/2013 03:04 PM, Ben Jencks wrote:
> > On 04/02/2013 09:00 AM, Seth Forshee wrote:
> >> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
> >>>
> >>> I really wondered, how Windows handled this, it should have the same
> >>> problem, unless they are not using the acpi video interface?
> >>
> >> I can only guess.
> >>
> >> I think I remember reading that Windows 8 does smooth backlight
> >> transitions, so it may well hit every intermediate brightness value.
> >> Lenovo could also be supplying a driver which rounds values to the
> >> nearest working value or uses some other interface or something else.
> > 
> > Just checked; Windows 8 doesn't use the ACPI interface. It seems to have
> > access to at least 100 distinct brightness levels.
> 
> I just came across a document on win8 backlight control, it has words
> like this:
> "
> In Windows 8, the primary mechanism by which a platform should expose
> its display brightness control functionality is the Windows Display
> Driver Model (WDDM) miniport Device Driver Interfaces (DDI).
> "
> So looks like, on win8, ACPI interface is not used for these systems.
> 
> The link for the document is here:
> http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305

OK, so what does that mean for the issue at hand?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
