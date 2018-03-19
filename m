From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] power/hibernate: Make passing hibernate offsets more friendly
Date: Mon, 19 Mar 2018 11:11:07 +0100
Message-ID: <1854392.I8WPNng6r5@aspire.rjw.lan>
References: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520333620-22342-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, March 6, 2018 11:53:40 AM CET Mario Limonciello wrote:
> Currently the only way to specify a hibernate offset for a
> swap file is on the kernel command line.
> 
> Add a new /sys/power/disk_offset that lets userspace
> specify the offset and disk to use when initiating a hibernate
> cycle.
> 
> Also split up the parsing routine to re-use the same code
> for the /sys/power/resume and /sys/power/disk_offset parsing.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>

Well, IMO /sys/power/resume and /sys/power/disk_offset would be confusingly
similar after this patch.

I wonder if adding a resume_offset sysfs attr to simply allow the value of
resume offset alone to be passed to the kernel at run time (in addition to
the command line) would work?

Thanks!
