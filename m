From: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Mon, 4 Jun 2007 11:13:31 +0200
Message-ID: <20070604091331.GB4802@suse.de>
References: <200705202350.45145.lenb@kernel.org> <20070521121048.GA8332@elf.ucw.cz> <20070521132711.GA7540@srcf.ucam.org> <20070521132948.GD8332@elf.ucw.cz> <20070521133608.GB7540@srcf.ucam.org> <20070521134046.GE8332@elf.ucw.cz> <20070521134553.GA7911@srcf.ucam.org> <20070521224200.GF10714@elf.ucw.cz> <20070522003153.GA18162@srcf.ucam.org> <20070522090636.GO10714@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50366 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbXFDJXk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2007 05:23:40 -0400
Content-Disposition: inline
In-Reply-To: <20070522090636.GO10714@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, trenn@suse.de, Chuck Ebbert <cebbert@redhat.com>, len.brown@intel.com, Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org

On Tue, May 22, 2007 at 11:06:36AM +0200, Pavel Machek wrote:
=20
> We need to ignore trip point updates from BIOS, and we need to poll
> thermals when use overrides trip points. That's expected. Plus I've
> yet to see platform actually updating the trip points.

Thinkpad 600, whenever a trip point is crossed, all trip points are upd=
ated.
I think they implemented hysteresis that way.
ISTR that hp nx5000 did something similar, but i might be wrong on this=
 one.
--=20
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out."=
=20

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
