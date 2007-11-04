From: Richard Hughes <hughsient@gmail.com>
Subject: Re: Writing to the EC
Date: Sun, 04 Nov 2007 21:23:08 +0000
Message-ID: <1194211388.2866.12.camel@hughsie-laptop>
References: <472E23BC.2010909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:52106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbXKDVXn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Nov 2007 16:23:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so820209ugc
        for <linux-acpi@vger.kernel.org>; Sun, 04 Nov 2007 13:23:42 -0800 (PST)
In-Reply-To: <472E23BC.2010909@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik =?ISO-8859-1?Q?Andr=E9n?= <erik.andren@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, 2007-11-04 at 20:55 +0100, Erik Andr=C3=A9n wrote:
> The bad part is that writing to the EC using the ec_write function
> doesn't work at all. Sure it completes the operation, but when probin=
g
> the register afterwards, no change of value is seen.

This sounds the same as my Lenovo 3000 N100. If you find out how to do
it - yell - and it's worth many beers.

Richard.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
