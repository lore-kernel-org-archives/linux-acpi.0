From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [patch 2/2] ACPI, extlog: remove unneeded NULL check
Date: Wed, 6 Nov 2013 14:45:18 -0800
Message-ID: <CA+8MBb+5-o=XoWb61q7FkbhGK-LWTbRyxgSVK+Rb0a1U20nAcw@mail.gmail.com>
References: <20131105202007.GB3949@elgon.mountain>
	<4572462.cKQzNDzG5Z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:44783 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053Ab3KFWpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 17:45:19 -0500
In-Reply-To: <4572462.cKQzNDzG5Z@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Len Brown <lenb@kernel.org>, Gong <gong.chen@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Wed, Nov 6, 2013 at 2:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I'm wondering what kernel you have checked, because drivers/acpi/acpi_extlog.c
> is not present in the mainline or even in linux-next?

It's in the "tip" tree ... and seems to be in next-20131106

-Tony
