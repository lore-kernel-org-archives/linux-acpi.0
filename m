From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 6/8] hwmon driver for ACPI 4.0 power meters
Date: Wed, 24 Nov 2010 21:39:36 +0000
Message-ID: <20101124213936.GA9829@srcf.ucam.org>
References: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49250 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab0KXVjw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2010 16:39:52 -0500
Content-Disposition: inline
In-Reply-To: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, djwong@us.ibm.com, pavel@ucw.cz, rui.zhang@intel.com

On Fri, Sep 18, 2009 at 12:41:09PM -0700, akpm@linux-foundation.org wrote:

> This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> devices.  This second revision of the driver also exports the ACPI string
> info as sysfs attributes, a list of the devices that the meter measures,
> and will send ACPI notifications over the ACPI netlink socket.  This
> latest revision only enables the power capping controls if it can be
> confirmed that the power cap can be enforced by the hardware and explains
> how the notification interfaces work.

I know I'm a bit late on this, but what do you mean by "it can be 
confirmed that the power cap can be enforced by the hardware"? Isn't 
that what bit 2 of the capabilities list means?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
