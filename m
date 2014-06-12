From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v2 1/3] Mailbox: Add support for ACPI
Date: Thu, 12 Jun 2014 19:02:53 +0200
Message-ID: <4476889.LvjMyVbGZ8@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org> <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54310 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933648AbaFLRC6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jun 2014 13:02:58 -0400
In-Reply-To: <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, patches@linaro.org, jassisinghbrar@gmail.com, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, broonie@kernel.org

On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
> 
> +#ifndef CONFIG_ACPI
>         if (!mbox->of_xlate)
>                 mbox->of_xlate = of_mbox_index_xlate;
> -
> +#endif
>         mutex_lock(&con_mutex);
>         list_add_tail(&mbox->node, &mbox_cons);
>         mutex_unlock(&con_mutex);
> 

You can't do #ifndef here, the driver must still work if
both OF and ACPI are enabled.

	Arnd
