From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if ACPI
	resources aren't enforced
Date: Tue, 30 Mar 2010 14:21:32 +0100
Message-ID: <20100330132132.GA16657@srcf.ucam.org>
References: <20100309135636.373a40a9@hyperion.delvare> <20100330120319.627e8f9a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59013 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0C3NVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Mar 2010 09:21:35 -0400
Content-Disposition: inline
In-Reply-To: <20100330120319.627e8f9a@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, Mar 30, 2010 at 12:03:19PM +0200, Jean Delvare wrote:
> ACPI people,
> 
> Do you have any objection to the patch below, or can I push it upstream?

If you pass that boot option, you're already indicating that you don't 
care about multiple things accessing the same resources simultaneously. 
I think it's reasonable to leave things up to the user to configure at 
that point.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
