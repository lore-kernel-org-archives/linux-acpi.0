From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Wakeup and S states
Date: Thu, 16 Jun 2011 10:32:29 -0400
Message-ID: <4DFA13FD.6020304@cfl.rr.com>
References: <4DF8CBC3.5070801@cfl.rr.com> <20110615154457.GA13863@srcf.ucam.org> <4DFA09CB.9040909@iradimed.com> <20110616141517.GB15242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:33291 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312Ab1FPOcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 10:32:36 -0400
In-Reply-To: <20110616141517.GB15242@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 6/16/2011 10:15 AM, Matthew Garrett wrote:
> Yes. How would the kernel know that you don't want WoL in that case?

That was my original point; the kernel architecture seems lacking since 
it does not consider what S state you are talking about wrt wakeup 
capability and policy.  I can see the argument that policy should be 
dynamically changed in user space, but it seems that the kernel really 
needs to track the capability as it relates to S state so you don't try 
to enable wakeup in states where it is not possible.
