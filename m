From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] make ibm_acpi work right with notify handlers.
Date: Fri, 27 Oct 2006 01:34:11 -0400
Message-ID: <200610270134.11884.len.brown@intel.com>
References: <453F74B0.8080105@linux.intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:30850 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1423663AbWJ0Fej (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Oct 2006 01:34:39 -0400
In-Reply-To: <453F74B0.8080105@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Borislav Deianov <borislav@users.sourceforge.net>

On Wednesday 25 October 2006 10:29, Alexey Starikovskiy wrote:
> Hi,
> 
> There is a bug in ibm_acpi module, which prevents its clean removal.
> This patch fixes the problem by moving setting notify_installed to the right place.

Applied.

thanks,
-Len
