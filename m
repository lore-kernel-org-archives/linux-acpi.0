From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: 2.6.24 Temperature/speed _not_ normal - no thermal throttling?
Date: Mon, 25 Feb 2008 14:36:26 -0500
Message-ID: <47C318BA.3000306@redhat.com>
References: <47BBC627.8020907@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbYBYTg2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Feb 2008 14:36:28 -0500
In-Reply-To: <47BBC627.8020907@fnal.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ron Rechenmacher <ron@fnal.gov>
Cc: linux-acpi@vger.kernel.org

On 02/20/2008 01:18 AM, Ron Rechenmacher wrote:
> Hi,
> I believe I am having a critical thermal problem. I do not know if it
> is limited to the 2.6.24.2 kernel which I am running. I do see there has
> been some discussion  about thermal zones and throttling on the list,
> but I can not tell if it means that thermal throttling is not working in
> 2.6.24.2
> 

What does /proc/interrupts say about thermal event interrupts?

