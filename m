From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 4/4] gpio: mb86s7x: enable ACPI support
Date: Thu, 2 May 2019 11:02:55 +0300
Message-ID: <20190502080255.GS26516@lahna.fi.intel.com>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
 <20190429131208.3620-5-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190429131208.3620-5-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org, Masahisa Kojima <masahisa.kojima@linaro.org>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 29, 2019 at 03:12:08PM +0200, Ard Biesheuvel wrote:
> @@ -160,13 +177,15 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
>  	if (IS_ERR(gchip->base))
>  		return PTR_ERR(gchip->base);
>  
> -	gchip->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(gchip->clk))
> -		return PTR_ERR(gchip->clk);
> +	if (!ACPI_COMPANION(&pdev->dev)) {

Since you don't use the returned ACPI object, you can also use
has_acpi_companion(&pdev->dev) here and other similar places.

Regardless of that,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
