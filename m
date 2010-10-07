From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Thu, 7 Oct 2010 10:46:26 -0700
Message-ID: <20101007174626.GA31541@suse.de>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org>
 <20101007021959.GA7300@suse.de>
 <AANLkTimE2h46iZkj_amvgUg5UwN9xjuwqdW5TB+XccYy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:49307 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab0JGR4N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Oct 2010 13:56:13 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimE2h46iZkj_amvgUg5UwN9xjuwqdW5TB+XccYy@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sameer Nanda <snanda@chromium.org>
Cc: lenb@kernel.org, stefan.bader@canonical.com, brad.figg@canonical.com, apw@canonical.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 07, 2010 at 10:43:34AM -0700, Sameer Nanda wrote:
> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH <gregkh@suse.de> wrote:
> > And are you always going to be printing this out?  Why do we want to
> > know this every time?
> >
> 
> Yes, every time.  This helps track variance in BIOS resume times within a
> single boot.

Is that really something that users can do something about?  I can
understand when you are trying to work with a BIOS company, but
otherwise, this seems quite pointless.

thanks,

greg k-h
