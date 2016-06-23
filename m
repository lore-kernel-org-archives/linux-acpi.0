From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 2/3] acpi: dptf_power: Add DPTF power participant
Date: Thu, 23 Jun 2016 07:05:57 -0700
Message-ID: <1466690757.4272.19.camel@linux.intel.com>
References: <1466653363-7311-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1466653363-7311-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0g-jZqobJQax-mxBnTnm7ZH2V5=bMLvWTcqVQbraBqxjQ@mail.gmail.com>
	 <CAJZ5v0j8ybZRF7AYeXaOqf_Oo7Qnpi53ymRoxzYA5gW7tqMCgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19127 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbcFWOHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Jun 2016 10:07:44 -0400
In-Reply-To: <CAJZ5v0j8ybZRF7AYeXaOqf_Oo7Qnpi53ymRoxzYA5gW7tqMCgw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>

On Thu, 2016-06-23 at 15:23 +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 23, 2016 at 1:48 AM, Rafael J. Wysocki <rafael@kernel.org
> > wrote:
> > On Thu, Jun 23, 2016 at 5:42 AM, Srinivas Pandruvada

[...]

> > Now that I think about it, maybe it would be better to put that
> > into
> > drivers/platform/x86?
> 
> Or we can create a dptf directory under drivers/acpi/ if you prefer.
> 
Let me do this. We may have more such drivers.

Thanks,
Srinivas

