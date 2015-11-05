From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI/osl: speedup grace period in acpi_os_map_cleanup
Date: Thu, 05 Nov 2015 03:26:43 +0100
Message-ID: <7260153.ayx6kthA8t@vostro.rjw.lan>
References: <CACoWiSA=Hv+q68JEMvyX2-P+cWBr9tGPYrmznhfE-sAexVPPNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60845 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756491AbbKEB5c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2015 20:57:32 -0500
In-Reply-To: <CACoWiSA=Hv+q68JEMvyX2-P+cWBr9tGPYrmznhfE-sAexVPPNw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Garnett <axfelix@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday, November 04, 2015 09:29:36 AM Alex Garnett wrote:
> Hi folks,

Hi,

> Apologies for resending an old patch (by another contributor, not
> myself), but it never received a response in the first go-round, and
> now that we're back in a merge window, I'd love to get this regression
> fixed:
> 
> https://www.marc.info/?l=linux-acpi&m=143853596924508&w=1

Could you please try to figure out what the root cause of this problem is?

The code as is should work in theory, so if it doesn't, we first need to
understand why that happens and then decide what to do about it, not the
other way around.

Thanks,
Rafael

