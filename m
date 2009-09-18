From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [patch 6/8] hwmon driver for ACPI 4.0 power meters
Date: Fri, 18 Sep 2009 13:46:43 -0700
Message-ID: <20090918204643.GZ10521@tux1.beaverton.ibm.com>
References: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:55384 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZIRUqp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Sep 2009 16:46:45 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8IKgR40021982
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2009 14:42:27 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n8IKkk4W194262
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2009 14:46:46 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n8IKkist028806
	for <linux-acpi@vger.kernel.org>; Fri, 18 Sep 2009 14:46:46 -0600
Content-Disposition: inline
In-Reply-To: <200909181941.n8IJf91g002548@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, pavel@ucw.cz, rui.zhang@intel.com

On Fri, Sep 18, 2009 at 12:41:09PM -0700, akpm@linux-foundation.org wrote:
> From: "Darrick J. Wong" <djwong@us.ibm.com>
> 
> This driver exposes ACPI 4.0 compliant power meters as hardware monitoring
> devices.  This second revision of the driver also exports the ACPI string
> info as sysfs attributes, a list of the devices that the meter measures,
> and will send ACPI notifications over the ACPI netlink socket.  This
> latest revision only enables the power capping controls if it can be
> confirmed that the power cap can be enforced by the hardware and explains
> how the notification interfaces work.
> 
> [akpm@linux-foundation.org: remove default-y]
> [akpm@linux-foundation.org: build fix]

Looks good to me.
Acked-by: Darrick J. Wong <djwong@us.ibm.com>

(Ack'ing my own patch?)

--D
