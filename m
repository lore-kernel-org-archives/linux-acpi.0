From: Prarit Bhargava <prarit@redhat.com>
Subject: RFC: Output ACPI info via sysfs
Date: Thu, 11 May 2006 10:57:34 -0400
Message-ID: <446350DE.9010900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:14061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751818AbWEKO5r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 May 2006 10:57:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Brown, Len" <len.brown@intel.com>

Currently, after booting a system there is no way to tell what hardware 
is currently in the system.  The current output from sysfs only 
indicates what knowledge the kernel has of the system (ie, is limited by 
NR_CPUS, etc.).  However, during ACPI initialization a lot of data is 
output to the console about the precise number of CPUs, lapics, etc.

Having this information is useful to anyone (or any application) 
interested in querying the real system information.

Any thoughts, concerns?  (Code not yet generated -- just looking for an 
okay on the RFC)

P.




