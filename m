From: Jean Sacren <sakiwit@gmail.com>
Subject: Re: [PATCH 1/1] acpi: Fix warning: 'num_cpus' may be used
 uninitialized in this function
Date: Sun, 12 Sep 2010 18:39:37 -0600
Message-ID: <20100913003937.GA1457@mail.gmail.com>
References: <20100911062254.GA18705@mail.gmail.com>
 <20100911062437.GA18711@mail.gmail.com>
 <20100911164037.GB12989@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60052 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab0IMAjh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Sep 2010 20:39:37 -0400
Received: by pvg2 with SMTP id 2so1934558pvg.19
        for <linux-acpi@vger.kernel.org>; Sun, 12 Sep 2010 17:39:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100911164037.GB12989@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>

On Sat, Sep 11, 2010 at 01:40:37PM -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 11 Sep 2010, Jean Sacren wrote:
> > warning: 'num_cpus' may be used uninitialized in this function
> > 
> > Initialize 'num_cpus' variable to zero so that gcc doesn't complain.
> 
> acpi_pad_pur() is referenced only once, so it should end up inlined, at
> which point gcc really has no excuse to not determine with perfect
> confidence whether num_cpus is being used unitialized or not.
>
If acpi_pad_pur() is called and returns with non-zero value,
acpi_pad_handle_notify() happily returns, but num_cpus is referenced by
address without being initialized, so gcc gives the warning.
> 
> Looking at the code, it realy does look like a false positive.
>
Unfortunately it is _not_ a false positive. Here gcc does what it's
supposed to do. Therefore, the patch is correct.

-- 
Jean Sacren
Bring LAMP To People
