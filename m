From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2/8] git-acpi build fix
Date: Thu, 13 Dec 2007 16:24:44 -0800
Message-ID: <20071213162444.1c78c6b7.akpm@linux-foundation.org>
References: <200712132353.lBDNrXRG024821@imap1.linux-foundation.org>
	<200712140124.33319.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55047 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762555AbXLNAZG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 19:25:06 -0500
In-Reply-To: <200712140124.33319.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, 14 Dec 2007 01:24:32 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 14 of December 2007, akpm@linux-foundation.org wrote:
> > From: Andrew Morton <akpm@linux-foundation.org>
> > 
> > ia64 allmodconfig:
> > 
> > kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)
> 
> I've already sent a better fix for that, thanks.

I don't think I was cc'ed.  Please make sure that I see fixes to trees
which are in -mm?


