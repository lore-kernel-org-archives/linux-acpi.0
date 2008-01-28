From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Mon, 28 Jan 2008 13:51:47 -0200
Message-ID: <20080128155147.GC30716@khazad-dum.debian.net>
References: <20071226020325.GA21099@srcf.ucam.org> <200801241644.49114.lenb@kernel.org> <20080126220045.b93db7c9.akpm@linux-foundation.org> <20080128012549.GA24166@srcf.ucam.org> <20080127211013.1ddaa6a1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36215 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792AbYA1Pvx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 10:51:53 -0500
Content-Disposition: inline
In-Reply-To: <20080127211013.1ddaa6a1.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Sun, 27 Jan 2008, Andrew Morton wrote:
> 0 sh -c "echo $1 > /sys/class/backlight/thinkpad_screen/brightness"
> ) 2>/dev/null
> 
> And yes, I had an rc.local command which assumed that 7 (later 8) is max
> brightness.

You have to use 15 (or 16? I forget) on T61, X61, R61, X60(I think)... for
maximum brightness :-p   And the interface to get maximum brightness has
always been to cat max_brightness > brightness, AFAIK.

> My /sys/class/backlight/ directory is presently empty.  Rather than trying
> to find out why, I think I'll just collapse in laughter.

Well, I can tell you why it is empty on the thinkpad-acpi side.  It defaults
to brightness_enable=0 on Lenovo 16-brightness level boxes, where the right
thing to do is to control brightness using the X.org drivers or through the
ACPI brightness driver.

But I have no idea why it is empty re. the ACPI video driver.

> Guys, sort it out, please.

I am reading this ML with eyes fully open.  When a sensible (read: any)
consensus is found, I will follow it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
