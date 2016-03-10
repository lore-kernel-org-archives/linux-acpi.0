From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: pnp: add ACPI_RESOURCE_TYPE_SERIAL_BUS as a valid type
Date: Fri, 11 Mar 2016 00:36:59 +0100
Message-ID: <29159608.Ea8iiP4plo@vostro.rjw.lan>
References: <1456860705-24935-1-git-send-email-timur@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54324 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753873AbcCJXfF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:35:05 -0500
In-Reply-To: <1456860705-24935-1-git-send-email-timur@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: harba@codeaurora.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On Tuesday, March 01, 2016 01:31:45 PM Timur Tabi wrote:
> From: Harb Abdulhamid <harba@codeaurora.org>
> 
> An error message is printed for resources of type 19, which is a valid
> supported resource type.  The Firmware Test Suite tool (fwts) reports
> this as a test failure.  This change fixes the false test failures
> for ASL that use type 19 (ACPI_RESOURCE_TYPE_SERIAL_BUS) resources.
> 
> Signed-off-by: Harb Abdulhamid <harba@codeaurora.org>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Applied, thanks!

Rafael

