From: Timo Hoenig <thoenig@suse.de>
Subject: Re: [Acpi4asus-user] [patch 1/6] asus_acpi: W3000 support
Date: Sun, 02 Jul 2006 12:33:28 +0200
Message-ID: <1151836408.25852.15.camel@nouse.suse.de>
References: <CFF307C98FEABE47A452B27C06B85BB6E16B8A@hdsmsx411.amr.corp.intel.com>
	 <20060630193130.GA11609@hell.org.pl>
	 <1151765434.30054.9.camel@nouse.suse.de> <1151793983.27214.4.camel@frolic>
	 <1151795155.30054.25.camel@nouse.suse.de>
	 <20060701163502.6a87e01a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:23773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932235AbWGBKdw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Jul 2006 06:33:52 -0400
In-Reply-To: <20060701163502.6a87e01a.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, acpi4asus-user@lists.sourceforge.net, acpi4asus-list@cerqueira.org, linux-acpi@vger.kernel.org, sziwan@hell.org.pl, marekw1977@yahoo.com.au

Hi Andrew,

On Sat, 2006-07-01 at 16:35 -0700, Andrew Morton wrote:

> On Sun, 02 Jul 2006 01:05:55 +0200
> Timo Hoenig <thoenig@suse.de> wrote:
> 
> > Hi Ricardo,
> > 
> > On Sat, 2006-07-01 at 23:46 +0100, R Cerqueira wrote:
> > 
> > > Since we're talking about applying patches, it would be nice if the W5F
> > > patch I sent to the list back on April 26th could go in as well.
> > 
> > Patches sent to the acpi4asus list should be reviewed there and
> > afterwards sent to linux-acpi.  As there was no reply to your mail on
> > acpi4asus it got lost.
> > 
> > > Anything wrong with it?
> > 
> > Just had a short look at it and it looks fine to me.  You may probably
> > want to re-diff against Len's tree as I haven't checked if it still
> > applies cleanly.
> > 
> 
> I'm carrying this version, whcih applies and builds OK.
> 
> From: Marek W <marekw1977@yahoo.com.au>
> 
> Add support for W3000 (W3V) and indirectly fixes an issue with kmilo under KDE
> (it was triggering excessive LCD read error messages by querying asus_acpi
> module) allowing people (I am probably the only one who tested this) with
> W3000 to run kmilo.
> 
> Cc: Karol Kozimor <sziwan@hell.org.pl>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

That is not the patch Ricardo was referring to.  There is yet another
patch pending to support his ASUS W5F (not W3V).

To avoid further confusion I'll send more model updates for the driver
to Karol and ask him to submit a cumulative patch.

   Timo

