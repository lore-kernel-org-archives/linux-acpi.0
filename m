From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Bank screen after resume on Dell XPS M1330
Date: Sun, 3 May 2009 22:59:35 +0100
Message-ID: <20090503215935.GA27257@srcf.ucam.org>
References: <200905031111.50789.arvidjaar@mail.ru> <20090503105932.GA18170@srcf.ucam.org> <20090503215740.GG1368@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59170 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZECV7j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 May 2009 17:59:39 -0400
Content-Disposition: inline
In-Reply-To: <20090503215740.GG1368@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, May 03, 2009 at 11:57:41PM +0200, Pavel Machek wrote:
> On Sun 2009-05-03 11:59:32, Matthew Garrett wrote:
> > On Sun, May 03, 2009 at 11:11:47AM +0400, Andrey Borzenkov wrote:
> > > 01:00.0 VGA compatible controller: nVidia Corporation GeForce 8400M GS 
> > > (rev a1)
> > 
> > We don't know how to reinitialise nvidia graphics hardware.
> 
> s2ram tool and/or Xserver may be able to reinit the video....

Not for current nivida, except for some Thinkpads.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
