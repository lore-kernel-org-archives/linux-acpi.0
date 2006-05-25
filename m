From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Dell Inspiron 6000: Suspend with Fn + F1 keys using acpid
Date: Thu, 25 May 2006 14:06:28 +0100
Message-ID: <20060525130628.GA18414@srcf.ucam.org>
References: <S932666AbWEXJol/20060524094441Z+163@vger.kernel.org> <200605241219.46413.sebastian.roeder@uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:37842 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965144AbWEYNGd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 May 2006 09:06:33 -0400
Content-Disposition: inline
In-Reply-To: <200605241219.46413.sebastian.roeder@uni-bielefeld.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian =?iso-8859-1?Q?R=F6der?= <sebastian.roeder@uni-bielefeld.de>
Cc: linux-acpi@vger.kernel.org

On Wed, May 24, 2006 at 12:19:46PM +0200, Sebastian R=F6der wrote:

> My question is how can I "workaround" this problem, e.g. create a ACP=
I event=20
> for this buttons (kernel patch?) or make acpid work with a normal key=
code=20
> rather than an ACPI event? I can not work on the kernel code myself c=
ause I=20
> am not skilled in C language :-(

You can't - at least, not in any trivial manner. If you're using recent=
=20
versions of hal, you'll get a dbus signal when the hibernate key is=20
pressed (assuming your keymap is set up correctly), and then you can us=
e=20
something like gnome-power-manager or kpowersave to receive that and=20
trigger the response you want.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
