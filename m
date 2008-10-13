From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Mon, 13 Oct 2008 13:56:36 +0800
Message-ID: <1223877396.4141.33.camel@yakui_zhao.sh.intel.com>
References: <48F0DB0C.7060201@tuffmail.co.uk>
	 <200810112140.16662.rjw@sisk.pl> <48F100CA.2050600@suse.de>
	 <200810112254.09094.rjw@sisk.pl> <48F1BFD0.7040004@tuffmail.co.uk>
	 <48F24EAE.6020108@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37081 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbYJMBb6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Oct 2008 21:31:58 -0400
In-Reply-To: <48F24EAE.6020108@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 2008-10-12 at 23:23 +0400, Alexey Starikovskiy wrote:
> +static int ec_wait_ibf0(struct acpi_ec *ec)
> +{
> +       unsigned long delay = jiffies +
> msecs_to_jiffies(ACPI_EC_DELAY);
> +       while (time_before(jiffies, delay)) {
> +               if (wait_event_timeout(ec->wait, ec_check_ibf0(ec),
> +                                       msecs_to_jiffies(1)))
> +               return 0;
Please add the bogus timeout check.
best regards.
   Yakui
> +       }
> +       return -ETIME;
> +}
> + 

