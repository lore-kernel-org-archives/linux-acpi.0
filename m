From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Mon, 7 Oct 2013 00:31:06 +0100
Message-ID: <20131006233106.GA21562@srcf.ucam.org>
References: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
 <20131004161226.GA22784@srcf.ucam.org>
 <CAMP44s0tqKBgUTzFnbTMqDVVWLcaDC5VKd9mq_w+T_Yu19KXqQ@mail.gmail.com>
 <20131006203353.GA19795@srcf.ucam.org>
 <CAMP44s0N5xqD2W7-r-j1k3efo1k0qY2gCeqn+tbHsvOsrqOJgg@mail.gmail.com>
 <20131006204518.GA20077@srcf.ucam.org>
 <CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
 <20131006205928.GA20296@srcf.ucam.org>
 <CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56748 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3JFXbL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 19:31:11 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Oct 06, 2013 at 06:27:28PM -0500, Felipe Contreras wrote:
> From acpi_osi_dmi_table:
> 
> /*
> * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
> * Linux ignores it, except for the machines enumerated below.
> */

Which was a mistake. We learn from mistakes rather than repeating them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
