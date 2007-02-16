From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: Could the k8temp driver be interfering with ACPI?
Date: Fri, 16 Feb 2007 13:14:33 -0500
Message-ID: <45D5F489.1010704@redhat.com>
References: <45D5EA88.7090300@redhat.com> <200702161257.23684.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:57413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946173AbXBPSSB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 13:18:01 -0500
In-Reply-To: <200702161257.23684.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Len Brown wrote:
>> So, could ACPI and the k8temp driver be at odds?
> 
> 
> Yes.

Hmm, now it's showing 130 degrees once every five seconds
and 54 degrees for the other four.

And while I was typing this on another machine I heard a
click from the notebook -- it shut down again.

