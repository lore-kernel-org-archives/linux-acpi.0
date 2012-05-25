From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gpu: remove gma500 stub driver
Date: Fri, 25 May 2012 16:07:17 +0900
Message-ID: <20120525070717.GB16955@kroah.com>
References: <1337910644-21694-1-git-send-email-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35400 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab2EYHH3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 May 2012 03:07:29 -0400
Received: by pbbrp8 with SMTP id rp8so1378895pbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 25 May 2012 00:07:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337910644-21694-1-git-send-email-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, randy.dunlap@oracle.com, mjg59@srcf.ucam.org, gregkh@suse.de, trenn@suse.de, Valdis.Kletnieks@vt.edu, Dennis.Jansen@web.de, airlied@redhat.com, eric@anholt.net, alexdeucher@gmail.com, bskeggs@redhat.com, chris@chris-wilson.co.uk

On Fri, May 25, 2012 at 09:50:44AM +0800, Lee, Chun-Yi wrote:
> In v3.3, the gma500 drm driver moved from staging to drm group by
> Alan Cox's 3abcf41fb patch. the gma500 drm driver should control
> brightness well and don't need gma500 stub driver anymore.
> 
> Cc: randy.dunlap@oracle.com
> Cc: mjg59@srcf.ucam.org
> Cc: gregkh@suse.de

Note, my email address has changed :)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

