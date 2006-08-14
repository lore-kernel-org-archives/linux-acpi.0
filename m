From: Adrian Bunk <bunk@stusta.de>
Subject: drivers/acpi/sbs.c:acpi_sbs_remove() inconsistent NULL checking
Date: Tue, 15 Aug 2006 00:48:39 +0200
Message-ID: <20060814224839.GX3543@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20743 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932741AbWHNWsk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Aug 2006 18:48:40 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rich Townsend <rhdt@bartol.udel.edu>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The Coverity checker spotted the following inconsistent NULL checking 
introduced by commit 3f86b83243d59bb50caf5938d284d22e10d082a4:

<--  snip  -->

...
int acpi_sbs_remove(struct acpi_device *device, int type)
{
        struct acpi_sbs *sbs = (struct acpi_sbs *)acpi_driver_data(device);
        int id;

        if (!device || !sbs) {
                return -EINVAL;
        }
...

<--  snip  -->

The NULL check for "device" is three lines after it got dereferenced the 
first time.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

