From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Idle loop causes speaker whine/buzz (!)
Date: Tue, 23 Jan 2007 19:00:42 -0200
Message-ID: <20070123210042.GE32032@khazad-dum.debian.net>
References: <20070123104010.GB7135@fscked.org> <20070123122925.GA27150@tangens.sinus.cz> <20070123194509.GA8644@fscked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53118 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965038AbXAWVAz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Jan 2007 16:00:55 -0500
Content-Disposition: inline
In-Reply-To: <20070123194509.GA8644@fscked.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mike Perry <mikepery@fscked.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 23 Jan 2007, Mike Perry wrote:
> Is there currently any way to disable busmastering or C3 transitions
> (without recompilation)? Or better: is it possible to make the system
> less eager to transition into C3 or otherwise reduce the frequency of
> these transitions? If I could just get the frequency of transitions to
> get out of the audible range, my life would be a lot better.

Read http://thinkwiki.org/wiki/Problem_with_high_pitch_noises, it may have
the answers.

> Please understand it really is quite annoying, and I doubt the
> manufacturer is going to have any mercy because their Windows install
> doesn't have the problem..

If Windows is doing as aggressive power management as Linux, or even more
aggressive power management, then we ought to find out what they're doing
that is different and doesn't cause the noise.  If it is just less
aggressive power management, well, let's hope this changes soon.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
