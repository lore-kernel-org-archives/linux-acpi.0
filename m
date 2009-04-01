From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 58/98] sony-laptop: Add rfkill support on new models
Date: Wed, 1 Apr 2009 22:00:39 +0900
Message-ID: <20090401130039.GD9650@kamineko.org>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org> <6cc056bc31ea9910afb01adc0848bb6ae68e0205.1238214620.git.len.brown@intel.com> <200903291352.43125.matze@welwarsky.de> <20090329150640.GB8500@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:36927
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764128AbZDANAl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:00:41 -0400
Content-Disposition: inline
In-Reply-To: <20090329150640.GB8500@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matthias Welwarsky <matze@welwarsky.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

On Sun, Mar 29, 2009 at 04:06:40PM +0100, Matthew Garrett wrote:
> On Sun, Mar 29, 2009 at 01:52:42PM +0200, Matthias Welwarsky wrote:
> > On Saturday 28 March 2009 05:31:33 you wrote:
> > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > >
> > > Newer Vaios provide a full featured rfkill implementation via their
> > > platform methods. Add support for enumerating the available devices and
> > > providing rfkill access to them. Support for the physical kill switch is
> > > added, with the devices moving into the HARD_BLOCKED state when toggled.
> > 
> > Bug: If you insert the module with hardware kill switch enabled, it cannot be 
> > disabled any more, i.e. despite operating the hardware kill switch, devices 
> > will not become enabled.
> > 
> > Any hint how I could debug this?
> 
> Put debug prints through the rfkill_update and rfkill_get functions? I 
> don't see anything especially obvious that would prevent this from 
> working.

Matthias, any progress in debugging this?
-- 
mattia
:wq!
