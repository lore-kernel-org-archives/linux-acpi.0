From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI / video: Use native backlight control interface by
 default
Date: Fri, 20 Dec 2013 14:32:21 +0800
Message-ID: <20131220063219.GA6158@aaronlu.linux.com>
References: <1386209037-31349-1-git-send-email-acelan.kao@canonical.com>
 <20131205023237.GA23671@srcf.ucam.org>
 <CAKMK7uG14CK+PO4RDzh+GKXotNuSead7-sN83SujK826jgt5iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57837 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab3LTGcY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Dec 2013 01:32:24 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so2120704pdj.40
        for <linux-acpi@vger.kernel.org>; Thu, 19 Dec 2013 22:32:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKMK7uG14CK+PO4RDzh+GKXotNuSead7-sN83SujK826jgt5iw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, AceLan Kao <acelan.kao@canonical.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, intel-gfx <intel-gfx@lists.freedesktop.org>

On Thu, Dec 05, 2013 at 08:50:21AM +0100, Daniel Vetter wrote:
> On Thu, Dec 5, 2013 at 3:32 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > We had problems with the Intel backlight driver the last time we tried
> > this, so let's push this through their tree for testing first? Cc:ed
> > intel-gfx and Daniel Vetter.
> 
> Makes sense imo. Or if I just get a branch with just those patches (it
> can rebase, I don't really care) I could  pull it into our
> drm-intel-nightly integration tree, which is what everyone is testing
> anyway.

Only this patch is needed, all other patches have been in Linus' tree
since v3.13-rc1.
