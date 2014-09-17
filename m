From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 18/18] Documentation: ACPI for ARM64
Date: Wed, 17 Sep 2014 21:37:42 +0200
Message-ID: <4416582.iOjLNrLDZE@vostro.rjw.lan>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org> <20140917014410.GC31214@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rd>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, September 17, 2014 02:44:10 AM Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> 
> > +Common _DSD bindings should be submitted to ASWG to be included in the
> > +document :-
> > +
> > +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm

Well, the intention here is different.

The linked document is supposed to define the format of data to be returned
by _DSD and the one at:

http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf

does it specifically for the UUID associated with the DT bindings format.

There are no implied IP issues with using the information there I know of and
if there's any fine print anywhere that may suggest so, please let me know.

That said, those documents are not intended to be libraries of actual bindings.

A common place for the binding and a process for submitting/accepting them is
needed, but we are yet to agree on how to do that.

Rafael
