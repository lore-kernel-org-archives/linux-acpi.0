From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ltp] [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 07:19:08 -0200
Message-ID: <20091110091908.GB1872@khazad-dum.debian.net>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34976 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918AbZKJJTF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2009 04:19:05 -0500
Content-Disposition: inline
In-Reply-To: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, 09 Nov 2009, Andrew Lutomirski wrote:
> The ThinkPad X200s, like the X61, requires OSI=Linux for the mute
> button to work.  Without this patch (or the equivalent command-line

In the X61, The MUTE button always work.  It *changes* the way it works
based on OSI(Linux), though.  It should be the same on the X200s.  That
doesn't mean OSI(Linux) is a bad idea for the X200s, it might be the right
thing to do.

> parameter), the mute button does not generate a keystroke and,
> instead, messes up the sound hardware.

Now, that's new.  Messes up the sound hardware?  I was told by Lenovo
ThinkPad users that MUTE toggled bit 6 of EC register 0x30, like every other
ThinkPad have done for over a decade...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
