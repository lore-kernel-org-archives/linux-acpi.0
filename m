From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH] Fix compile warning CONFIG_I7300_IDLE_IOAT_CHANNEL not defined
Date: Fri, 24 Oct 2008 10:53:21 -0700
Message-ID: <e9c3a7c20810241053t2f991a62p1d03fb60f8750a89@mail.gmail.com>
References: <20081023223906.GA26918@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:6646 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYJXRxY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Oct 2008 13:53:24 -0400
Received: by qw-out-2122.google.com with SMTP id 3so482201qwe.37
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2008 10:53:23 -0700 (PDT)
In-Reply-To: <20081023223906.GA26918@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Sosnowski, Maciej" <maciej.sosnowski@intel.com>

On Thu, Oct 23, 2008 at 3:39 PM, Venki Pallipadi
<venkatesh.pallipadi@intel.com> wrote:
>
> When I7300_idle driver is not configured, there is a compile time
> warning about IDLE_IOAT_CHANNEL not defined. Fix it.
>

Please copy Maciej and myself on ioat changes.

Thanks,
Dan
