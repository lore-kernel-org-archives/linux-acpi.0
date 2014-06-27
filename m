From: Graeme Gregory <gg@slimlogic.co.uk>
Subject: Re: [PATCH v4 06/13] ARM64 / ACPI: Introduce early_param for "acpi"
Date: Fri, 27 Jun 2014 11:57:05 +0100
Message-ID: <20140627105705.GA5677@xora-haswell.xora.org.uk>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-7-git-send-email-hanjun.guo@linaro.org>
 <23398804.v8nA0xfjOe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <23398804.v8nA0xfjOe@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com, rric@kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 27, 2014 at 11:07:48AM +0200, Arnd Bergmann wrote:
> On Friday 27 June 2014 11:49:29 Hanjun Guo wrote:
> > +
> > +static int __init parse_acpi(char *arg)
> > +{
> > +       if (!arg)
> > +               return -EINVAL;
> > +
> > +       /* "acpi=off" disables both ACPI table parsing and interpreter */
> > +       if (strcmp(arg, "off") == 0) {
> > +               disable_acpi();
> > +       }
> > +       /* acpi=strict disables out-of-spec workarounds */
> > +       else if (strcmp(arg, "strict") == 0) {
> > +               acpi_strict = 1;
> > +       } else {
> > +               /* Core will printk when we return error */
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +early_param("acpi", parse_acpi);
> 
> Can you explain in the changelog what happens for the acpi=off case? Does this
> mean we fall back to using data from the dtb instead, or will it just not work?
> 
> If I understand correctly, this option makes sense on PC systems that will
> still be able to boot using the legacy BIOS services and implicit assumptions
> about the hardware, but that never works on arm64.
> 
Yes the way ACPI has been integrated on ARM64 in these patches if you
supply acpi=off it will fall back to DTB if supplied by firmware.

Graeme
