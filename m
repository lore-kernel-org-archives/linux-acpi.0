From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 08:52:59 -0700
Message-ID: <200809090852.59461.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0809091014010.2486-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:31170 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753151AbYIIQ0N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 12:26:13 -0400
In-Reply-To: <Pine.LNX.4.44L0.0809091014010.2486-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday 09 September 2008, Alan Stern wrote:
> What about case (c): The device uses legacy PM but the wakeup setting=
s=20
> have already been handled by the ACPI AML code? =A0There's no need to=
=20
> clear any extra wakeup-related stuff, but it still is necessary to te=
ll=20
> the driver about the event.

Good question ... best if Intel answers it.  :0


> (As a matter of fact, I have no idea whether or not Intel's legacy PM=
=20
> for UHCI is implemented in AML. =A0It may vary from one BIOS to anoth=
er.)

One data point:  on the laptop used to type this message,
the GPE code block includes stuff like this for each UHCI:

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

Without diving into the ICHx specs (which I believe DO have
such details, thanks be!), my first reaction is that this is
not a "case (c)".  Of course, the rest of the AML code is,
as usual, cryptic (I'd rather have C code), and such stuff
might be hidden elsewhere in the event sequence.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
