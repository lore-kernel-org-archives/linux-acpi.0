From: Larry Finger <larry.finger@lwfinger.net>
Subject: Re: Help with ACPI events
Date: Fri, 29 Dec 2006 19:28:17 -0600
Message-ID: <4595C0B1.1050406@lwfinger.net>
References: <45947B98.5050309@lwfinger.net> <4594F1F4.9080102@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:56601 "EHLO
	mtiwmhc12.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030205AbWL3B2U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Dec 2006 20:28:20 -0500
In-Reply-To: <4594F1F4.9080102@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Next, you should look into your DSDT and find what exactly _Q10 does (it
> might set/reset some variable with descriptive name). Then, in your code
> you can read the state of this variable with
> acpi_evaluate_integer/acpi_evaluate_object. Please look at drivers in
> drivers/acpi for examples.

Thanks for the quick response. Fortunately, I didn't need to deal with the problem. Apparently, some
part of my git tree had gotten corrupted. When I downloaded a fresh copy, this problem went away.

Larry
