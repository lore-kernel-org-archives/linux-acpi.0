From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3]: Store SRAT revision
Date: Tue, 17 Jan 2012 04:24:35 -0500
Message-ID: <4F153E53.6020108@kernel.org>
References: <20120115213005.GT12380@tpkurt2.garloff.de> <20120115213407.GU12380@tpkurt2.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:60013 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2AQJYm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 04:24:42 -0500
In-Reply-To: <20120115213407.GU12380@tpkurt2.garloff.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kurt Garloff <kurt@garloff.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>, x86@vger.kernel.org

looks fine to me.
as #2 (x86) and #3 (ia64) depend on #1, which is ACPI,
I can send this via the ACPI tree.

thanks,
-Len Brown, Intel Open Source Technology Center
