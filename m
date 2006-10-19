From: Dave Jones <davej@redhat.com>
Subject: Re: SMP broken on pre-ACPI machine.
Date: Wed, 18 Oct 2006 23:04:44 -0400
Message-ID: <20061019030444.GA29453@redhat.com>
References: <20061018222433.GA4770@redhat.com> <1161215287.17601.6.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46034 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030293AbWJSDEx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Oct 2006 23:04:53 -0400
Content-Disposition: inline
In-Reply-To: <1161215287.17601.6.camel@localhost.portugal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: acpi devel <linux-acpi@vger.kernel.org>

On Thu, Oct 19, 2006 at 12:48:07AM +0100, Sergio Monteiro Basto wrote:
 > On Wed, 2006-10-18 at 18:24 -0400, Dave Jones wrote:
 > > I've been chasing a bug that got filed against the Fedora kernel
 > > a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=199052
 > > This is a dual pentium pro from an era before we had ACPI, and
 > > it seems to be falling foul of this test in smpboot.c  ..
 > > 
 > >     if (!smp_found_config && !acpi_lapic) {
 > >         printk(KERN_NOTICE "SMP motherboard not detected.\n");
 > > 
 > > My initial reaction is that the !acpi_lapic test should be conditional
 > > on some variable that gets set if the ACPI parsing actually succeeded.
 > 
 > acpi=off ?

This is irrelevant. There are no acpi tables, so acpi will disable itself.

 > this machine should work with APM.

Also irrelevant, as power management isn't the problem here.

 > BTW, so time ago, this
 > machine would enter in ACPI blacklist (by the year of bios) and ACPI was
 > turned off automatically. 

Finally, this machine has no DMI tables, so date blacklists are also useless.
(Not that it matters anyway due to the lack of ACPI tables)

	Dave

-- 
http://www.codemonkey.org.uk
