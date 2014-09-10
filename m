From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 04/17] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Wed, 10 Sep 2014 19:30:03 +0100
Message-ID: <20140910183003.GN1710@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-5-git-send-email-hanjun.guo@linaro.org>
 <CAErSpo6G89mkPgas8Wk3ofq__dUo5MKvBjob5D_w5_GaBJWH0w@mail.gmail.com>
 <540F7BE2.8060403@redhat.com>
 <20140910130419.GJ28488@arm.com>
 <CAErSpo58eWadcyTrsBPAa-QFNmWn5jO7yQGc=N6F6PgNXnXcJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36533 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044AbaIJSaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2014 14:30:05 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo58eWadcyTrsBPAa-QFNmWn5jO7yQGc=N6F6PgNXnXcJA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "jcm@redhat.com" <jcm@redhat.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On Wed, Sep 10, 2014 at 02:21:59PM +0100, Bjorn Helgaas wrote:
> On Wed, Sep 10, 2014 at 7:04 AM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > It's blindingly obvious that acpi=off is there to disable ACPI at boot.
> > We either support that option or we don't -- none of this `oh, well you
> > can use it in this specific case I suppose' rubbish. I'm not questioning
> > your use-case, but there's really no need to talk about an `orderly
> > adoption' when all you need to say is that your ACPI is busted and passing
> > acpi=off lets you boot with a devicetree.
> 
> Maybe we should set a taint bit or give some other indication that
> we're using a flag to work around breakage.

That sounds like a good idea. Working around breakage is a fact of life,
but the taint indicates that it's not the ideal behaviour.

Will
