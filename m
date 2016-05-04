From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / amba: Remove CLK_IS_ROOT
Date: Wed, 04 May 2016 23:11:51 +0200
Message-ID: <6063910.IepAVZmcQJ@vostro.rjw.lan>
References: <1461115718-31151-1-git-send-email-sboyd@codeaurora.org> <CAGCh1+kxsWTaYpR=qt4FCR3RxO2E7iE4j7_Prcus1CRAbGkGTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGCh1+kxsWTaYpR=qt4FCR3RxO2E7iE4j7_Prcus1CRAbGkGTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: G Gregory <graeme.gregory@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@linaro.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, April 20, 2016 08:28:38 AM G Gregory wrote:
> On 20 April 2016 at 02:28, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> > CLK_IS_ROOT", 2016-02-02) so remove it.
> >
> > Cc: Graeme Gregory <graeme.gregory@linaro.org>
> > Cc: Aleksey Makarov <aleksey.makarov@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/acpi/acpi_amba.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> > index 2a61b54ab968..7f77c071709a 100644
> > --- a/drivers/acpi/acpi_amba.c
> > +++ b/drivers/acpi/acpi_amba.c
> > @@ -35,8 +35,7 @@ static void amba_register_dummy_clk(void)
> >         if (amba_dummy_clk)
> >                 return;
> >
> > -       amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
> > -                                               CLK_IS_ROOT, 0);
> > +       amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
> >         clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
> >  }
> >
> Looks good to me.
> 
> Acked-by: Graeme Gregory <graeme.gregory@linaro.org>

Applied, thanks!
