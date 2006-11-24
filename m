From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: contents of the acpica branch
Date: Fri, 24 Nov 2006 23:25:48 +0100
Message-ID: <200611242325.49160.rjw@sisk.pl>
References: <1164352755500-git-send-email-len.brown@intel.com> <200611242133.00136.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:20112 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S935101AbWKXWaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 17:30:13 -0500
In-Reply-To: <200611242133.00136.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Robert Moore <robert.moore@intel.com>

On Friday, 24 November 2006 21:32, Rafael J. Wysocki wrote:
> On Friday, 24 November 2006 08:18, Len Brown wrote:
> > 
> > The following patches are on the "acpica" branch of the ACPI git tree.
> 
> #11 seems to be missing, or is it just me who hasn't received it?

I think it is missing.

Moreover, the one available at

http://kernel.org/git/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commitdiff;h=7b3b58eb8bcf2605a809010ad084dab9fa7f58ad

seems to suffer from a mismerge in acpi_status acpi_reallocate_root_table().

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
