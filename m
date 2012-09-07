From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] acpi: bus: handle power manageable but no _PSC/_PRx case
Date: Fri, 07 Sep 2012 22:32:25 +0800
Message-ID: <504A0579.3000109@intel.com>
References: <1346053126-7646-1-git-send-email-aaron.lu@intel.com> <201209062353.34517.rjw@sisk.pl> <20120907003513.GA1419@mint-spring.sh.intel.com> <201209071346.01900.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17140 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400Ab2IGOcn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Sep 2012 10:32:43 -0400
In-Reply-To: <201209071346.01900.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On 09/07/2012 07:46 PM, Rafael J. Wysocki wrote:
>> Yes, on a test system, when I try to put a device into D3 cold and ACPI
>> will complain that I can't due to its parent is in a even lower power
>> state UNKNOWN(255), this parent device is power manageable but has no
>> _PSC and _PRx defined.
>
> Perhaps we can force _PS0 for such devices to start with, so that we know
> for sure that the initial state is D0?

Sounds good, I'll update the patch, thanks for the advice.

-Aaron
