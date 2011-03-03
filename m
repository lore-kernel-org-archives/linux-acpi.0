From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] staging: Use generic IGD opregion code for gma500
Date: Thu, 3 Mar 2011 12:52:36 +0000
Message-ID: <20110303125236.1640d3b4@bob.linux.org.uk>
References: <1298404994-2907-1-git-send-email-mjg@redhat.com>
	<1298404994-2907-2-git-send-email-mjg@redhat.com>
	<alpine.LFD.2.02.1103022114250.12344@x980>
	<20110303114306.31114533@bob.linux.org.uk>
	<20110303130724.GB22181@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36159 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab1CCNNu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2011 08:13:50 -0500
In-Reply-To: <20110303130724.GB22181@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Thu, 3 Mar 2011 13:07:24 +0000
Matthew Garrett <mjg@redhat.com> wrote:

> On Thu, Mar 03, 2011 at 11:43:06AM +0000, Alan Cox wrote:
> > On Wed, 02 Mar 2011 21:14:31 -0500 (EST)
> > Len Brown <lenb@kernel.org> wrote:
> > 
> > > applied to acpi-test
> > 
> > NAK this - with it applied the GMA500 driver oopses in the opregion
> > code
> 
> Awesome. Got a backtrace? I'm kind of lacking in hardware (and no,
> this is not a plea for some gma500)

I did try and pin it down a bit but didn't get anywhere useful. When I
have a bit more time I'll trace it in full.

