From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 23:38:50 +0400
Message-ID: <48F100CA.2050600@suse.de>
References: <48F0DB0C.7060201@tuffmail.co.uk> <200810112130.57757.rjw@sisk.pl> <48F0FEFA.7050308@gmail.com> <200810112140.16662.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:48793 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751007AbYJKTiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 15:38:50 -0400
In-Reply-To: <200810112140.16662.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
>> No, we discussed this before -- we are outside of the transaction, thus 
>> no GPE
>> activity could interfere with ec_check_ibf0.
> 
> Ok, this is in the process context and we don't really expect to get an
> interrupt at this point, but what happens if the EC generates an event that's
> not related to any transiaction.  Is that guaranteed to never happen?
Interrupt handler in this case can't cause a change to status register, thus our 
read of it will not be affected by interrupt.
> 
> Thanks,
> Rafael

