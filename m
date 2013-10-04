From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Fri, 4 Oct 2013 17:12:26 +0100
Message-ID: <20131004161226.GA22784@srcf.ucam.org>
References: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36543 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab3JDQMf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Oct 2013 12:12:35 -0400
Content-Disposition: inline
In-Reply-To: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Oct 03, 2013 at 12:13:03PM -0500, Felipe Contreras wrote:
> More people have reported they need this for their machines to work
> correctly.

Can you add a comment to each indicating why they're being added so we 
can easily remove them again once the problem is fixed?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
