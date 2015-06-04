From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFT v2 32/48] mfd: Prepare for killing the first parameter
 'irq' of irq_flow_handler_t
Date: Thu, 4 Jun 2015 08:14:35 +0100
Message-ID: <20150604071435.GB22293@x1>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
 <1433391238-19471-33-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33990 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbFDHOl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2015 03:14:41 -0400
Received: by wgv5 with SMTP id 5so26252786wgv.1
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2015 00:14:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433391238-19471-33-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Samuel Ortiz <sameo@linux.intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

> Change irq flow handler to prepare for killing the first parameter 'i=
rq'
> of irq_flow_handler_t.
>=20
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/mfd/ucb1x00-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
> index 58ea9fdd3a15..08ce1dad4167 100644
> --- a/drivers/mfd/ucb1x00-core.c
> +++ b/drivers/mfd/ucb1x00-core.c
> @@ -292,7 +292,7 @@ static void ucb1x00_irq(unsigned int irq, struct =
irq_desc *desc)
>  	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, isr);
>  	ucb1x00_reg_write(ucb, UCB_IE_CLEAR, 0);
> =20
> -	for (i =3D 0; i < 16 && isr; i++, isr >>=3D 1, irq++)
> +	for (i =3D 0; i < 16 && isr; i++, isr >>=3D 1)
>  		if (isr & 1)
>  			generic_handle_irq(ucb->irq_base + i);
>  	ucb1x00_disable(ucb);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
