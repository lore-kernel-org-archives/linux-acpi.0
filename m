From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Wed, 25 Mar 2015 12:54:25 +0100
Message-ID: <2694196.2XPpkm7uxF@vostro.rjw.lan>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org> <20150324220253.9595AC407F8@trevor.secretlab.ca> <20150325112410.GA24636@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52201 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752526AbbCYLaV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2015 07:30:21 -0400
In-Reply-To: <20150325112410.GA24636@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>"linux-kernel@vger.kernel.org" <linu>

On Wednesday, March 25, 2015 11:24:11 AM Will Deacon wrote:
> On Tue, Mar 24, 2015 at 10:02:53PM +0000, Grant Likely wrote:
> > On Thu, 19 Mar 2015 19:39:27 +0000 , Will Deacon <will.deacon@arm.com>
> > wrote:
> > > On Thu, Mar 19, 2015 at 10:17:27AM +0000, Lorenzo Pieralisi wrote:
> > > > Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
> > > > I am working on it, I do not think it should be a blocking point, patch
> > > > coming asap on top of your series.
> > > 
> > > Well, I don't really want to merge the series without those patches so I
> > > do think it blocks the code from getting into mainline.
> > 
> > Really? It's a pretty minor duplication problem and it's been identified
> > as something requiring refactoring to both the ACPI and DT code. It
> > isn't at all dangerous. Why is this a blocking point?
> 
> Because I don't really see a valid excuse not to get this right first time
> around. Lorenzo already has patches on top, so we just need a co-ordinated
> review effort.
> 
> I wouldn't accept another patch series that needed minor rework (which by
> its very nature is easily addressed), so why should ACPI be treated any
> differently?

Not ACPI, but this particular patchset I think.  The problem is that it has
already been reviewed and ACKed by multiple people and it would be a shame
to require all of those people to do their reviews once again because of
that minor rework (which arguably can be done on top of the patchset just
fine).

Of course, if the minor rework in question would not involve the need to
review things once again, then I agree that it'd be better to do it upfront,
but otherwise there's a good reason not to.

And, as a maintainer, you can always say "Well, I'm taking this conditional on
doing this-and-that on top of it and I won't be taking any more patches from
you in the future if that doesn't happen."


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
