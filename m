From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [PATCH] ACPI / battery: ensure acpi_battery_init() has finish
Date: Sat, 16 May 2015 00:09:37 +0100
Message-ID: <20150515230937.GA2537@charon>
References: <1431380945-2923-1-git-send-email-luis.henriques@canonical.com>
 <2846184.p0deZ4nZzp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:46410 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992464AbbEOXJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 May 2015 19:09:43 -0400
Content-Disposition: inline
In-Reply-To: <2846184.p0deZ4nZzp@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 15, 2015 at 01:59:24AM +0200, Rafael J. Wysocki wrote:
> On Monday, May 11, 2015 10:49:05 PM Luis Henriques wrote:
> > Make sure that async function scheduled with async_schedule() has a=
lready
> > been executed.
> >=20
> > Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
>=20
> Queued up for 4.2 (along with the other two battery patches of yours)=
, thanks!
>=20

Awesome, thanks!

Cheers,
--
Lu=EDs
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
