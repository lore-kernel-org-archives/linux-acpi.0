From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Linux 2.6.24.1  - kernel does not boot; IRQ trouble?
Date: Wed, 27 Feb 2008 08:39:11 +0000 (GMT)
Message-ID: <952958.61284.qm@web52909.mail.re2.yahoo.com>
References: <20080226185216.f298784d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from web52909.mail.re2.yahoo.com ([206.190.49.19]:41096 "HELO
	web52909.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751474AbYB0IjN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Feb 2008 03:39:13 -0500
In-Reply-To: <20080226185216.f298784d.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@linux-foundation.org> wrote:
> You reported this regression nearly a month ago and apart from me flailing
> around nobody has bothered to do the slightest thing about it.

Yes, I've noticed. Am I the only person hitting this then?

> If you can identify the offending commit (see
> http://www.kernel.org/doc/local/git-quick.html) we'll get it working again
> and I really don't care how many commits we have to revert to do it.

I'm not sure about a complete git installation, but I should at least be able to find the last
working 2.6.23-gitX or 2.6.24-rcX-gitY tree. (Assuming that these are the intermediate steps
between 2.6.23 and 2.6.24.)

Cheers,
Chris




      __________________________________________________________
Sent from Yahoo! Mail.
A Smarter Inbox. http://uk.docs.yahoo.com/nowyoucan.html
