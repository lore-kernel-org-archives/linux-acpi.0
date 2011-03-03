From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 2/2] staging: Use generic IGD opregion code for gma500
Date: Thu, 3 Mar 2011 11:43:58 +0000
Message-ID: <20110303114358.1300bacd@bob.linux.org.uk>
References: <1298404994-2907-1-git-send-email-mjg@redhat.com>
	<1298404994-2907-2-git-send-email-mjg@redhat.com>
	<alpine.LFD.2.02.1103022114250.12344@x980>
	<alpine.LFD.2.02.1103022115120.12344@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23962 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab1CCMFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Mar 2011 07:05:12 -0500
In-Reply-To: <alpine.LFD.2.02.1103022115120.12344@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, 02 Mar 2011 21:16:28 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> i mean to say that 1/2 was applied to acpi-test, rather than 2/2.

Oh ok - thats fine then - I don't know if the IGD opregion code is
busted somewhere or the GMA500 patch but if the GMA bit isn't applied
and the rest works on i9xx all is fine
