From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Common boot/shutdown issues with the latest 2.6.37 (Mostly Asus laptops)
Date: Sun, 30 Jan 2011 23:48:40 +0100
Message-ID: <201101302348.40509.rjw@sisk.pl>
References: <556624.21214.qm@web28409.mail.ukl.yahoo.com> <4D445319.5020803@pardus.org.tr> <4D45CA6F.8000002@pardus.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D45CA6F.8000002@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
To: Ozan =?utf-8?q?=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Cc: Lionel Debroux <lionel_debroux@yahoo.fr>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, colin.king@canonical.com
List-Id: linux-acpi@vger.kernel.org

On Sunday, January 30, 2011, Ozan =C3=87a=C4=9Flayan wrote:
> On 29.01.2011 19:49, Ozan =C3=87a=C4=9Flayan wrote:
>=20
> > intel_idle enabled and the patch above applied. Got 1 feedback for =
now
> > which tells that 1 out of 2 shutdown attempts failed. This is on As=
us
> > N61JQ (https://bugzilla.kernel.org/show_bug.cgi?id=3D27412).
> >
> >
>=20
> intel_idle + patch above doesn't help to the boot hang of Asus X61S.

Does booting with "nolapic" help on all of the affected systems?

Also, does disabling the CPUidle during boot help?

=46inally, is the problem reproducible with CONFIG_NO_HZ unset?

Rafael
