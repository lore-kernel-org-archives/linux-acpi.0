From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 14:27:26 +0900
Message-ID: <aec7e5c30906102227o18ca40b9w90e889dbdb43464f@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906101656100.2589-100000@iolanthe.rowland.org>
	 <200906102331.14267.rjw@sisk.pl>
	 <200906110115.30729.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:8885 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZFKF1Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2009 01:27:25 -0400
In-Reply-To: <200906110115.30729.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jun 11, 2009 at 8:15 AM, Oliver Neukum<oliver@neukum.org> wrote=
:
> Am Mittwoch, 10. Juni 2009 23:31:13 schrieb Rafael J. Wysocki:
>> > > +/**
>> > > + * pm_check_children - Check if all children of a device have b=
een
>> > > suspended. + * @dev: Device to check.
>> > > + *
>> > > + * Returns 0 if all children of the device have been suspended =
or
>> > > -EBUSY + * otherwise.
>> > > + */
>> >
>> > We might want to do a runtime suspend even if the device's childre=
n
>> > aren't already suspended. =A0For example, you could suspend a link=
 while
>> > leaving the device on the other end of the link at full power --
>> > especially if powering down the device is slow but changing the li=
nk's
>> > power level is fast.
>>
>> Well, this means that the dependencies between devices in the device=
 tree
>> are pretty much useless for the run-time PM as far as the core is
>> concerned. =A0In which case, why did you mention them at all?
>
> Some bussystems need this constraint others don't or only for some no=
des.
> We need a way to communicate this to the core.

I agree that this depends on the bus.

Our SuperH on-chip SoC platform devices are arranged in a flat fashion
so no real problem there, but if there whould be dependencies then I
think we need to manage it recursively somehow.

Compare that to PM of our I2C driver and the I2C bus hanging off from
that. In that case I'd like to be able to autosuspend the I2C master
driver regardless of the I2C slave devices and their PM state.

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
