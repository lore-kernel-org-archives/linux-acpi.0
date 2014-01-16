From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
Date: Thu, 16 Jan 2014 11:55:26 +0100
Message-ID: <201401161155.27592.arnd@arndb.de>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
 <15081767.3kxW799CSQ@wuerfel> <52D7414C.7080206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52D7414C.7080206@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Al Stone <al.stone@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 16 January 2014, Al Stone wrote:
> On 01/14/2014 02:26 PM, Arnd Bergmann wrote:
> > On Tuesday 14 January 2014 13:37:02 al.stone@linaro.org wrote:
> >> +config ACPI_REDUCED_HARDWARE_ONLY
> >> +       bool "Hardware-reduced ACPI support only"
> >> +       def_bool n
> >> +       depends on ACPI && EXPERT
> >
> > I think this will cause a Kconfig warning if you try to select this
> > on ARM64 without turning on EXPERT as well.
> >
> > It should be ok if you express it as
> >
> > config ACPI_REDUCED_HARDWARE_ONLY
> >         bool "Hardware-reduced ACPI support only" if EXPERT
> >         def_bool n
> >         depends on ACPI
> >
> >
> >       Arnd
> >
> 
> I am very puzzled.  I went back and re-did my configs from
> before, tried a few new ones, and tried with both expressions
> above, but I could not get a Kconfig warning.  Do you have an
> example .config that shows the warning?
> 

I don't have a source tree that allows turning on ACPI on arm64
to easily test this. To clarify: the warning will only happen if
you also add this piece to arch/arm64/Kconfig:

	select ACPI_REDUCED_HARDWARE_ONLY if ACPI

	Arnd
