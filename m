From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 00:16:46 +0100
Message-ID: <201101220016.46227.rjw@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com> <201101212342.01646.rjw@sisk.pl> <AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41229 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab1AUXR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 18:17:29 -0500
In-Reply-To: <AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Friday, January 21, 2011, Linus Torvalds wrote:
> On Fri, Jan 21, 2011 at 2:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > Something like this, perhaps.  It doesn't blow up my Toshiba test box, so
> > hopefully it won't blow up yours ...
> 
> Failed suspend on the very first try..

Well, so it's not this problem (which was a red herring).

I wonder if you can reproduce the failure with the

# echo core > /sys/power/pm_test
# echo mem > /sys/power/state

test?  I think you can even try to run the second command in a tight loop
(the first one simply triggers a switch) and see what happens.

Rafael
