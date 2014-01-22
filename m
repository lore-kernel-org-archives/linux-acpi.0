From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
Date: Wed, 22 Jan 2014 11:46:16 +0000
Message-ID: <20140122114616.GB15591@e106331-lin.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <201401171521.35940.arnd@arndb.de> <52DCE790.6080809@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <52DCE790.6080809@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "patches@linaro.org" <patches@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Ch>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 20, 2014 at 09:08:32AM +0000, Hanjun Guo wrote:
> On 2014-1-17 22:21, Arnd Bergmann wrote:
> > On Friday 17 January 2014, Hanjun Guo wrote:
> >>
> >> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>
> >> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> >> name from the ACPI timer table is matched with all the registered
> >> timer controllers and matching initialisation routine is invoked.
> > 
> > I wouldn't anticipate this infrastructure to be required. Shouldn't all
> > ARMv8 machines have an architected timer?
> 
> I not sure of this, could anyone can give some guidance? if only arch
> timer is available for ARM64, this will make thing very simple.

All ARMv8 systems should have an architected timer.

However, they may also have other timers (e.g. global timers for use
when CPUs are in low power states and their local architected timers
aren't active).

Thanks,
Mark.
