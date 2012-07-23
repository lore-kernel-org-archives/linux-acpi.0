From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Mon, 23 Jul 2012 14:34:52 +0100
Message-ID: <20120723133452.GA21838@srcf.ucam.org>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
 <20120713064801.GA4910@srcf.ucam.org>
 <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
 <20120713071355.GA5516@srcf.ucam.org>
 <20120713141248.GE7877@khazad-dum.debian.net>
 <CAMz9Wg-0Fzz8aeEqYpPRmVqDuFSTtOv=k7m6k1O0r7YB88zRuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57767 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab2GWNe5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jul 2012 09:34:57 -0400
Content-Disposition: inline
In-Reply-To: <CAMz9Wg-0Fzz8aeEqYpPRmVqDuFSTtOv=k7m6k1O0r7YB88zRuQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Jul 16, 2012 at 10:27:57AM +0800, AceLan Kao wrote:

> So, I didn't get the point why we can just remove the event, we don't rely on it
> to enter S3 now, and to take into account that it's deprecated since
> 2007(fb804714),
> I don't think we should do more workaround for this.

I've no objection to removing the event, I just want to know why we 
don't also need a solution in the evdev path. Why is this not a problem 
there?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
