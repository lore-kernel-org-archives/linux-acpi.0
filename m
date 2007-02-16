From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Could the k8temp driver be interfering with ACPI?
Date: Fri, 16 Feb 2007 14:31:44 -0500
Message-ID: <45D606A0.5020606@redhat.com>
References: <45D5EA88.7090300@redhat.com> <p73odntg9ga.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946058AbXBPTdx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 14:33:53 -0500
In-Reply-To: <p73odntg9ga.fsf@bingen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Andi Kleen wrote:
> Chuck Ebbert <cebbert@redhat.com> writes:
>> So, could ACPI and the k8temp driver be at odds?
> 
> Yes, there is no locking between ACPI and Linux drivers for register access.
> e.g. if there is a indexed register both try to access (and temperature
> sensors tend to use these things) they can race and get corrupted data.

I blacklisted the k8temp driver and everything looks OK now.

