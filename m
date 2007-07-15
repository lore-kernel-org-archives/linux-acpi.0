From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: make the input event
	mode the default
Date: Sun, 15 Jul 2007 18:14:21 -0300
Message-ID: <20070715211421.GG19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223341511-git-send-email-hmh@hmh.eng.br> <20070714223315.GB25782@srcf.ucam.org> <20070715180529.GF14134@khazad-dum.debian.net> <20070715183823.GC3235@srcf.ucam.org> <20070715200948.GC19066@khazad-dum.debian.net> <20070715201346.GB5518@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39994 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751110AbXGOVO3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 17:14:29 -0400
Content-Disposition: inline
In-Reply-To: <20070715201346.GB5518@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, dmitry.torokhov@gmail.com, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 05:09:48PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > > But we're able to differentiate between the models.
> > 
> > Yes. And I was told to not do it in the kernel when possible, so I will map
> > by default only what is marked and working on a vast majority.  Otherwise,
> > I'd need a big quirk db, based on what is silk-screened on the keyboards.
> 
> We already have in-kernel drivers that do this properly, so I'd suspect 
> that whoever told you that was wrong.

I got tired of being told one way or the other, already.

My position is simple, for now: I am keeping model-specific knowledge on the
driver to the bare minimum needed for correct driver operation.  But I will
add it anytime I fell it is needed to keep correct driver operation.

The different lenovo/ibm keymaps were added because of the mess with the
brightness and volume keys in the latest BIOSes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
