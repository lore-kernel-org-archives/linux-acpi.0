From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: cpu voltage change question
Date: Thu, 27 Jan 2011 11:12:28 -0500
Message-ID: <4D41996C.1060600@cfl.rr.com>
References: <1296119453.4653.1.camel@genix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:34114 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1A0QMX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2011 11:12:23 -0500
In-Reply-To: <1296119453.4653.1.camel@genix>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mihn <mihnsk@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 1/27/2011 4:10 AM, mihn wrote:
> Hi,
> 
> I want to change voltage and frequency seperately.
> With cpu-freq, i can change frequency, but cannot change voltage AFAIK.

The voltage is controlled by the platform and should already be set to a
level appropriate for that frequency.  AFAIK, recent intel cpus have
MSRs that configure the voltage for each P-state, but these are set up
by the bios and shouldn't need changed.
