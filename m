From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist:  blacklist Win8 OSI for Dell Inspiron
 7437
Date: Fri, 24 Apr 2015 09:21:15 +0100
Message-ID: <20150424082115.GA3783@srcf.ucam.org>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33226 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923AbbDXIVT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2015 04:21:19 -0400
Content-Disposition: inline
In-Reply-To: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On Thu, Apr 23, 2015 at 11:24:35AM +0800, Alex Hung wrote:
> Dell Inspiron 7437's ACPI events does not work well with Win8 OSI.
> Disabling Win8 OSI can fix wireless hotkey and ACPI battery.

Does this machine work if you actually install Windows 8 on it?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
