From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] device property: support for "built-in" properties
Date: Sat, 28 Mar 2015 02:05:19 +0100
Message-ID: <1594911.7FXIhSfjIv@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <CACxGe6tiDszPDpP_u1yxNgMA8HjagDKtGuu35hfkyJtZdGE0Aw@mail.gmail.com> <10066684.kPKm7OTnxF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64564 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752249AbbC1BDJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 21:03:09 -0400
In-Reply-To: <10066684.kPKm7OTnxF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

Hi,

Patches [1-2/3] add support for properties provided in a "pdata way"
roughly along the lines of the Heikki's patch at

https://patchwork.kernel.org/patch/5709461/

but using the fwnode field in struct device introduced by one of my
previous patches (currently in linux-next).

Patch [3/3] does one more interesting thing on top of that, but is mostly
for discussion.  Namely, it changes the behavior of the unified device
properties API to fall back to the "built-in" properties when it cannot
find the requested data in the stuff provided by the platform firmware.

Currently, that patch would introduce an artificial difference between ACPI
and DT, because DT uses the of_node pointer in struct device won't use the
set_primary_fwnode() thing introduced buy the [1/3].  However, I have an
idea about how that can be worked around, but more on that in the changelog
of patch [3/3].

Kind regards,
Rafael

