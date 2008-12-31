From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/15] ACPI: create kernel/acpi/
Date: Wed, 31 Dec 2008 16:34:41 +0100
Message-ID: <20081231153441.GA3475@uranus.ravnborg.org>
References: <1230720725-9376-1-git-send-email-lenb@kernel.org> <526647e1bb69fd3248558fce365bb1fbfb226ccd.1230719795.git.len.brown@intel.com> <20081231133901.GB2388@uranus.ravnborg.org> <87bpusv31n.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:35167 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbYLaPdH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Dec 2008 10:33:07 -0500
Content-Disposition: inline
In-Reply-To: <87bpusv31n.fsf@basil.nowhere.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Wed, Dec 31, 2008 at 03:21:08PM +0100, Andi Kleen wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> > Why is ACPI_CFLAGS exported?
> >> +ACPI_CFLAGS	:= -Os
> >> +
> >> +ifdef CONFIG_ACPI_DEBUG
> >> +  ACPI_CFLAGS	+= -DACPI_DEBUG_OUTPUT
> >> +endif
> >> +
> >> +EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
> > A better way:
> >
> > ccflags-$(CONFIG_ACPI_DEBUG) := -DACPI_DEBUG_OUTPUT
> 
> Surely s/:=/+=/ ?

Only if ccflags-y is assigned earlier in the same file
otherwise it does not matter.

	Sam
