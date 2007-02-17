From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Sat, 17 Feb 2007 13:14:50 -0500
Message-ID: <45D7461A.2040808@redhat.com>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51183 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993007AbXBQSRA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Feb 2007 13:17:00 -0500
In-Reply-To: <45D6DDCE.5050803@assembler.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Rudolf Marek wrote:
> Hello Chuck,
> 
> I'm the author of K8temp. Please can you share with us your DSDT table?
> (cat /proc/acpi/dsdt > /tmp/dsdt.bin)
> 

The system is Compaq Presario V2300 series notebook.  I won't be able
to get the DSDT until tomorrow or Monday.

>> So, could ACPI and the k8temp driver be at odds?
> 
> Yes because ACPI AML code has no synchronization with Linux drivers. Second
> reason is that ACPI AML code assign resource regions to itself but with cleared
> busy flag - so other drivers could bind and might possibly interfere  with ACPI.

Well I had an idea after looking at k8temp -- why not make it default to
doing only reads from the sensor?  You'd only get information from whatever
core/sensor combination that ACPI had last used, but it would be safe.


