From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: 2.6.25-rc1 regression - suspend to ram
Date: Mon, 11 Feb 2008 15:32:47 -0800
Message-ID: <200802111532.47711.jbarnes@virtuousgeek.org>
References: <20080211225811.GB4343@ics.muni.cz> <200802120010.55021.Rafal.Wysocki@fuw.edu.pl> <20080211232213.GB8206@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-40.bluehost.com ([69.89.20.194]:41230 "HELO
	outbound-mail-40.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756688AbYBKXmh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 18:42:37 -0500
In-Reply-To: <20080211232213.GB8206@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>, Lukas Hejtmanek <xhejtman@ics.muni.cz>, linux-kernel@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Monday, February 11, 2008 3:22 pm Venki Pallipadi wrote:
> On Tue, Feb 12, 2008 at 12:10:54AM +0100, R. J. Wysocki wrote:
> > On Monday, 11 of February 2008, Lukas Hejtmanek wrote:
> > > Hello,
> >
> > Hi,
> >
> > > 2.6.25-rc1 takes really long time till it suspends (about 30-40secs,
> > > used to be about 5 secs at all) and it is resuming about few minutes. 
> > > While resuming, capslock toggles the capslock led but with few secs
> > > delay.
> > >
> > > 2.6.24-git15 was OK. 2.6.24 is OK.
> > >
> > > I have Lenovo ThinkPad T61.
> >
> > If you have CONFIG_CPU_IDLE set, please try to boot with idle=poll and
> > see if that helps.
>
> Just sent this patch to fix a regression in acpi processor_idle.c on
> another thread. Can you try the patch below and check whether that helps.

Excellent, that patch makes things work for me (including console restore).  
Thanks a lot Venki.

Jesse
