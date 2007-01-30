From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/7] asus-laptop: add ledd support
Date: Tue, 30 Jan 2007 01:41:47 -0500
Message-ID: <200701300141.47914.lenb@kernel.org>
References: <200701251254.52843.corentincj@iksaif.net> <200701261404.55363.corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46411 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965369AbXA3GtM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 01:49:12 -0500
In-Reply-To: <200701261404.55363.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Note the corrected whitespace errors:

Applying 'asus-laptop: add ledd support'

Space in indent is followed by a tab.
.dotest/patch:95:       /* LED display is off by default */
Space in indent is followed by a tab.
.dotest/patch:96:       hotk->ledd_status = 0xFFF;
warning: 2 lines applied after stripping trailing whitespaces.
Wrote tree 6f1769ee1ee2be9067a6c1112c9cff974f40497e
Committed: 722ad97153015aaf5becba3084565e98e71a2aed
Commit Body is:
--------------------------
asus-laptop: add light sensor support

/proc/acpi/asus/lslvl is now /sys/.../asus-laptop/ls_level
/proc/acpi/asus/lssw is now /sys/.../asus-laptop/ls_switch nothing
else ..

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
