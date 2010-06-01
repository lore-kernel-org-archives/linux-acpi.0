From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: How to disable power managment for SATA?
Date: Tue, 01 Jun 2010 10:02:28 +0200
Message-ID: <4C04BE94.50107@canonical.com>
References: <AANLkTilxYC8a88DwMlc6MPgM_ai9we9vsCXej-KqwToY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54839 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0FAICa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jun 2010 04:02:30 -0400
In-Reply-To: <AANLkTilxYC8a88DwMlc6MPgM_ai9we9vsCXej-KqwToY@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Fred ." <eldmannen@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 06/01/2010 01:38 AM, Fred . wrote:
> I can disable power management with acpi=off
> 
> But how do I disable it just for SATA?

For Ubuntu 10.04 there was a script in /usr/lib/pm-utils/power.d/ but that has
been removed in newer updates as it caused quite severe SATA errors on some
chipsets.

-Stefan
