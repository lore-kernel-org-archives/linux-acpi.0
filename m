From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch] acpi: fix drivers/acpi/glue.c build error
Date: Wed, 30 Apr 2008 15:17:55 -0700
Message-ID: <200804301517.56249.david-b@pacbell.net>
References: <200804301420.11696.lenb@kernel.org> <20080430205615.GA23694@elte.hu> <20080430210026.GA24121@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:44376 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759443AbYD3WR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 18:17:58 -0400
In-Reply-To: <20080430210026.GA24121@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org

On Wednesday 30 April 2008, Ingo Molnar wrote:
> Subject: acpi: fix drivers/acpi/glue.c build error
> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed Apr 30 22:56:57 CEST 2008
>=20
> x86.git testing found the following build bug:
>=20
> =A0 drivers/built-in.o: In function `acpi_rtc_init':
> =A0 glue.c:(.init.text+0x16c3): undefined reference to `pnp_bus_type'
>=20
> this tries to use PNP bus infrastructure even in the !PNP case.

Broken config, yes?  ACPI selects PNP ...
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
