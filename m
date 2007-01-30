From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 7/7] asus-laptop: add  light sensor support
Date: Tue, 30 Jan 2007 01:42:39 -0500
Message-ID: <200701300142.39230.lenb@kernel.org>
References: <200701251254.59337.corentincj@iksaif.net> <200701261404.58597.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46412 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965410AbXA3GtM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 01:49:12 -0500
In-Reply-To: <200701261404.58597.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

note the corrected whitespace errors:

Applying 'asus-laptop: add light sensor support'

Space in indent is followed by a tab.
.dotest/patch:135:      /* Set initial values of light sensor and level */
Space in indent is followed by a tab.
.dotest/patch:136:      hotk->light_switch = 1; /* Default to light sensor disabled */
Space in indent is followed by a tab.
.dotest/patch:137:      hotk->light_level = 0; /* level 5 for sensor sensitivity */
Space in indent is followed by a tab.
.dotest/patch:139:      if (ls_switch_handle)
Space in indent is followed by a tab.
.dotest/patch:140:              set_light_sens_switch(hotk->light_switch);
