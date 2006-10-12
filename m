From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Preventing ACPI from Damaging Your CPU
Date: Thu, 12 Oct 2006 16:46:19 +0200
Message-ID: <200610121646.19668.rjw@sisk.pl>
References: <1160663160.13196.273175261@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:61366 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932516AbWJLOq3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Oct 2006 10:46:29 -0400
In-Reply-To: <1160663160.13196.273175261@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Thursday, 12 October 2006 16:26, Mathew Brown wrote:
> Hi,
>   I've been reading an alarming article on getting Gentoo to work on the
>   HP Compaq nx6325
>   (http://gentoo-wiki.com/HARDWARE_Gentoo_on_HP_Compaq_nx6325) and the
>   serious ACPI problems that were encountered.  The author states after
>   mentioning how to apply certain patches, "Without that, the CPU might
>   overheat and get damaged during heavy load (such as compiling a Gentoo
>   stage ...)!"
> 
>   What would be the safest way to ensure that ACPI doesn't do this to
>   your machine / laptop without disabling ACPI?  Would recompiling the
>   DSDT using the Intel compiler and re-inserting it be enough to ensure
>   that ACPI doesn't cause your CPU to overheat or get damaged?  Thanks
>   for your help.

Please see http://bugzilla.kernel.org/show_bug.cgi?id=7122, especially
http://bugzilla.kernel.org/show_bug.cgi?id=7122#c27 and below.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
