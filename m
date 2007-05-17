From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Thu, 17 May 2007 15:17:13 -0400
Message-ID: <200705171517.14087.lenb@kernel.org>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <464B43BB.3070505@redhat.com> <20070517092318.GD3975@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38927 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270AbXEQTT6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 15:19:58 -0400
In-Reply-To: <20070517092318.GD3975@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

On Thursday 17 May 2007 05:23, Pavel Machek wrote:

> >     ACPI: thermal trip points are read-only
> 
> What was the rationale? Can we get this one reverted? 
> 
> Some machines (HP omnibook xe3) have broken trip points -- too high --
> so machine will overheat and trigger hw shutdown before starting
> passive cooling.
> 
> That's really broken, and write to trip points is reasonable way to
> 'fix' that. (I'd understand if you only ever let trip points to
> decrease... but otoh root should be able to shoot himself....)

No, writing trip-points is neither a fix, nor it is reasonable.
It is a workaround at best, and it is a dangerous and mis-leading hack.

The OS has no capability to actually change the ACPI trip points
that are used by the BIOS.  Changing the OS copy of them
to make the user think that trip events will actually
happen when the temperature crosses the OS copy is crazy.

If there are systems with broken thermals and the
ACPI thermal control needs and over-ride to turn
on the fan, then that is fine -- but using
fake trip-points and giving the user the impression
that they are real is not viable.

-Len
