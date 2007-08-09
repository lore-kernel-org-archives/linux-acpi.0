From: Len Brown <lenb@kernel.org>
Subject: Re: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 18:49:54 -0400
Message-ID: <200708091849.54850.lenb@kernel.org>
References: <20070809123943.GD3939@ngolde.de> <200708091202.54943.lenb@kernel.org> <20070809174528.GA7282@ngolde.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35729 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757368AbXHIWuA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 18:50:00 -0400
In-Reply-To: <20070809174528.GA7282@ngolde.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nico Golde <nion@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Thursday 09 August 2007 13:45, Nico Golde wrote:
> Hi,
> * Len Brown <lenb@kernel.org> [2007-08-09 19:25]:
> > I have to second what Henrique wrote.
> > Please avoid /proc/acpi/* whenever you can can.
> > We are trying to get rid of it completely,
> > but that is only partly done.
> 
> I know about that and it's a typical kernel hacker argument, 
> but don't forget people want to have working software in the 
> meantime of your switch ;)
> 
> > I really resist changes to /proc/acpi/* because
> > I consider it legacy and would rather the effort
> > be focused on the new sysfs interfaces.
> 
> I will switch step by step. From what I can see not really 
> much things apart from the acpi version already switched to 
> sysfs. Maybe I missed it. I will answer in detail on 
> Henriques mail hopefully tomorrow.
> Kind regards and thanks for your quick replies

Things which have switched are now under CONFIG_ACPI_PROCFS in 2.6.23.
When more things switch in the future, they'll go there too.

If you have a specific suggestion for a bug fix to /proc/acpi/*,
please let me know, or better yet, send a patch.

-Len


