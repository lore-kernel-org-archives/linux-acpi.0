From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Toggling VGA out on Eee 901
Date: Thu, 18 Sep 2008 10:47:05 +0800
Message-ID: <1221706025.3441.164.camel@rzhang-dt>
References: <1221601392651@dmwebmail.dmwebmail.chezphil.org>
	 <1221630423.3441.147.camel@rzhang-dt>  <48D0E175.4080107@chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:38614 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbYIRCrl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Sep 2008 22:47:41 -0400
In-Reply-To: <48D0E175.4080107@chezphil.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Phil Endecott <phil_hmpau_endecott@chezphil.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

On Wed, 2008-09-17 at 18:52 +0800, Phil Endecott wrote:
> Hi Rui,
>=20
> Zhang Rui wrote:
> > Hi, phil,
> >
> > On Tue, 2008-09-16 at 22:43 +0100, Phil Endecott wrote:
> >> Dear Experts,
> >>
> >> I'm trying to work out how to get console video out toggling
> working on
> >> my ASUS EEE 901 (running Debian).  I get the feeling that I may be
> the
> >> first person to try to do this, and I knew almost nothing about
> ACPI
> >> until a couple of hours ago.  Can anyone help?
> >> Output toggling for X works fine, but that doesn't use ACPI.
>=20
> > =EF=BB=BFwell, ACPI control method for video output switching seldo=
m works.
> > And we use xrandr to switch the display in X.
> > I'm not sure but I'm afraid we don't have the plan to support video
> > output switch in console mode.
>=20
> As far as I can see, the code already exists in the kernel to support
> this.  The problem is that this BIOS doesn't define the necessary
> methods (unless I've misunderstood something).
it's true that there is some code that is used for display switch in
ACPI video driver.
It evaluates the ACPI control methods to switch the display, but
unfortunately we don't have any BIOSes that these methods actually
work...

>   When you say "don't plan
> to support", do you mean that the existing kernel functionality is no=
w
> deprecated,
right.
I've sent a patch to remove this piece of code sometime before...

BTW: forgot to mention, the platform drivers may have the ability to
switch the display via some platform specific methods, but that depends=
=2E
and it's beyond my scope. :).
I can only say that display switching via the predefined ACPI control
methods doesn't work.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
