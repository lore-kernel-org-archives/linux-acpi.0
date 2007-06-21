From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 07:48:47 -0700
Message-ID: <200706210748.48781.david-b@pacbell.net>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com> <200706210004.03544.david-b@pacbell.net> <200706211442.41140.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28010 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752856AbXFUPha (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jun 2007 11:37:30 -0400
In-Reply-To: <200706211442.41140.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>

On Thursday 21 June 2007, Rafael J. Wysocki wrote:
> The issue at hand is that some device drivers may need to know what t=
he
> target sleep state of the system will be when their .suspend() routin=
es are
> being executed. =A0Currently, there's no means of passing that inform=
ation to the
> drivers and my question is how to do this.

Actually what they need to know is some *attribute* of that state.

They really don't care what the state is.  The $SUBJECT patch isn't
driver code ... it's for platform hooks that expose attributes to
the drivers.  Specifically, it's ACPI code, talking to drivers that
must run on non-ACPI systems.  Any driver that thinks it needs to
understand anything about ACPI states is sadly broken.

Remember also that the Linux "states" (in /sys/power/state) are an
inadequate representation of what most hardware can do.  Common
hardware can support a lot more low power sleep modes than the two
states Linux currently defines ... a limitation inherited from
first APM, and them more recently ACPI, which doesn't fit embedded
systems well at all.

- Dave


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
