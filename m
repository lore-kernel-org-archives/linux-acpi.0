From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi on sony vaio vgn-sz61mn
Date: Thu, 18 Jun 2009 08:58:07 +0800
Message-ID: <1245286687.9076.101.camel@rzhang-dt>
References: <4A38F2FA.5000207@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:46835 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbZFRA5X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Jun 2009 20:57:23 -0400
In-Reply-To: <4A38F2FA.5000207@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2009-06-17 at 21:43 +0800, Sebastian Pohl wrote:
> Hello everyone!
>=20
> Thank you to everyone working on the sony stuff! It made my laptop a=20
> much more valuable companion!
>=20
> But there are still some flaws that are left. I am writing to get an=20
> advise what to do with them.=20


>=20
> Ok, the problems are:
>=20
> - The special button s2 generates the same acpi event as the stamina =
switch
> - The lidswitch does not generate any acpi events
> - The Power does not generate any acpi events
>=20
please kill acpid, and run "cat /proc/acpi/event", what do you get when
pressing each of the three buttons?

run "cat /proc/interrupts" both before and after pressing these buttons=
,
does the number of ACPI or sony interrupts increase?
If ACPI interrupts increases, please run
"grep . /sys/firmware/acpi/interrupts/*" and tell us which GPE/Fixed
event is fired.

=EF=BB=BF
> Should i post them to bugtrackter or=20
> something else?
>=20
please file a new bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
and attach all the request info there.
please also attach the acpidump output.

thanks,
rui

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
