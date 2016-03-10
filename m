From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / fan: Make struct dev_pm_ops const
Date: Fri, 11 Mar 2016 00:33:04 +0100
Message-ID: <21762559.pLpMzpU6lg@vostro.rjw.lan>
References: <1455146607-66183-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44431 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932355AbcCJXbK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:31:10 -0500
In-Reply-To: <1455146607-66183-1-git-send-email-briannorris@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Kaiyen Chang <kaiyen.chang@intel.com>

On Wednesday, February 10, 2016 03:23:27 PM Brian Norris wrote:
> From: Kaiyen Chang <kaiyen.chang@intel.com>
> 
> Silence the following checkpatch warning:
> WARNING: struct dev_pm_ops should normally be const.
> 
> Signed-off-by: Kaiyen Chang <kaiyen.chang@intel.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied, thanks!

Rafael

