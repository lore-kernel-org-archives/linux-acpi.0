From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Generic battery interface
Date: Fri, 28 Jul 2006 10:58:06 +0100
Message-ID: <20060728095806.GA2046@srcf.ucam.org>
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:39068 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932602AbWG1J6T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Jul 2006 05:58:19 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>, vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>, linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org

On Fri, Jul 28, 2006 at 12:05:35AM -0400, Brown, Len wrote:

> Wonderful, but isn't the key here how simple it is for HAL
> or X to understand and use the kernel API rather than the
> developers of the kernel driver that implements the API?

HAL currently gets most of its information from sysfs, and managed to 
deal with parsing the existing /proc/acpi/battery stuff. I don't think 
there's any real difficulty there.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
