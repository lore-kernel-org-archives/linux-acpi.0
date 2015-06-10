From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT v2 34/48] pinctrl: Prepare for killing the first parameter
 'irq' of irq_flow_handler_t
Date: Wed, 10 Jun 2015 15:14:06 +0200
Message-ID: <CACRpkdZUD3VQkrT1JReiKvM1SZf_nJiN-=JNZoyMJjK0MGefuQ@mail.gmail.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
	<1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33817 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933438AbbFJNOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2015 09:14:08 -0400
Received: by oigz2 with SMTP id z2so31856277oig.1
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jun 2015 06:14:06 -0700 (PDT)
In-Reply-To: <1433391238-19471-35-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Heiko Stuebner <heiko@sntech.de>, Barry Song <baohua@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Bin Shi <Bin.Shi@csr.com>, Fan Wu <fwu@marvell.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Barry Song <Baohua.Song@csr.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Jun 4, 2015 at 6:13 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:

> Change irq flow handler to prepare for killing the first parameter 'irq'
> of irq_flow_handler_t.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
