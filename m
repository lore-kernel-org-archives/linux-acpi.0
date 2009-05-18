From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on
	suspend
Date: Mon, 18 May 2009 22:02:41 +0100
Message-ID: <20090518210241.GA17755@srcf.ucam.org>
References: <4A11C126.1000704@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34760 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbZERVCn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2009 17:02:43 -0400
Content-Disposition: inline
In-Reply-To: <4A11C126.1000704@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 18, 2009 at 03:12:22PM -0500, Mario Limonciello wrote:
>  Dell BT devices need to be removed from the bus and reinserted
>  so that userspace udev rules can transition the devices into the
>  proper mode after S3 or S4.

This sounds wrong. What kind of reinitialisation are you talking about?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
