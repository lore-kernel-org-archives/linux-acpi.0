From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is
	serving this functionality
Date: Sun, 16 Nov 2008 10:51:14 -0200
Message-ID: <20081116125114.GB29981@khazad-dum.debian.net>
References: <200811081637.45099.arvidjaar@mail.ru> <200811152017.56926.arvidjaar@mail.ru> <20081115172052.GA9537@srcf.ucam.org> <200811152142.18890.arvidjaar@mail.ru> <20081115184900.GA10685@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52892 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945AbYKPMvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Nov 2008 07:51:21 -0500
Content-Disposition: inline
In-Reply-To: <20081115184900.GA10685@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, 15 Nov 2008, Matthew Garrett wrote:
> Ok, so they can get unsynchronised. I agree with Thomas that it's 
> desirable to remove one of them in that case. As you and Len have 
> pointed out, the difficulty is in knowing which one to remove.

May I point out the obvious, and *very* annoying fact?

It is clear by now that if we want to solve all border conditions nicely, we
will need centralized control of backlight interfaces to broker between
platform-specific drivers and ACPI generic.

My idea is: separate them in two layers.  Have the "backends" (ACPI generic
and platform specific drivers) register parameters with a "frontend".  The
"frontend" exposes a *single* backlight interface.  The backends expose
NOTHING (or at most a deprecated interface if it won't break things).

Backlight interfaces can have their parameters updated at runtime, so we do
just that if the frontend has to switch backends (i.e. due to module
loading/unloading).  Make sure the backend is informed when it is
connected/disconnected from driving the backlight.

Use an intelligent setup to select which backend should be driving the
backlight.  e.g: the backends provide a priority information and a quality
information (priority is low-medium-high.  Quality is the number of levels,
adjusted up or down if you know there is something special about it that
should lower or rise the quality).

If there is only one backend loaded, select that.  If there are more than
one, select the highest priority one.  When the priority of the backends is
the same, select the one with the highest quality. When quality and priority
are the same, select the generic ACPI.

Priority should always be medium, except when you know for sure that you
need to do something special for an specific platform/box.

Any other ideas, comments?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
