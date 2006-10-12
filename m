From: "Mathew Brown" <mathewbrown@fastmail.fm>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 09:51:13 -0700
Message-ID: <1160671873.29653.273188134@webmail.messagingengine.com>
References: <1160663160.13196.273175261@webmail.messagingengine.com>
   <200610121646.19668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:63709 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932689AbWJLQvM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 12:51:12 -0400
Content-Disposition: inline
In-Reply-To: <200610121646.19668.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Thanks for your reply Rafael.  However, I was looking for a generic
solution.  I don't have an nx6325 but was thinking of purchasing a
laptop and was afraid that ACPI could damage / overheat by CPUs.  I
think the link you provided is specific to the nx6325 unless I'm
mistaken.  Is there any generic solution?  Would recompiling the DSDT
and re-inserting it guarantee that no overheat / damage happens
regardless of the laptop / machine?  Thanks.


On Thu, 12 Oct 2006 16:46:19 +0200, "Rafael J. Wysocki" <rjw@sisk.pl>
said:
> On Thursday, 12 October 2006 16:26, Mathew Brown wrote:
> > Hi,
> >   I've been reading an alarming article on getting Gentoo to work on the
> >   HP Compaq nx6325
> >   (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
> >   serious ACPI problems that were encountered.  The author states after
> >   mentioning how to apply certain patches, "Without that, the CPU might
> >   overheat and get damaged during heavy load (such as compiling a Gentoo
> >   stage ...)!"
> > 
> >   What would be the safest way to ensure that ACPI doesn't do this to
> >   your machine / laptop without disabling ACPI?  Would recompiling the
> >   DSDT using the Intel compiler and re-inserting it be enough to ensure
> >   that ACPI doesn't cause your CPU to overheat or get damaged?  Thanks
> >   for your help.
> 
> Please see http://bugzilla.kernel.org/show_bug.cgi?id=7122, especially
> http://bugzilla.kernel.org/show_bug.cgi?id=7122#c27 and below.
> 
> Greetings,
> Rafael
> 
> 
> -- 
> You never change things by fighting the existing reality.
> 		R. Buckminster Fuller
-- 
  Mathew Brown
  mathewbrown@fastmail.fm

-- 
http://www.fastmail.fm - A fast, anti-spam email service.

