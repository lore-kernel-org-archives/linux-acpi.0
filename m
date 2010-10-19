From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH RESEND] ACPI dock: move some functions to .init.text
Date: Tue, 19 Oct 2010 08:48:38 -0700
Message-ID: <20101019154838.GF4589@kroah.com>
References: <1277127073-10485-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1287472419-13187-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287472419-13187-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 19, 2010 at 09:13:39AM +0200, Uwe Kleine-K=F6nig wrote:
> find_dock and find_bay are only called by dock_init which lives in
> .init.text dock_add is only called by find_dock and find_bay.  So all
> three functions can be moved to .init.text, too.
>=20
> This fixes:
>=20
>         WARNING: vmlinux.o(.text+0x2134b7): Section mismatch in refer=
ence from the function dock_add() to the function .init.text:platform_d=
evice_register_resndata()
>         The function dock_add() references
>         the function __init platform_device_register_resndata().
>         This is often because dock_add lacks a __init
>         annotation or the annotation of platform_device_register_resn=
data is wrong.
>=20
> for a build with unset CONFIG_MODULES.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
