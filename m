From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 7/8] ACPI, APEI, CPER: Cleanup CPER memory error output
 format
Date: Tue, 15 Oct 2013 09:42:21 -0700
Message-ID: <1381855341.22110.21.camel@joe-AO722>
References: <1381473166-29303-1-git-send-email-gong.chen@linux.intel.com>
	 <1381473166-29303-8-git-send-email-gong.chen@linux.intel.com>
	 <20131011160208.GL5925@pd.tnic> <20131014045500.GC12189@gchen.bj.intel.com>
	 <20131014103616.GE4009@pd.tnic>
	 <CA+8MBbJ9P1GVf3SCh7LMY_LH+pxQg3GWkxKMzni1b1Wyx1o8NQ@mail.gmail.com>
	 <525D2A07.6080201@linux.vnet.ibm.com> <20131015122958.GD7908@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:43417 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932439Ab3JOQmZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 12:42:25 -0400
In-Reply-To: <20131015122958.GD7908@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Tony Luck <tony.luck@gmail.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Lance Ortiz <lance.ortiz@hp.com>

On Tue, 2013-10-15 at 14:29 +0200, Borislav Petkov wrote:
> Once we exposed it to userspace, we cannot simply assume
> that nothing is using it.

Yes, we can.

No guarantees are made about dmesg output.

If guarantees were made, no typo could ever be fixed
nor could any conversion from printk to dev_<level>
be done.

