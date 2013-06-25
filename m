From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Tue, 25 Jun 2013 22:49:14 +0100
Message-ID: <20130625214914.GA3654@srcf.ucam.org>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
 <1371937599.17761.19.camel@scapa>
 <20130625160848.GA27123@srcf.ucam.org>
 <1372193037.8189.24.camel@scapa>
 <20130625205430.GA2438@srcf.ucam.org>
 <1372194611.8189.31.camel@scapa>
 <20130625211415.GA2899@srcf.ucam.org>
 <1372195837.8189.42.camel@scapa>
 <20130625213300.GA3296@srcf.ucam.org>
 <1372196761.8189.47.camel@scapa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:60092 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab3FYVtR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2013 17:49:17 -0400
Content-Disposition: inline
In-Reply-To: <1372196761.8189.47.camel@scapa>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: linux-acpi@vger.kernel.org, seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, Henrique de Moraes Holschuh <hmh@debian.org>

On Tue, Jun 25, 2013 at 11:46:01PM +0200, Yves-Alexis Perez wrote:
> But if that introduce regressions, shouldn't workarounds be found the=
n?
> Sorry if I keep repeating that but brightness keys handling in-kernel=
 is
> quite a useful feature and losing it (because of the =E2=80=9Cbehave =
exactly
> like Windows 8 kernel=E2=80=9D policy) is indeed a regression.

Your firmware behaves differently depending on whether the OS claims to=
=20
be Windows 8 or not. We can't make that invisible.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
