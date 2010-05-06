From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 2/2] thinkpad_acpi: Hook volume events
Date: Thu, 6 May 2010 00:02:39 -0300
Message-ID: <20100506030239.GB19265@khazad-dum.debian.net>
References: <1272916980-11835-1-git-send-email-mjg@redhat.com>
 <1272916980-11835-2-git-send-email-mjg@redhat.com>
 <20100505113004.GA19480@khazad-dum.debian.net>
 <20100505132030.GA24372@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100505132030.GA24372@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 05 May 2010, Matthew Garrett wrote:
> On Wed, May 05, 2010 at 08:30:05AM -0300, Henrique de Moraes Holschuh wrote:
> > The idea is sound, but it would be probably cleaner to do it only on those
> > thinkpads which need it.  I don't like the idea of handling duplicate
> > notifications, and the logic depends entirely on nothing messing with the
> > mixer state behind our backs, I'd prefer to rely on it just when strictly
> > required.
> 
> In this case the notification is purely at the ALSA level, so there's no 
> harm caused by duplicate notifications.

Reading that stuff ain't cheap.  Either a locked trip through the LPC bus
for the CMOS nvram, or ACPI EC I/O (which is even worse, I fear.  That EC is
also hooked to LPC, and there's a lot more code involved).

I really would rather not enable it on boxes where it isn't required.  And
we know which ones are those: IBM thinkpads where the all-available-hotkeys
mask has the bits for the volume hotkeys set.

> > Also, UCMS is called for a number of reasons.  It would be best to filter
> > based on the UCMS parameter before doing an expensive PC CMOS RAM read or EC
> > read.  We will be dealing with a finite number of thinkpads anyway.
> 
> Passing the parameter is... difficult. That would involve rather more 
> surgery to the ACPI core, since the parameters are core-internal objects 
> at this point. It's an obvious feature though, so I'll look into it some 
> more.

It would be very very useful, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
