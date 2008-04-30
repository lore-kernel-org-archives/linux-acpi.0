From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 30 Apr 2008 16:50:59 +0200
Message-ID: <48188753.40305@assembler.cz>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com> <200804182151.49021.lenb@kernel.org> <200804231143.10875.maximlevitsky@gmail.com> <1209406784.11608.15.camel@localhost> <1209474423.1784.837.camel@queen.suse.de> <20080429170824.09540206@hyperion.delvare> <48179DB4.8040701@assembler.cz> <e85b9d30804291558r4051f1bbm9256aa2af2d86b6c@mail.gmail.com> <20080430081035.2e789a50@hyperion.delvare> <20080430144655.GB3543@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ms.trustica.cz ([82.208.32.68]:41341 "EHLO ms.trustica.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757078AbYD3OvN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 10:51:13 -0400
In-Reply-To: <20080430144655.GB3543@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jean Delvare <khali@linux-fr.org>, Matthew <jackdachef@gmail.com>, Maxim Levitsky <maximlevitsky@gmail.com>, trenn@suse.de, Kasper Sandberg <lkml@metanurb.dk>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

>>> but like lm_sensors's output states - it's not bad until  I / we're
>>> getting temperatures from 85=B0C (?) [in this particular case], ...
>> If I remember correctly, at 84=B0C your CPU will start to throttle, =
at
>> 100=B0C it will shut down. You still have 24=B0C before the former h=
appens,
>> so it should be OK.

The high limit is when the all fans should go max. Throttle is at crit.

Rudolf
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
