From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] WMI patches for acpi-test (v2)
Date: Tue, 5 Feb 2008 16:03:30 -0500
Message-ID: <200802051603.30466.lenb@kernel.org>
References: <20080205021658.4422.83165.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39123 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757035AbYBEVDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 16:03:52 -0500
In-Reply-To: <20080205021658.4422.83165.stgit@pacifica>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-ia64@vger.kernel.org

On Monday 04 February 2008 21:16, Carlos Corbacho wrote:

> 2) Do you know of any IA64 systems using ACPI-WMI? At the moment, WMI will work
> on x86 and hopefully IA64, but if it turns out that no vendor has or ever will
> implement ACPI-WMI on IA64, then we could safely drop it there.

I recommend skipping WMI on IA64 unless/until a real need to support it emerges.
There are no WMI extensions on the Intel Tiger or Hitachi Fusion IA64 boxes I have access to.

thanks,
-Len

