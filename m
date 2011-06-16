From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Wakeup and S states
Date: Thu, 16 Jun 2011 11:11:28 -0400
Message-ID: <4DFA1D20.5020800@cfl.rr.com>
References: <4DF8CBC3.5070801@cfl.rr.com> <20110615154457.GA13863@srcf.ucam.org> <4DFA09CB.9040909@iradimed.com> <20110616141517.GB15242@srcf.ucam.org> <4DFA13FD.6020304@cfl.rr.com> <20110616143703.GA15841@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:51841 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073Ab1FPPLa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 11:11:30 -0400
In-Reply-To: <20110616143703.GA15841@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 6/16/2011 10:37 AM, Matthew Garrett wrote:
> But you're complaining about the case where wakeup is enabled in a case
> where it *is* possible. Userspace needs to take care of that.

I am concerned about both cases.  It would /like/ to be able to set the 
policy to wakeup only on state X and lower, and it seems like this would 
be better done in the kernel than user space, but it seems a kernel bug 
to enable wakeup in states that are higher than where it is supported.
