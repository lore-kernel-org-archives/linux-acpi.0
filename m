From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 00/16] Convert WMI to a proper bus
Date: Tue, 6 Jun 2017 10:23:32 -0700
Message-ID: <20170606172332.GD32509@fury>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdFFRXe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 13:23:34 -0400
Content-Disposition: inline
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Rafael Wysocki <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 26, 2017 at 10:31:14PM -0700, Darren Hart wrote:
> From: "Darren Hart (VMware)" <dvhart@infradead.org>
> 
> This series is based on the original work of
> Andy Lutomirski <luto@amacapital.net> [1]. I have made minor edits, and in
> one instance, squashed two patches in which the latter undid the former.
> 
> This series converts WMI [2] into a proper bus, adds some useful information via
> sysfs, and exposes the embedded MOF [3] binary. It converts dell-wmi to use the
> new WMI bus architecture.
> 
> This is the first part of an ongoing effort to enhance the WMI infrastructure
> within the kernel, and eventually expose WMI to userspace for the consumption of
> management utilities as it was intended.

I have incorporated all feedback, all of it minor, and with confirmation for
those modifications, have committed the series to the testing branch:

http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/testing

We would appreciate any additional real-world testing anyone can offer.

-- 
Darren Hart
VMware Open Source Technology Center
