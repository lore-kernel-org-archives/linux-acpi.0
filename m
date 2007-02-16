From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Could the k8temp driver be interfering with ACPI?
Date: 16 Feb 2007 20:59:33 +0100
Message-ID: <p73odntg9ga.fsf@bingen.suse.de>
References: <45D5EA88.7090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:53179 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946036AbXBPS7c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 13:59:32 -0500
In-Reply-To: <45D5EA88.7090300@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

Chuck Ebbert <cebbert@redhat.com> writes:
> 
> So, could ACPI and the k8temp driver be at odds?

Yes, there is no locking between ACPI and Linux drivers for register access.
e.g. if there is a indexed register both try to access (and temperature
sensors tend to use these things) they can race and get corrupted data.

-Andi
