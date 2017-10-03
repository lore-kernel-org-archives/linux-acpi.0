From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 03 Oct 2017 13:39:22 +0200
Message-ID: <5437275.MVdmGJ04h3@aspire.rjw.lan>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr> <1668017.YFhvic4TWu@aspire.rjw.lan> <20171002211622.30d324ca@blatinox-laptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44050 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751104AbdJCLsm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Oct 2017 07:48:42 -0400
In-Reply-To: <20171002211622.30d324ca@blatinox-laptop.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=E9my?= Lefaure <jeremy.lefaure@lse.epita.fr>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

On Tuesday, October 3, 2017 3:16:22 AM CEST Jérémy Lefaure wrote:
> On Mon, 02 Oct 2017 14:27:52 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > ACPICA is soewhat special code, though and I'm not taking or ACKing patches
> > for it directly as a rule.
> > 
> > For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
> Why is it special code that can't use ARRAY_SIZE ? Is it because this
> macro is defined in linux/kernel.h ?

Basically, yes.

ACPICA is a separate project and the kernel acquires its source code from
the upstream (which is used by other OSes too).  That is not the case for
any other code in the kernel I know about.


We strive to keep the ACPICA code in the kernel as close to the upstream as
reasonably possible for maintenance reasons, so we avoid doing Linux-specific
things in it.

As a rule of thumb, if you do cleanups like this one, better avoid the ACPICA
code. :-)

Thanks,
Rafael

