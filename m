From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 30 Apr 2008 08:10:35 +0200
Message-ID: <20080430081035.2e789a50@hyperion.delvare>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	<200804182151.49021.lenb@kernel.org>
	<200804231143.10875.maximlevitsky@gmail.com>
	<1209406784.11608.15.camel@localhost>
	<1209474423.1784.837.camel@queen.suse.de>
	<20080429170824.09540206@hyperion.delvare>
	<48179DB4.8040701@assembler.cz>
	<e85b9d30804291558r4051f1bbm9256aa2af2d86b6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:47930 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757438AbYD3GKv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 02:10:51 -0400
In-Reply-To: <e85b9d30804291558r4051f1bbm9256aa2af2d86b6c@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew <jackdachef@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, Maxim Levitsky <maximlevitsky@gmail.com>, trenn@suse.de, Kasper Sandberg <lkml@metanurb.dk>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Wed, 30 Apr 2008 00:58:50 +0200, Matthew wrote:
> so we were just too concerned all the time & even though the
> temperatures seem too high there's nothing to worry ?

Yes.

> I'd be more tranquilized if I had the old temperatures ;)

Note that you can easily get them back by tweaking your sensors.conf
file:

chip "coretemp-*"

    compute temp1 @-15, @+15

But I wouldn't do it, as it doesn't make much sense.

> but like lm_sensors's output states - it's not bad until  I / we're
> getting temperatures from 85=B0C (?) [in this particular case], ...

If I remember correctly, at 84=B0C your CPU will start to throttle, at
100=B0C it will shut down. You still have 24=B0C before the former happ=
ens,
so it should be OK.

--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
