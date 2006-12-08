From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/14] ACPI: make ACPI use driver model
Date: Fri, 8 Dec 2006 05:31:31 -0500
Message-ID: <200612080531.32120.len.brown@intel.com>
References: <1165496170.11485.74.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42461 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425336AbWLHK20 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Dec 2006 05:28:26 -0500
In-Reply-To: <1165496170.11485.74.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 07 December 2006 07:56, Zhang Rui wrote:
> The main purpose of this patch series is to make ACPI use driver model
> And these are updated patches against 2.6.19.

Thanks Rui, I've pushed this updated  series into the acpi-test branch --
replacing the previous version.

(except patch 14, which was already there via the ibm-acpi update)

-Len
