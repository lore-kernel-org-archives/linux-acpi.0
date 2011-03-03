From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 2/2] staging: Use generic IGD opregion code for gma500
Date: Thu, 3 Mar 2011 13:07:24 +0000
Message-ID: <20110303130724.GB22181@srcf.ucam.org>
References: <1298404994-2907-1-git-send-email-mjg@redhat.com> <1298404994-2907-2-git-send-email-mjg@redhat.com> <alpine.LFD.2.02.1103022114250.12344@x980> <20110303114306.31114533@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43105 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1CCNHe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2011 08:07:34 -0500
Content-Disposition: inline
In-Reply-To: <20110303114306.31114533@bob.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Thu, Mar 03, 2011 at 11:43:06AM +0000, Alan Cox wrote:
> On Wed, 02 Mar 2011 21:14:31 -0500 (EST)
> Len Brown <lenb@kernel.org> wrote:
> 
> > applied to acpi-test
> 
> NAK this - with it applied the GMA500 driver oopses in the opregion code

Awesome. Got a backtrace? I'm kind of lacking in hardware (and no, this 
is not a plea for some gma500)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
