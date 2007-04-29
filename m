From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support to hotkey subdriver
Date: Sun, 29 Apr 2007 01:15:43 -0300
Message-ID: <20070429041543.GB29832@khazad-dum.debian.net>
References: <11777220172751-git-send-email-hmh@hmh.eng.br> <11777220182109-git-send-email-hmh@hmh.eng.br> <200704282148.00041.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44091 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754562AbXD2EPs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:15:48 -0400
Content-Disposition: inline
In-Reply-To: <200704282148.00041.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, luming.yu@intel.com

On Sat, 28 Apr 2007, Len Brown wrote:
> On Friday 27 April 2007 21:00, Henrique de Moraes Holschuh wrote:
> > Add the hotkey sysfs support.
> > 
> > Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> > ---
> >  Documentation/thinkpad-acpi.txt |   58 ++++++++++++++----
> >  drivers/misc/thinkpad_acpi.c    |  127 +++++++++++++++++++++++++++++++++++++++
> >  drivers/misc/thinkpad_acpi.h    |    2 +
> >  3 files changed, 176 insertions(+), 11 deletions(-)
> 
> I haven't tried this out.
> I was wondering how you know what action should be associated with what key?

I don't.  I could though, using model-specific knowledge (i.e. a table) and
help from the linux thinkpad community and thinkwiki.org.

We deliver to userspace something like "Fn+F1" pressed, instead of "blank
screen" pressed, because "blank screen" is in different keys depending on
thinkpad model.

The BIOS *does* know, and that's what the Mask does. If you leave a bit
off, the bios handles that key (typically doing nothing), but for some keys
like "suspend to disk", it actually generates a ACPI suspend event... etc.

> if that association can be made, is is possible to send the events to
> the input layer like other keyboard events?

I plan to connect to the input layer later on, yes.  But I haven't started
down that road yet.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
