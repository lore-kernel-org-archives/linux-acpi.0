From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] ACPI: asus_acpi, support F2JE model
Date: Wed, 11 Apr 2007 13:20:53 -0700
Message-ID: <20070411132053.899462b4.akpm@linux-foundation.org>
References: <2189310342910921713@karneval.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59197 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030470AbXDKUVH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Apr 2007 16:21:07 -0400
In-Reply-To: <2189310342910921713@karneval.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, corentincj@iksaif.net, sziwan@users.sourceforge.net, acpi4asus-user@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org

On Wed, 11 Apr 2007 15:04:35 +0200 (CEST)
Jiri Slaby <jirislaby@gmail.com> wrote:

> @@ -706,6 +718,8 @@ static int get_lcd_state(void)
>  {
>  	int lcd = 0;
>  
> +	BUG_ON(!hotk->methods->lcd_status);

mutter.  We could just warn-and-bale here.

Hopefully this is just an is-jiri-sane assertion and it should never happen,
no matter how busted the BIOS tables are?

If it _does_ ever trigger, well, we just took out someone's machine
quite unnecessarily.
