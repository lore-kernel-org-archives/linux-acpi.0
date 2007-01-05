From: Len Brown <lenb@kernel.org>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Fri, 5 Jan 2007 12:02:30 -0500
Message-ID: <200701051202.31208.lenb@kernel.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <1167946596.6816.7.camel@hughsie-laptop> <20070104215810.GE25619@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44494 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161156AbXAEREW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 12:04:22 -0500
In-Reply-To: <20070104215810.GE25619@inferi.kami.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Richard Hughes <hughsient@gmail.com>, Andrew Morton <akpm@osdl.org>, Stelian Pop <stelian@popies.net>, Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>

> > Well, HAL has used it for changing the brightness for the last year or
> > so: /proc/acpi/sony/brightness
> > 
> > Although if you use a new enough HAL (CVS), the laptop will be supported
> > via the shiny new backlight class.
> 
> great, -mm already has the /sys/class/backlight in place for sony_acpi
> and I suppose the /proc entry can be kept until 2.6.20 is released, i.e.
> just before pushing things for .21.
> 
> Len, would you allow it?

Sure, no problem.
Checking it into my tree with /proc/acpi/sony is
no different than what is in -mm today.

When we push upstream, however, the /proc/acpi/sony part should be gone,
or at least scheduled for removal.

I suggest a sub CONFIG option under CONFIG_SONY_ACPI, say,
CONFIG_SONY_ACPI_PROCFS so you can #ifdef the code that
is going away.

thanks for stepping forward Mattia,
-Len
 
