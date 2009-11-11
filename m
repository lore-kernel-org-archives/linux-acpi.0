From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] usb: Add support for runtime power management of the hcd
Date: Wed, 11 Nov 2009 22:36:23 +0100
Message-ID: <200911112236.23179.rjw@sisk.pl>
References: <1257806610-6570-1-git-send-email-mjg@redhat.com> <200911101408.01867.oliver@neukum.org> <20091110141259.GA19792@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37721 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759164AbZKKVep (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 16:34:45 -0500
In-Reply-To: <20091110141259.GA19792@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu

On Tuesday 10 November 2009, Matthew Garrett wrote:
> On Tue, Nov 10, 2009 at 02:08:01PM +0100, Oliver Neukum wrote:
> 
> > I was wondering because a tester has reported a race in ehci that
> > can lead to a loss of wakeup events. Alan posted a patch to fix it.
> > Does it cooperate with your patch?
> 
> Hm. I'll look into that.
> 
> > And secondly what happens if you suspend to RAM a system
> > with suspended controllers?
> 
> I believe that this currently results in them being woken up and then 
> whatever would normally happen,

That's correct AFAICS.

Rafael
