From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 13 Nov 2008 11:11:57 +0000
Message-ID: <20081113111157.GA30587@srcf.ucam.org>
References: <200811081637.45099.arvidjaar@mail.ru> <200811121741.36296.trenn@suse.de> <20081113013259.GA24790@srcf.ucam.org> <200811130758.13420.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58655 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYKMLMD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 06:12:03 -0500
Content-Disposition: inline
In-Reply-To: <200811130758.13420.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Thu, Nov 13, 2008 at 07:58:09AM +0300, Andrey Borzenkov wrote:

> - exposing two knobs for the *same* thing confuses user level tools; you never
> know which one is used and they compete behind your back

How do they compete? As I said, the implementations appear to be 
implemented on top of the same underlying functionality. The problem 
with providing both vendor and ACPI functionality comes when both use 
different mechanisms for changing the backlight and so can get out of 
sync with each other. Are there any machines supported by toshiba_acpi 
where this is the case?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
