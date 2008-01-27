From: Mattia Dongili <malattia@linux.it>
Subject: Re: sony-laptop on AR series
Date: Sun, 27 Jan 2008 21:50:02 +0900
Message-ID: <20080127125001.GA335@inferi.kami.home>
References: <17b35fe50801230233jda8e183qf380ec153c26020c@mail.gmail.com> <20080126035059.GA24583@inferi.kami.home> <17b35fe50801260746g3d593651h50a273913dcd1642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:38501 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbYA0MuQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 07:50:16 -0500
Content-Disposition: inline
In-Reply-To: <17b35fe50801260746g3d593651h50a273913dcd1642@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: eaglex <eaglex@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, Jan 26, 2008 at 05:46:59PM +0200, eaglex wrote:
> > Could you send the output of lspci and upload somewhere the DSDT (or
> > send me provately as I'm not sure about the limits for postings to this
> > list).
> 
> lspci: http://pastebin.ca/873456
> dsdt: http://pastebin.ca/873459

01:00.0 VGA compatible controller: nVidia Corporation G86M [GeForce 8400M GT] (rev a1)

eh... this is known not to be working with sony-laptop. Even though the
DSDT exposes the brightness methods the nvidia cards have their own way
to handle dimming the screen.
You can try with nvclock which works for *some* cards.

For now all sony-laptop can do is enable the Fn keys, I'll add your
model to the DMI list asap.

ciao
-- 
mattia
:wq!
