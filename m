From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 21:34:30 +0200
Message-ID: <200610122134.30975.rjw@sisk.pl>
References: <1160663160.13196.273175261@webmail.messagingengine.com> <200610121646.19668.rjw@sisk.pl> <1160671873.29653.273188134@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33465 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750964AbWJLTef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 15:34:35 -0400
In-Reply-To: <1160671873.29653.273188134@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Thursday, 12 October 2006 18:51, Mathew Brown wrote:
> Thanks for your reply Rafael.  However, I was looking for a generic
> solution.  I don't have an nx6325 but was thinking of purchasing a
> laptop and was afraid that ACPI could damage / overheat by CPUs.  I
> think the link you provided is specific to the nx6325 unless I'm
> mistaken.  Is there any generic solution?  Would recompiling the DSDT
> and re-inserting it guarantee that no overheat / damage happens
> regardless of the laptop / machine?

No, it wouldn't, AFAICT.

Greetings,
Rafael


> On Thu, 12 Oct 2006 16:46:19 +0200, "Rafael J. Wysocki" <rjw@sisk.pl>
> said:
> > On Thursday, 12 October 2006 16:26, Mathew Brown wrote:
> > > Hi,
> > >   I've been reading an alarming article on getting Gentoo to work on the
> > >   HP Compaq nx6325
> > >   (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
> > >   serious ACPI problems that were encountered.  The author states after
> > >   mentioning how to apply certain patches, "Without that, the CPU might
> > >   overheat and get damaged during heavy load (such as compiling a Gentoo
> > >   stage ...)!"
> > > 
> > >   What would be the safest way to ensure that ACPI doesn't do this to
> > >   your machine / laptop without disabling ACPI?  Would recompiling the
> > >   DSDT using the Intel compiler and re-inserting it be enough to ensure
> > >   that ACPI doesn't cause your CPU to overheat or get damaged?  Thanks
> > >   for your help.
> > 
> > Please see http://bugzilla.kernel.org/show_bug.cgi?id=7122, especially
> > http://bugzilla.kernel.org/show_bug.cgi?id=7122#c27 and below.
> > 
> > Greetings,
> > Rafael
> > 
> > 
> > -- 
> > You never change things by fighting the existing reality.
> > 		R. Buckminster Fuller
> -- 
>   Mathew Brown
>   mathewbrown@fastmail.fm
> 

-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
