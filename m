From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPICA regression checker
Date: Wed, 12 Jul 2006 23:48:55 +0100
Message-ID: <20060712224855.GA16699@srcf.ucam.org>
References: <CFF307C98FEABE47A452B27C06B85BB6F317ED@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:60878 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932360AbWGLWtA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 18:49:00 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F317ED@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: trenn@suse.de, "Moore, Robert" <robert.moore@intel.com>, "Yu, Ling L" <ling.l.yu@intel.com>, linux-acpi@vger.kernel.org

On Tue, Jul 11, 2006 at 10:01:30PM -0400, Brown, Len wrote:

> Platform ACPI compliance Test
> This is sorely needed by the community to replace WHQL as the test
> that vendors run to make sure they got their ACPI implementation right.
> It would be a turn-key test that runs on a platform and gives
> a yes/no on compliance, and diagnostics on failures.

Based on our previous conversations, would this require that platforms 
reinitialise video themselves? And, what's probably a harder question, 
is there any real chance of there being sufficient political will in 
Intel to make passing this a requirement for claiming ACPI compliance?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
