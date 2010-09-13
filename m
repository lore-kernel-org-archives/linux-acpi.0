From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] acpi: Fix warning: 'num_cpus' may be used
 uninitialized in this function
Date: Mon, 13 Sep 2010 18:01:27 -0300
Message-ID: <20100913210127.GA7679@khazad-dum.debian.net>
References: <20100911062254.GA18705@mail.gmail.com>
 <20100911062437.GA18711@mail.gmail.com>
 <20100911164037.GB12989@khazad-dum.debian.net>
 <20100913003937.GA1457@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60170 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895Ab0IMVBb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Sep 2010 17:01:31 -0400
Content-Disposition: inline
In-Reply-To: <20100913003937.GA1457@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Sacren <sakiwit@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, 12 Sep 2010, Jean Sacren wrote:
> On Sat, Sep 11, 2010 at 01:40:37PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sat, 11 Sep 2010, Jean Sacren wrote:
> > > warning: 'num_cpus' may be used uninitialized in this function
> > > 
> > > Initialize 'num_cpus' variable to zero so that gcc doesn't complain.
> > 
> > acpi_pad_pur() is referenced only once, so it should end up inlined, at
> > which point gcc really has no excuse to not determine with perfect
> > confidence whether num_cpus is being used unitialized or not.
> >
> If acpi_pad_pur() is called and returns with non-zero value,
> acpi_pad_handle_notify() happily returns, but num_cpus is referenced by
> address without being initialized, so gcc gives the warning.
> > 
> > Looking at the code, it realy does look like a false positive.
> >
> Unfortunately it is _not_ a false positive. Here gcc does what it's
> supposed to do. Therefore, the patch is correct.

It will be a false positive if the variable is NOT used unitialized.
Passing a reference does not access the object, and acpi_pad_pur() is not a
black box to the optimizer (all static, all in the same file, and it is
being inlined even...)

I don't think num_cpus is being used unitialized, so, as far as I can tell,
it is a false positive.  gcc should not have issued that warning.

I don't object to the patch, btw.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
