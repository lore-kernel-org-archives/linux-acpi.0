From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: HT not working by default since 2.4.22
Date: 30 Sep 2003 01:27:32 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1064899651.2532.108.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
	 <3F73EE77.3000906@euronext.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F73EE77.3000906-R6hnfgSw+1uEVqv0pETR8A@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Jan Evert van Grootheest <j.grootheest-R6hnfgSw+1uEVqv0pETR8A@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> Marcelo wrote:

> CONFIG_ACPI_HT should be not dependant on CONFIG_ACPI

FYI,

This fix has been integrated with others in the ACPI patch,
and is available for test now in these bitkeeper trees:

http://linux-acpi.bkbits.net/linux-acpi-test-2.4.22
http://linux-acpi.bkbits.net/linux-acpi-test-2.4.23
http://linux-acpi.bkbits.net/linux-acpi-test-2.6.0

It is also available as a plain patch "CONFIG_ACPI" here:

ftp.kernel.org:/pub/linux/kernel/people/lenb/acpi/patches/test/*
