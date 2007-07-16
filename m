From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: make the input event
	mode the default
Date: Mon, 16 Jul 2007 15:21:34 -0300
Message-ID: <20070716182134.GB13710@khazad-dum.debian.net>
References: <20070715200948.GC19066@khazad-dum.debian.net> <20070715201346.GB5518@srcf.ucam.org> <20070715211421.GG19066@khazad-dum.debian.net> <20070715211953.GA6527@srcf.ucam.org> <20070715220801.GK19066@khazad-dum.debian.net> <20070715224914.GB7164@srcf.ucam.org> <20070716001239.GA31604@khazad-dum.debian.net> <20070716002420.GA8140@srcf.ucam.org> <20070716030254.GD31604@khazad-dum.debian.net> <d120d5000707160827u5217722fvcffb9339b80c0c79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42546 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532AbXGPSVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 14:21:39 -0400
Content-Disposition: inline
In-Reply-To: <d120d5000707160827u5217722fvcffb9339b80c0c79@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 16 Jul 2007, Dmitry Torokhov wrote:
> I will add a comment to input.h to the effect that KEY_SWITCHVIDEOMODE
> is to switch between available outputs (LCD/Monitor/TV-Out/Whatnot).
> Right now couple of RCs are using it for different purposes (cycling
> through inputs I think) so we should do somethig about these.

I will add KEY_SWITCHVIDEOMODE to FN+F7 (thinkpad cycle output video port
key), then.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
