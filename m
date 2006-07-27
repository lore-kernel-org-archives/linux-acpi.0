From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: non functionable snd-ad1816a in Kernel 2.6.18-rc2
Date: Thu, 27 Jul 2006 09:11:36 -0600
Message-ID: <200607270911.37236.bjorn.helgaas@hp.com>
References: <20060718093434.60450@gmx.net> <200607241340.56353.bjorn.helgaas@hp.com> <20060727134555.235500@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:7639 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751647AbWG0PLm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jul 2006 11:11:42 -0400
In-Reply-To: <20060727134555.235500@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: ambx1@neo.rr.com, len.brown@intel.com, linux-acpi@vger.kernel.org, castet.matthieu@free.fr, akpm@osdl.org

On Thursday 27 July 2006 07:45, Uwe Bugla wrote:
> But how can we make sure that it does not break somebody
> else=B4s system while fixing mine when anything deriving
> from the two Intel guys is NAK?

I don't understand.  The idea is that people will test
the -mm kernel and report any problems. =20

> If they would be a bit more cooperative things would go
> forward much faster I think.=20

I think it's going about the right pace.  Usually things
stay in -mm for at least a month before we think about
putting them upstream.  And of course we don't push minor
bugfixes upstream when we're close to an upstream release.

Bjorn
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
