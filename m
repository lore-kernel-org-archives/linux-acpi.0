From: Johan Vromans <jvromans@squirrel.nl>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 10:22:03 +0200
Message-ID: <m2k65ykul0.fsf@phoenix.squirrel.nl>
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:63759 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S932593AbWG1IWY
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 04:22:24 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com> (Len
 Brown's message of "Fri, 28 Jul 2006 00:05:35 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

"Brown, Len" <len.brown@intel.com> writes:

> good for shell scripts, not clear it is better for C programs
> that have to open a bunch of files by name.

Moreover, it means that the factual data is only made available as a
nice textual string, that then has to be parsed by shell scripts and
other programs to get the factual data again.

So I feel much for /dev/xxx approach, together with the already
mentioned small utilities like 'batstat' for shell scripts.

-- Johan

