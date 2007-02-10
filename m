From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Sat, 10 Feb 2007 11:37:21 +0100
Message-ID: <200702101137.21687.rjw@sisk.pl>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp> <d120d5000702051149n2f713859na46b8c1b2398e17d@mail.gmail.com> <200702090142.06253.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32806 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbXBJKix (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Feb 2007 05:38:53 -0500
In-Reply-To: <200702090142.06253.dtor@insightbb.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: trenn@suse.de, Bjorn Helgaas <bjorn.helgaas@hp.com>, Luming Yu <luming.yu@gmail.com>, emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org

Hi,

On Friday, 9 February 2007 07:42, Dmitry Torokhov wrote:
> On Monday 05 February 2007 14:49, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On 2/5/07, Thomas Renninger <trenn@suse.de> wrote:
> > > I have a patch that should fix the psmouse unload thing (at the end).
> > > Not sure whether it's still needed in 2.6.20-rcX, there was some work
> > > done... it definitely helps on 2.6.18 and 2.6.16 kernels.
> > > Ok, I quickly tried on 2.6.20-rc7 and it seems to work without the
> > > patch.
> > 
> > Just a limited number of boxes seems to have problems...
> > 
> > > Maybe Dmitry can comment on that and push this one if still needed?
> > 
> > I do not like the idea of removing port at shutdown. I will look into
> > extending psmouse_cleanup so it leaves the port in the same state as
> > psmouse_disconnect.
> > 
> 
> Hi,
> 
> Could you please try the 2 attached patches and let me know if it improves
> suspend and psmouse iteractions.

On my box (nx6325) it does.  Apparenly, with these two patches applied I don't
need to unload psmouse before the suspend so that the power management works
after the resume. :-)

I'll be testing it a bit more today anyway.

Greetings,
Rafael
