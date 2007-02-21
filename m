From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Date: Wed, 21 Feb 2007 15:59:46 +0100
Message-ID: <20070221155946.ff622cf9.khali@linux-fr.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070220151813.GA6581@srcf.ucam.org>
	<68676e00702200733l6e7f13a5o201bc70fed98528b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:2347 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751300AbXBUPAF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Feb 2007 10:00:05 -0500
In-Reply-To: <68676e00702200733l6e7f13a5o201bc70fed98528b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, lm-sensors@lm-sensors.org

Hi Luca,

On Tue, 20 Feb 2007 16:33:56 +0100, Luca Tettamanti wrote:
> Motherboard vendors usually provide tools for $(TheOtherOS) that can
> read from all thermal  / fan / voltage / whatever sensors, so I guess
> it's possible to make the ACPI driver and the "raw" one play nice with
> each other[1].
> 
> Luca
> [1] Unless their solution is "poke at the hardware and hope that ACPI
> doesn't blow up", that is.

Without the sources it's hard to tell. And all these applications are
vendor-specific, so if they indeed have ways to avoid conflicting
accesses between ACPI and the rest of the system, these ways are likely
to be vendor-specific as well, and not documented.

Either way, this means we need the support from hardware vendors to
solve this concurrent access problem, and unfortunately I doubt this
happens anytime soon :(

-- 
Jean Delvare
