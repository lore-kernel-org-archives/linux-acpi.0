From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sat, 06 Sep 2003 16:47:11 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1062863230.2795.1.camel@dhcp23.swansea.linux.org.uk>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	 <200309060016.16545.adq_dvb@lidskialf.net> <3F590E28.6090101@pobox.com>
	 <200309060157.47121.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200309060157.47121.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
To: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Cc: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, torvalds-3NddpPZAyC0@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sad, 2003-09-06 at 01:57, Andrew de Quincey wrote:
> This patch removes some erroneous code from mpparse which breaks IO-APIC programming

These shouldnt be removed but checked against the arch being an E7000,
which does need this.
