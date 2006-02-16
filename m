From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: confused fan after S3 resume (TP 600X)
Date: Thu, 16 Feb 2006 17:30:47 +0000
Message-ID: <20060216173047.GA20136@srcf.ucam.org>
References: <E1F9eIG-00010e-Jm@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:62135 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932517AbWBPRbA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Feb 2006 12:31:00 -0500
Content-Disposition: inline
In-Reply-To: <E1F9eIG-00010e-Jm@approximate.corpus.cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Thu, Feb 16, 2006 at 03:15:16AM -0500, Sanjoy Mahajan wrote:

> First theory: On sleep, the machine turns off the fan.  On wakeup, the
> thermal module doesn't check whether the fan should be turned back on.
> Only when a trip point is crossed (or changed?) does it turn on.  So I
> added a _resume method to thermal.c to call acpi_thermal_check().
> However, that didn't fix the problem.

APCI devices don't currently support suspend or resume methods. For now, 
here's what I have in the Ubuntu resume script:

for x in /proc/acpi/fan/*; do
    if [ "`grep on $x/state`" ]; then
        echo -n 3 > $x/state;
        echo -n 0 > $x/state;
    fi
done

which seems to help.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
